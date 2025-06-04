-- Script g�n�r� par WINDEV Suite SaaS le 01/04/2025 14:55:30
-- Tables de l'analyse Projet 1 - SLAM.wda
-- pour MySQL

-- Cr�ation de la table clinique
CREATE TABLE `clinique` (
    `IDclinique` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(100) NOT NULL,
    `Adresse` NVARCHAR(50) NOT NULL,
    `type` VARCHAR(20) NOT NULL);

-- Cr�ation de la table m�decin
CREATE TABLE `m�decin` (
    `IDm�decin` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `sp�cialiste` VARCHAR(50) NOT NULL,
    `num�ro_professionnel` INTEGER NOT NULL DEFAULT 0,
    `IDutilisateur` BIGINT,
    `nom` VARCHAR(50) NOT NULL,
    `prenom` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `IDclinique` BIGINT);
CREATE INDEX `WDIDX_m�decin_IDutilisateur` ON `m�decin` (`IDutilisateur`);
CREATE INDEX `WDIDX_m�decin_IDclinique` ON `m�decin` (`IDclinique`);

-- Cr�ation de la table m�dicament
CREATE TABLE `m�dicament` (
    `IDm�dicament` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(100) NOT NULL,
    `description` LONGTEXT NOT NULL,
    `posologie` VARCHAR(100) NOT NULL,
    `effets_secondaires` LONGTEXT NOT NULL);

-- Cr�ation de la table ordonnance
CREATE TABLE `ordonnance` (
    `IDordonnance` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `date_prescription` DATE NOT NULL,
    `IDpatient` BIGINT,
    `IDm�decin` BIGINT);
CREATE INDEX `WDIDX_ordonnance_IDpatient` ON `ordonnance` (`IDpatient`);
CREATE INDEX `WDIDX_ordonnance_IDm�decin` ON `ordonnance` (`IDm�decin`);

-- Cr�ation de la table patient
CREATE TABLE `patient` (
    `IDpatient` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `photodeprofil` LONGBLOB NOT NULL,
    `num�ro_s�curit�_sociale` BIGINT NOT NULL DEFAULT 0,
    `telephone` INTEGER NOT NULL DEFAULT 0,
    `personne_a_acontacter` VARCHAR(50) NOT NULL,
    `IDutilisateur` BIGINT,
    `M�decin_traitant` BIGINT UNIQUE);
CREATE INDEX `WDIDX_patient_IDutilisateur` ON `patient` (`IDutilisateur`);

-- Cr�ation de la table prescription
CREATE TABLE `prescription` (
    `IDprescription` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `dosage` VARCHAR(50) NOT NULL,
    `frequence` VARCHAR(50) NOT NULL,
    `dur�e` VARCHAR(50),
    `IDm�dicament` BIGINT,
    `IDordonnance` BIGINT UNIQUE);
CREATE INDEX `WDIDX_prescription_IDm�dicament` ON `prescription` (`IDm�dicament`);

-- Cr�ation de la table rendez_vous
CREATE TABLE `rendez_vous` (
    `IDRDV` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `date_heure` DATE NOT NULL,
    `type_intervention` BIGINTDEFAULT 0,
    `option` BIGINTDEFAULT 0);
CREATE INDEX `WDIDX_rendez_vous_type_intervention` ON `rendez_vous` (`type_intervention`);
CREATE INDEX `WDIDX_rendez_vous_option` ON `rendez_vous` (`option`);

-- Cr�ation de la table r�servation
CREATE TABLE `r�servation` (
    `IDr�servation` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `date_d�but` DATE,
    `date_fin` DATE NOT NULL,
    `IDpatient` BIGINT);
CREATE INDEX `WDIDX_r�servation_IDpatient` ON `r�servation` (`IDpatient`);

-- Cr�ation de la table role
CREATE TABLE `role` (
    `IDrole` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(50) NOT NULL);

-- Cr�ation de la table statut
CREATE TABLE `statut` (
    `IDstatut` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `type_option` VARCHAR(50) NOT NULL);

-- Cr�ation de la table type_intervention
CREATE TABLE `type_intervention` (
    `IDtype_intervention` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL);

-- Cr�ation de la table utilisateur
-- Le type "Mot de passe" de la rubrique "mot_de_passe" n'est pas support�.


-- Script partiel

CREATE TABLE `utilisateur` (
    `IDutilisateur` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL,
    `pr�nom` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
,
    `date_cr�ation` TIMESTAMP,
    `IDrole` BIGINT);
CREATE INDEX `WDIDX_utilisateur_IDrole` ON `utilisateur` (`IDrole`);
-- Contraintes d'int�grit�
ALTER TABLE `patient` ADD FOREIGN KEY (`IDutilisateur`) REFERENCES `utilisateur` (`IDutilisateur`) ON DELETE CASCADE;
ALTER TABLE `m�decin` ADD FOREIGN KEY (`IDutilisateur`) REFERENCES `utilisateur` (`IDutilisateur`) ON DELETE CASCADE;
ALTER TABLE `utilisateur` ADD FOREIGN KEY (`IDrole`) REFERENCES `role` (`IDrole`);
ALTER TABLE `patient` ADD FOREIGN KEY (`M�decin_traitant`) REFERENCES `m�decin` (`IDm�decin`) ON DELETE CASCADE;
ALTER TABLE `rendez_vous` ADD FOREIGN KEY (`type_intervention`) REFERENCES `type_intervention` (`IDtype_intervention`);
ALTER TABLE `rendez_vous` ADD FOREIGN KEY (`option`) REFERENCES `statut` (`IDstatut`);
ALTER TABLE `ordonnance` ADD FOREIGN KEY (`IDpatient`) REFERENCES `patient` (`IDpatient`);
ALTER TABLE `prescription` ADD FOREIGN KEY (`IDordonnance`) REFERENCES `ordonnance` (`IDordonnance`) ON DELETE CASCADE;
ALTER TABLE `r�servation` ADD FOREIGN KEY (`IDpatient`) REFERENCES `patient` (`IDpatient`);
ALTER TABLE `prescription` ADD FOREIGN KEY (`IDm�dicament`) REFERENCES `m�dicament` (`IDm�dicament`);
ALTER TABLE `ordonnance` ADD FOREIGN KEY (`IDm�decin`) REFERENCES `m�decin` (`IDm�decin`) ON DELETE CASCADE;
ALTER TABLE `m�decin` ADD FOREIGN KEY (`IDclinique`) REFERENCES `clinique` (`IDclinique`) ON DELETE CASCADE;
