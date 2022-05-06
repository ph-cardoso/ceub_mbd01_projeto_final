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