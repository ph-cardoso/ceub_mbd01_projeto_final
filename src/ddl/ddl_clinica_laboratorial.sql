-- -----------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------ INFO DDL -------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------

-- Projeto Final: Clínica Laboratorial
-- Script de Criação
-- Last update: 04/05/2022

-- -----------------------------------------------------------------------------------------------------------------
-- ------------------------------------------- CRIAÇÃO DO SCHEMA ---------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `clinica_laboratorial`;

CREATE SCHEMA IF NOT EXISTS `clinica_laboratorial` DEFAULT CHARACTER SET utf8mb4;

USE `clinica_laboratorial`;

-- -----------------------------------------------------------------------------------------------------------------
-- ------------------------------------------ CRIAÇÃO DAS TABELAS --------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------

-- TB_PACIENTE
DROP TABLE IF EXISTS `TB_PACIENTE`;

CREATE TABLE IF NOT EXISTS `TB_PACIENTE` (
  `id_paciente` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(11) NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `dt_nascimento` DATE NULL,
  PRIMARY KEY (`id_paciente`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`));

-- TB_CONVENIO
DROP TABLE IF EXISTS `TB_CONVENIO`;

CREATE TABLE IF NOT EXISTS `TB_CONVENIO` (
  `id_convenio` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `cnpj` VARCHAR(45) NOT NULL,
  `taxa_coparticipacao` DECIMAL(4,3) NOT NULL,
  PRIMARY KEY (`id_convenio`),
  UNIQUE KEY `cnpj_UNIQUE` (`cnpj`));

-- TB_EXAME
DROP TABLE IF EXISTS `TB_EXAME`;

CREATE TABLE IF NOT EXISTS `TB_EXAME` (
  `id_exame` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `descricao` VARCHAR(1000) NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_exame`));

-- TB_MEDICO
DROP TABLE IF EXISTS `TB_MEDICO`;

CREATE TABLE IF NOT EXISTS `TB_MEDICO` (
  `id_medico` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `crm` VARCHAR(9) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_medico`),
  UNIQUE KEY `crm_UNIQUE` (`crm`));

-- TB_REGISTRO_EXAME
DROP TABLE IF EXISTS `TB_REGISTRO_EXAME`;

CREATE TABLE IF NOT EXISTS `TB_REGISTRO_EXAME` (
  `id_registro` INT NOT NULL AUTO_INCREMENT,
  `id_paciente` INT NOT NULL,
  `id_exame` INT NOT NULL,
  `id_medico` INT NOT NULL,
  `id_convenio` INT,
  `dthora_realizacao` DATETIME NOT NULL,
  PRIMARY KEY (`id_registro`));

-- TB_ESPECIALIDADE
DROP TABLE IF EXISTS `TB_ESPECIALIDADE`;

CREATE TABLE IF NOT EXISTS `TB_ESPECIALIDADE` (
  `id_especialidade` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_especialidade`));

-- TB_MEDICO_ESPECIALIDADE
DROP TABLE IF EXISTS `TB_MEDICO_ESPECIALIDADE`;

CREATE TABLE IF NOT EXISTS `TB_MEDICO_ESPECIALIDADE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_medico` INT NOT NULL,
  `id_especialidade` INT NOT NULL,
  PRIMARY KEY (`id`));

-- TB_TIPO_DEBITO
DROP TABLE IF EXISTS `TB_TIPO_DEBITO`;

CREATE TABLE IF NOT EXISTS `TB_TIPO_DEBITO` (
  `id_tipo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_tipo`));

-- TB_DEBITO
DROP TABLE IF EXISTS `TB_DEBITO`;

CREATE TABLE IF NOT EXISTS `TB_DEBITO` (
  `id_debito` INT NOT NULL AUTO_INCREMENT,
  `id_tipo` INT NOT NULL,
  `id_registro` INT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `dthora_registro` DATETIME NOT NULL,
  `dthora_pagamento` DATETIME,
  PRIMARY KEY (`id_debito`));

-- -----------------------------------------------------------------------------------------------------------------
-- --------------------------------------- CRIAÇÃO DAS FOREIGN KEYS ------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------

-- TB_REGISTRO_EXAME
ALTER TABLE `TB_REGISTRO_EXAME` ADD FOREIGN KEY `id_paciente_fk` (`id_paciente`) REFERENCES `TB_PACIENTE` (`id_paciente`);

ALTER TABLE `TB_REGISTRO_EXAME` ADD FOREIGN KEY `id_exame_fk` (`id_exame`) REFERENCES `TB_EXAME` (`id_exame`);

ALTER TABLE `TB_REGISTRO_EXAME` ADD FOREIGN KEY `id_convenio_fk` (`id_convenio`) REFERENCES `TB_CONVENIO` (`id_convenio`);

ALTER TABLE `TB_REGISTRO_EXAME` ADD FOREIGN KEY `id_medico_fk` (`id_medico`) REFERENCES `TB_MEDICO` (`id_medico`);

-- TB_MEDICO_ESPECIALIDADE
ALTER TABLE `TB_MEDICO_ESPECIALIDADE` ADD FOREIGN KEY `id_medico_fk` (`id_medico`) REFERENCES `TB_MEDICO` (`id_medico`);

ALTER TABLE `TB_MEDICO_ESPECIALIDADE` ADD FOREIGN KEY `id_especialidade_fk` (`id_especialidade`) REFERENCES `TB_ESPECIALIDADE` (`id_especialidade`);

-- TB_DEBITO
ALTER TABLE `TB_DEBITO` ADD FOREIGN KEY `id_tipo_fk` (`id_tipo`) REFERENCES `TB_TIPO_DEBITO` (`id_tipo`);

ALTER TABLE `TB_DEBITO` ADD FOREIGN KEY `id_registro_idx` (`id_registro`) REFERENCES `TB_REGISTRO_EXAME` (`id_registro`);

-- -----------------------------------------------------------------------------------------------------------------
-- ---------------------------------------- CRIAÇÃO DAS PROCEDURES -------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------

-- delete_all_data
DROP PROCEDURE IF EXISTS `delete_all_data`;

DELIMITER //

CREATE PROCEDURE `delete_all_data` ()

BEGIN
	SET `SQL_SAFE_UPDATES` = 0;

    -- TB_REGISTRO_EXAME
	DELETE FROM `TB_REGISTRO_EXAME`;
    ALTER TABLE `TB_REGISTRO_EXAME` AUTO_INCREMENT = 1;

    -- TB_MEDICO_ESPECIALIDADE
	DELETE FROM `TB_MEDICO_ESPECIALIDADE`;
    ALTER TABLE `TB_MEDICO_ESPECIALIDADE` AUTO_INCREMENT = 1;

    -- TB_ESPECIALIDADE
	DELETE FROM `TB_ESPECIALIDADE`;
    ALTER TABLE `TB_ESPECIALIDADE` AUTO_INCREMENT = 1;

    -- TB_MEDICO
	DELETE FROM `TB_MEDICO`;
    ALTER TABLE `TB_MEDICO` AUTO_INCREMENT = 1;

    -- TB_DEBITO
	DELETE FROM `TB_DEBITO`;
    ALTER TABLE `TB_DEBITO` AUTO_INCREMENT = 1;

    -- TB_TIPO_DEBITO
	DELETE FROM `TB_TIPO_DEBITO`;
    ALTER TABLE `TB_TIPO_DEBITO` AUTO_INCREMENT = 1;

    -- TB_EXAME
	DELETE FROM `TB_EXAME`;
    ALTER TABLE `TB_EXAME` AUTO_INCREMENT = 1;

    -- TB_PACIENTE
	DELETE FROM `TB_PACIENTE`;
    ALTER TABLE `TB_PACIENTE` AUTO_INCREMENT = 1;

    -- TB_CONVENIO
	DELETE FROM `TB_CONVENIO`;
    ALTER TABLE `TB_CONVENIO` AUTO_INCREMENT = 1;

    SET `SQL_SAFE_UPDATES` = 1;
END//

DELIMITER ;

-- insert_test_data
DROP PROCEDURE IF EXISTS `insert_test_data`;

DELIMITER //

CREATE PROCEDURE `insert_test_data` ()

BEGIN
    -- TB_PACIENTE
	INSERT INTO `TB_PACIENTE`
	(`nome`,`cpf`,`dt_nascimento`,`email`,`telefone`)
	VALUES
	('Fabiana Silvana Larissa Lima','97640286670',STR_TO_DATE('17-02-1959','%d-%m-%Y'),'fabiana-lima78@bb.com.br','64984916824'),
	('Caio Julio da Rocha','25198435783',STR_TO_DATE('24-04-1998','%d-%m-%Y'),'caio.julio.darocha@cfaraujo.eng.br','82983875690'),
	('Clarice Antônia Aparício','52549706935',STR_TO_DATE('01-01-1984','%d-%m-%Y'),'clarice-aparicio71@kascher.com.br','69985022159'),
	('Pedro Cauã Victor dos Santos','38929928943',STR_TO_DATE('26-03-1962','%d-%m-%Y'),'pedro_dossantos@yahoo.ie','82998577536'),
	('Diogo João Davi Pinto','68767268609',STR_TO_DATE('04-05-1996','%d-%m-%Y'),'diogo_pinto@mpc.com.br','85994994578'),
	('Cauê Erick Vicente Moreira','38139508322',STR_TO_DATE('15-04-1956','%d-%m-%Y'),'caue_erick_moreira@carreiradasilva.com','91986042943'),
	('Thomas Ruan Alves','01181257379',STR_TO_DATE('04-05-1942','%d-%m-%Y'),'thomasruanalves@origembr.com','27988958418'),
	('Matheus João Martins','33417307880',STR_TO_DATE('02-05-1954','%d-%m-%Y'), 'matheus_nmartins@yahoo.de','92994513595'),
	('Samuel Rodrigo Kauê Araújo','82594189758',STR_TO_DATE('01-03-1961','%d-%m-%Y'),'samuel-araujo94@atualmarcenaria.com.br','11997058864'),
	('Nicole Melissa Ana Assis','21640190406',STR_TO_DATE('02-05-1983','%d-%m-%Y'),'nicole_assis@ctlive.com.br','75993481878'),
	('Benedita Liz Esther Campos','09691584328',STR_TO_DATE('12-02-1993','%d-%m-%Y'),'benedita_campos@zian.com.br','41986629050'),
	('Jennifer Nina Figueiredo','41685853870',STR_TO_DATE('25-01-2000','%d-%m-%Y'),'jennifer_nina_figueiredo@athoscontabil.com.br','85997699993'),
	('Helena Elisa Aline Melo','91896087558',STR_TO_DATE('15-04-1986','%d-%m-%Y'),'helena_elisa_melo@yahoo.de','81988276204'),
	('Juan Nelson Cardoso','33202361058',STR_TO_DATE('27-03-1957','%d-%m-%Y'),'juan.nelson.cardoso@brastek.com.br','61981641490'),
	('Otávio Miguel Almeida','44577113147',STR_TO_DATE('27-04-1964','%d-%m-%Y'),'otavio.miguel.almeida@fosj.unesp.br','53994181241'),
	('Regina Marina Farias','88506482003',STR_TO_DATE('02-05-1962','%d-%m-%Y'),'regina.marina.farias@a-qualitybrasil.com.br','34994190635'),
	('Daniel Pedro Henrique da Costa','17402017605',STR_TO_DATE('02-05-1958','%d-%m-%Y'),'daniel_pedro_dacosta@veloxmail.com.br','61989639911'),
	('Caio Porto','42034877810',STR_TO_DATE('02-05-1950','%d-%m-%Y'),'caio_porto@alphagraphics.com.br','31986639825'),
	('Luiza Letícia Souza','30506005356',STR_TO_DATE('22-02-1956','%d-%m-%Y'),'luiza_leticia_souza@publifix.com.br','85982946300'),
	('Thiago Manoel Oliver Barbosa', '73141289441',STR_TO_DATE('09-03-1993','%d-%m-%Y'),'thiago_manoel_barbosa@centerdiesel.com.br','35984057475');

    -- TB_ESPECIALIDADE
    INSERT INTO `TB_ESPECIALIDADE`
	(`nome`)
	VALUES
	('Cardiologia'),
	('Angiologia'),
	('Dermatologia'),
	('Endocrinologia'),
	('Ginecologia'),
	('Urologia'),
	('Neurologia'),
	('Oftalmologia'),
	('Pediatria');

    -- TB_CONVENIO
    INSERT INTO `TB_CONVENIO`
	(`nome`,`cnpj`,`taxa_coparticipacao`)
	VALUES
	('Amil', '07517040000154', 0.25),
	('Unimed', '80590363000163', 0.305),
	('Cassi', '07530656000165', 0.15),
	('Bradesco', '46305732000190', 0.42),
	('Sulamerica', '21503041000170', 0.65),
	('PagBank', '12260171000139', 0.355);

    -- TB_TIPO_DEBITO
    INSERT INTO `TB_TIPO_DEBITO`
	(`nome`)
	VALUES
	('Pessoa Física'),
	('Convenio');

    -- TB_MEDICO
    INSERT INTO `TB_MEDICO`
	(`nome`,`crm`,`email`,`telefone`)
	VALUES
	("Eduardo Lucas Nunes","10413-PA","eduardo-nunes90@distribuidorapetfarm.com.br","68999159147"),
	("Giovanna Maria Castro","23153-PE","giovannamariacastro@sunrise.com.br","92984650591"),
	("Diego Vicente Márcio Rezende","154092-SP","diego_vicente_rezende@alway.com.br","69982782938"),
	("Melissa Silvana Ramos","103094-RJ","melissa_ramos@agenciaph.com","86999113876"),
	("Raul Luan Pinto","11831-SP","raul_pinto@plaman.com.br","84996986315"),
	("Raul Lima","10208-BA","raul_lima@yahoo.de","79988543256"),
	("Marcos Samuel Francisco Almada","12487-ES","marcossamuelalmada@yahoo.com.ar","83983605231"),
	("Benedita Sabrina Beatriz Ribeiro","209595-SP","benedita.sabrina.ribeiro@dedicasa.com.br","51999548803"),
	("Isabelle Rafaela Antônia Nogueira","2702-AC","isabelle_nogueira@iesa.com.br","84989774817"),
	("Ayla Stella Alícia Araújo","41090-RS","ayla.stella.araujo@mega-vale.com","83985329663");

    -- TB_MEDICO_ESPECIALIDADE
    INSERT INTO `TB_MEDICO_ESPECIALIDADE`
    (`id_medico`,`id_especialidade`)
    VALUES
    (1,1),
    (1,2),
    (2,4),
    (3,5),
    (4,5),
    (4,6),
    (5,5),
    (5,7),
    (6,8),
    (7,9),
    (7,2),
    (8,4),
    (8,7),
    (9,1),
    (9,5),
    (9,3);

    -- TB_EXAME
    INSERT INTO `TB_EXAME`
	(`nome`,`valor`)
	VALUES
	('Hemograma', 210.00),
	('Colesterol', 150.75),
	('Ureia', 128.90),
	('Papanicolau', 300.00),
	('Exame de Urina', 280.45),
	('Exame de Fezes', 230.89),
	('Glicemia', 199.21),
	('PCR', 380.80),
	('VHS', 310.00),
	('TGO', 267.80),
	('TGP', 246.00),
	('Ecocardiograma', 212.89),
	('Espirometria', 600.00);

    -- TB_REGISTRO_EXAME
    INSERT INTO `TB_REGISTRO_EXAME`
	(`id_paciente`,`id_exame`,`id_medico`,`id_convenio`,`dthora_realizacao`)
	VALUES
	(1,1,3,null,STR_TO_DATE('20/03/2020 10:00','%d/%m/%Y %H:%i')),
	(1,2,4,2,STR_TO_DATE('21/03/2020 11:00','%d/%m/%Y %H:%i')),
	(2,1,10,1,STR_TO_DATE('22/03/2020 12:30','%d/%m/%Y %H:%i')),
	(2,3,1,3,STR_TO_DATE('23/03/2020 10:00','%d/%m/%Y %H:%i')),
	(20,7,2,4,STR_TO_DATE('23/04/2020 09:00','%d/%m/%Y %H:%i')),
	(3,4,4,4,STR_TO_DATE('24/04/2020 14:40','%d/%m/%Y %H:%i')),
	(4,4,5,2,STR_TO_DATE('25/05/2020 14:00','%d/%m/%Y %H:%i')),
	(4,5,6,1,STR_TO_DATE('26/05/2020 14:30','%d/%m/%Y %H:%i')),
	(5,6,6,1,STR_TO_DATE('01/05/2020 15:00','%d/%m/%Y %H:%i')),
	(5,7,7,1,STR_TO_DATE('02/05/2020 15:00','%d/%m/%Y %H:%i')),
	(5,8,7,2,STR_TO_DATE('04/05/2020 15:30','%d/%m/%Y %H:%i')),
	(5,6,8,3,STR_TO_DATE('10/06/2020 16:00','%d/%m/%Y %H:%i')),
	(6,9,10,3,STR_TO_DATE('12/06/2020 16:00','%d/%m/%Y %H:%i')),
	(6,10,9,4,STR_TO_DATE('13/06/2020 10:00','%d/%m/%Y %H:%i')),
	(7,11,9,4,STR_TO_DATE('14/06/2020 17:00','%d/%m/%Y %H:%i')),
	(8,12,8,5,STR_TO_DATE('26/07/2020 17:00','%d/%m/%Y %H:%i')),
	(8,13,8,5,STR_TO_DATE('30/07/2020 17:00','%d/%m/%Y %H:%i')),
	(8,11,5,5,STR_TO_DATE('02/07/2020 17:30','%d/%m/%Y %H:%i')),
	(18,10,3,null,STR_TO_DATE('04/08/2020 14:00','%d/%m/%Y %H:%i')),
	(9,6,2,null,STR_TO_DATE('05/08/2020 11:00','%d/%m/%Y %H:%i')),
	(9,6,1,null,STR_TO_DATE('06/08/2020 11:30','%d/%m/%Y %H:%i')),
	(19,5,1,6,STR_TO_DATE('11/09/2020 15:00','%d/%m/%Y %H:%i')),
	(10,5,2,6,STR_TO_DATE('12/10/2020 15:00','%d/%m/%Y %H:%i')),
	(11,4,10,6,STR_TO_DATE('07/10/2020 16:00','%d/%m/%Y %H:%i')),
	(11,4,10,1,STR_TO_DATE('09/10/2020 09:00','%d/%m/%Y %H:%i')),
	(17,3,10,2,STR_TO_DATE('10/10/2020 09:00','%d/%m/%Y %H:%i')),
	(11,2,7,2,STR_TO_DATE('12/11/2020 09:30','%d/%m/%Y %H:%i')),
	(11,10,7,4,STR_TO_DATE('06/11/2020 09:40','%d/%m/%Y %H:%i')),
	(11,9,6,4,STR_TO_DATE('29/11/2020 10:00','%d/%m/%Y %H:%i')),
	(11,9,6,5,STR_TO_DATE('28/12/2020 14:00','%d/%m/%Y %H:%i')),
	(12,8,4,6,STR_TO_DATE('24/02/2021 15:00','%d/%m/%Y %H:%i')),
	(12,8,4,null,STR_TO_DATE('02/02/2021 16:00','%d/%m/%Y %H:%i')),
	(12,12,5,null,STR_TO_DATE('03/01/2021 16:00','%d/%m/%Y %H:%i')),
	(12,13,8,null,STR_TO_DATE('04/03/2021 16:00','%d/%m/%Y %H:%i')),
	(13,13,9,2,STR_TO_DATE('05/04/2021 16:00','%d/%m/%Y %H:%i')),
	(13,12,9,null,STR_TO_DATE('07/04/2021 17:00','%d/%m/%Y %H:%i')),
	(14,11,9,1,STR_TO_DATE('10/05/2021 17:00','%d/%m/%Y %H:%i')),
	(14,10,10,null,STR_TO_DATE('12/07/2021 14:00','%d/%m/%Y %H:%i')),
	(15,13,1,5,STR_TO_DATE('13/08/2021 17:00','%d/%m/%Y %H:%i')),
	(16,5,2,null,STR_TO_DATE('16/10/2021 18:00','%d/%m/%Y %H:%i'));
END//

DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------
-- ----------------------------------------- CRIAÇÃO DOS TRIGGERS --------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------

-- tg_ai_insert_debito
DROP TRIGGER IF EXISTS `tg_ai_insert_debito`;

DELIMITER //

CREATE TRIGGER `tg_ai_insert_debito`
    AFTER INSERT
    ON `TB_REGISTRO_EXAME` FOR EACH ROW
		BEGIN
			DECLARE valor DECIMAL(10,2);
            DECLARE coparticipacao DECIMAL (4,3);
			
            SELECT ex.valor FROM TB_EXAME AS ex WHERE ex.id_exame = NEW.id_exame INTO valor;
            SELECT cv.taxa_coparticipacao FROM TB_CONVENIO AS cv WHERE cv.id_convenio = NEW.id_convenio INTO coparticipacao;
			
			IF NEW.id_convenio IS NULL THEN
				INSERT INTO `TB_DEBITO`
                (`id_tipo`, `id_registro`, `valor`, `dthora_registro`, `dthora_pagamento`)
                VALUES
                (1,NEW.id_registro,valor, NOW(), null);
			ELSE
				INSERT INTO `TB_DEBITO`
                (`id_tipo`, `id_registro`, `valor`, `dthora_registro`, `dthora_pagamento`)
                VALUES
                (1,NEW.id_registro,(valor * coparticipacao), NOW(), null);
                
                INSERT INTO `TB_DEBITO`
                (`id_tipo`, `id_registro`, `valor`, `dthora_registro`, `dthora_pagamento`)
                VALUES
                (2,NEW.id_registro,(valor * (1-coparticipacao)), NOW(), null);
            END IF;
        END//        
        
DELIMITER ;