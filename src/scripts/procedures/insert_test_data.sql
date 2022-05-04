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
END//

DELIMITER ;