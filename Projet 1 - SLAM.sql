-- Script généré par WINDEV Suite SaaS le 01/04/2025 14:55:30
-- Tables de l'analyse Projet 1 - SLAM.wda
-- pour MySQL

-- Création de la table clinique
CREATE TABLE `clinique` (
    `IDclinique` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(100) NOT NULL,
    `Adresse` NVARCHAR(50) NOT NULL,
    `type` VARCHAR(20) NOT NULL);

-- Création de la table médecin
CREATE TABLE `médecin` (
    `IDmédecin` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `spécialiste` VARCHAR(50) NOT NULL,
    `numéro_professionnel` INTEGER NOT NULL DEFAULT 0,
    `IDutilisateur` BIGINT,
    `nom` VARCHAR(50) NOT NULL,
    `prenom` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `IDclinique` BIGINT);
CREATE INDEX `WDIDX_médecin_IDutilisateur` ON `médecin` (`IDutilisateur`);
CREATE INDEX `WDIDX_médecin_IDclinique` ON `médecin` (`IDclinique`);

-- Création de la table médicament
CREATE TABLE `médicament` (
    `IDmédicament` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(100) NOT NULL,
    `description` LONGTEXT NOT NULL,
    `posologie` VARCHAR(100) NOT NULL,
    `effets_secondaires` LONGTEXT NOT NULL);

-- Création de la table ordonnance
CREATE TABLE `ordonnance` (
    `IDordonnance` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `date_prescription` DATE NOT NULL,
    `IDpatient` BIGINT,
    `IDmédecin` BIGINT);
CREATE INDEX `WDIDX_ordonnance_IDpatient` ON `ordonnance` (`IDpatient`);
CREATE INDEX `WDIDX_ordonnance_IDmédecin` ON `ordonnance` (`IDmédecin`);

-- Création de la table patient
CREATE TABLE `patient` (
    `IDpatient` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `photodeprofil` LONGBLOB NOT NULL,
    `numéro_sécurité_sociale` BIGINT NOT NULL DEFAULT 0,
    `telephone` INTEGER NOT NULL DEFAULT 0,
    `personne_a_acontacter` VARCHAR(50) NOT NULL,
    `IDutilisateur` BIGINT,
    `Médecin_traitant` BIGINT UNIQUE);
CREATE INDEX `WDIDX_patient_IDutilisateur` ON `patient` (`IDutilisateur`);

-- Création de la table prescription
CREATE TABLE `prescription` (
    `IDprescription` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `dosage` VARCHAR(50) NOT NULL,
    `frequence` VARCHAR(50) NOT NULL,
    `durée` VARCHAR(50),
    `IDmédicament` BIGINT,
    `IDordonnance` BIGINT UNIQUE);
CREATE INDEX `WDIDX_prescription_IDmédicament` ON `prescription` (`IDmédicament`);

-- Création de la table rendez_vous
CREATE TABLE `rendez_vous` (
    `IDRDV` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `date_heure` DATE NOT NULL,
    `type_intervention` BIGINTDEFAULT 0,
    `option` BIGINTDEFAULT 0);
CREATE INDEX `WDIDX_rendez_vous_type_intervention` ON `rendez_vous` (`type_intervention`);
CREATE INDEX `WDIDX_rendez_vous_option` ON `rendez_vous` (`option`);

-- Création de la table réservation
CREATE TABLE `réservation` (
    `IDréservation` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `date_début` DATE,
    `date_fin` DATE NOT NULL,
    `IDpatient` BIGINT);
CREATE INDEX `WDIDX_réservation_IDpatient` ON `réservation` (`IDpatient`);

-- Création de la table role
CREATE TABLE `role` (
    `IDrole` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(50) NOT NULL);

-- Création de la table statut
CREATE TABLE `statut` (
    `IDstatut` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `type_option` VARCHAR(50) NOT NULL);

-- Création de la table type_intervention
CREATE TABLE `type_intervention` (
    `IDtype_intervention` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL);

-- Création de la table utilisateur
-- Le type "Mot de passe" de la rubrique "mot_de_passe" n'est pas supporté.


-- Script partiel

CREATE TABLE `utilisateur` (
    `IDutilisateur` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL,
    `prénom` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
,
    `date_création` TIMESTAMP,
    `IDrole` BIGINT);
CREATE INDEX `WDIDX_utilisateur_IDrole` ON `utilisateur` (`IDrole`);
-- Contraintes d'intégrité
ALTER TABLE `patient` ADD FOREIGN KEY (`IDutilisateur`) REFERENCES `utilisateur` (`IDutilisateur`) ON DELETE CASCADE;
ALTER TABLE `médecin` ADD FOREIGN KEY (`IDutilisateur`) REFERENCES `utilisateur` (`IDutilisateur`) ON DELETE CASCADE;
ALTER TABLE `utilisateur` ADD FOREIGN KEY (`IDrole`) REFERENCES `role` (`IDrole`);
ALTER TABLE `patient` ADD FOREIGN KEY (`Médecin_traitant`) REFERENCES `médecin` (`IDmédecin`) ON DELETE CASCADE;
ALTER TABLE `rendez_vous` ADD FOREIGN KEY (`type_intervention`) REFERENCES `type_intervention` (`IDtype_intervention`);
ALTER TABLE `rendez_vous` ADD FOREIGN KEY (`option`) REFERENCES `statut` (`IDstatut`);
ALTER TABLE `ordonnance` ADD FOREIGN KEY (`IDpatient`) REFERENCES `patient` (`IDpatient`);
ALTER TABLE `prescription` ADD FOREIGN KEY (`IDordonnance`) REFERENCES `ordonnance` (`IDordonnance`) ON DELETE CASCADE;
ALTER TABLE `réservation` ADD FOREIGN KEY (`IDpatient`) REFERENCES `patient` (`IDpatient`);
ALTER TABLE `prescription` ADD FOREIGN KEY (`IDmédicament`) REFERENCES `médicament` (`IDmédicament`);
ALTER TABLE `ordonnance` ADD FOREIGN KEY (`IDmédecin`) REFERENCES `médecin` (`IDmédecin`) ON DELETE CASCADE;
ALTER TABLE `médecin` ADD FOREIGN KEY (`IDclinique`) REFERENCES `clinique` (`IDclinique`) ON DELETE CASCADE;
