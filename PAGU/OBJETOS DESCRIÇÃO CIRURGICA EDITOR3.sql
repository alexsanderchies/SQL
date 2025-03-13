PROMPT CREATE OR REPLACE PROCEDURE prc_insere_prestador_aviso_doc
CREATE OR REPLACE PROCEDURE prc_insere_prestador_aviso_doc (
P_CD_AVISO_CIRURGIA NUMBER,
P_CD_ATI_MED        VARCHAR,
P_CD_PRESTADOR      NUMBER,
P_CD_CIRURGIA       NUMBER,
P_SN_PRINCIPAL      VARCHAR2,
P_CD_CIRURGIA_AVISO VARCHAR2
)


AS
BEGIN

INSERT INTO DBAMV.PRESTADOR_AVISO

VALUES (
        P_CD_AVISO_CIRURGIA,    --cd_aviso_cirurgia
        P_CD_ATI_MED,           --cd_ati_med
        P_CD_PRESTADOR,         --cd_prestador
        'P',                    --tp_pagamento
        P_CD_CIRURGIA,          --cd_cirurgia
        NULL,                   --nm_prestador
        P_SN_PRINCIPAL,         --sn_principal
        P_CD_CIRURGIA_AVISO,    --cd_cirurgia_aviso
        NULL                    --tp_pagamento_sugerido
);
COMMIT;
	END;
/

GRANT EXECUTE ON prc_insere_prestador_aviso_doc TO dbaportal;
GRANT EXECUTE ON prc_insere_prestador_aviso_doc TO dbaps;
GRANT EXECUTE ON prc_insere_prestador_aviso_doc TO dbasgu;
GRANT EXECUTE ON prc_insere_prestador_aviso_doc TO editor;
GRANT EXECUTE ON prc_insere_prestador_aviso_doc TO editor_custom;
GRANT EXECUTE ON prc_insere_prestador_aviso_doc TO mv2000;
GRANT EXECUTE ON prc_insere_prestador_aviso_doc TO mvintegra;



PROMPT CREATE OR REPLACE PROCEDURE prc_insere_cirurgia_aviso_doc
CREATE OR REPLACE PROCEDURE prc_insere_cirurgia_aviso_doc (
P_CD_AVISO_CIRURGIA  NUMBER,
P_CD_CIRURGIA       NUMBER,
P_CD_VIA_DE_ACESSO  NUMBER,
P_CD_CONVENIO       NUMBER,
P_SN_PRINCIPAL      VARCHAR2,
P_TP_NATUREZA       VARCHAR2,
P_DS_LATERALIDADE   VARCHAR2

)


AS
BEGIN

INSERT INTO DBAMV.CIRURGIA_AVISO

VALUES (
        P_CD_AVISO_CIRURGIA,            --cd_aviso_cirurgia
        P_CD_CIRURGIA,                  --cd_cirurgia
        P_CD_VIA_DE_ACESSO,             --cd_via_de_acesso
        P_CD_CONVENIO,                  --cd_convenio
        NULL,                           --cd_importa_reg_fat
        NULL,                           --cd_importa_reg_amb
        NULL,                           --cd_especialid
        NULL,                           --tp_convenio_atendime
        NULL,                           --ds_observacao
        NULL,                           --cd_con_pla
        NULL,                           --cd_tip_acom
        NULL,                           --ds_con_pla
        NULL,                           --sn_pacote
        NULL,                           --ds_npadronizado
        seq_cirurgia_aviso.nextval,     --cd_cirurgia_aviso
        P_SN_PRINCIPAL,                 --sn_principal
        NULL,                           --vl_percentual_acresc
        NULL,                           --cd_cbos
        P_TP_NATUREZA,                  --tp_natureza
        'N',                            --sn_antimicrob_profilatico
        NULL,                           --cd_seq_integra
        NULL,                           --cd_aviso_cirurgia_integra
        NULL,                           --dt_integra
        NULL,                           --cd_descricao_aviso_cirurgia
        P_DS_LATERALIDADE,              --ds_lateralidade
        NULL,                           --sn_reop
        NULL,                           --cd_natureza_cirurgia
        NULL,                           --cd_sub_grupo_cirurgia
        NULL,                           --cd_grupo_cirurgia
        NULL,                           --ds_orientacao
        NULL,                           --ds_preparo
        NULL,                           --tp_cirurgia
        NULL,                           --cd_porte_cirurgia
        NULL                            --nr_horas_padrao


);
COMMIT;
	END;
/

GRANT EXECUTE ON prc_insere_cirurgia_aviso_doc TO dbaportal;
GRANT EXECUTE ON prc_insere_cirurgia_aviso_doc TO dbaps;
GRANT EXECUTE ON prc_insere_cirurgia_aviso_doc TO dbasgu;
GRANT EXECUTE ON prc_insere_cirurgia_aviso_doc TO editor;
GRANT EXECUTE ON prc_insere_cirurgia_aviso_doc TO editor_custom;
GRANT EXECUTE ON prc_insere_cirurgia_aviso_doc TO mv2000;
GRANT EXECUTE ON prc_insere_cirurgia_aviso_doc TO mvintegra;


PROMPT CREATE OR REPLACE PROCEDURE prc_delete_cirurgia_aviso_doc
CREATE OR REPLACE PROCEDURE prc_delete_cirurgia_aviso_doc
(
	P_CD_CIRURGIA_AVISO INTEGER
)

IS
	l_msg 		VARCHAR2(32000);
BEGIN
	BEGIN
		DELETE FROM
			DBAMV.CIRURGIA_AVISO
		WHERE
			cd_cirurgia_aviso = P_CD_CIRURGIA_AVISO;
		EXCEPTION
			WHEN OTHERS THEN
				l_msg := 'Erro: ' || SQLERRM;
				RAISE_APPLICATION_ERROR(-20003, l_msg);
	END;
	COMMIT;
END;
/

GRANT EXECUTE ON prc_delete_cirurgia_aviso_doc TO dbaps;
GRANT EXECUTE ON prc_delete_cirurgia_aviso_doc TO dbasgu;
GRANT EXECUTE ON prc_delete_cirurgia_aviso_doc TO editor;
GRANT EXECUTE ON prc_delete_cirurgia_aviso_doc TO editor_custom;
GRANT EXECUTE ON prc_delete_cirurgia_aviso_doc TO mv2000;
GRANT EXECUTE ON prc_delete_cirurgia_aviso_doc TO mvintegra;


PROMPT CREATE OR REPLACE PROCEDURE prc_delete_prestador_aviso_doc
CREATE OR REPLACE PROCEDURE prc_delete_prestador_aviso_doc
(
	P_CD_CIRURGIA_AVISO INTEGER,
  P_CD_ATI_MED        VARCHAR
)

IS
	l_msg 		VARCHAR2(32000);
BEGIN
	BEGIN
		DELETE FROM
			DBAMV.PRESTADOR_AVISO
		WHERE
			  PRESTADOR_AVISO.cd_cirurgia_aviso = P_CD_CIRURGIA_AVISO
    AND PRESTADOR_AVISO.CD_ATI_MED = P_CD_ATI_MED;
		EXCEPTION
			WHEN OTHERS THEN
				l_msg := 'Erro: ' || SQLERRM;
				RAISE_APPLICATION_ERROR(-20003, l_msg);
	END;
	COMMIT;
END;
/

GRANT EXECUTE ON prc_delete_prestador_aviso_doc TO dbaps;
GRANT EXECUTE ON prc_delete_prestador_aviso_doc TO dbasgu;
GRANT EXECUTE ON prc_delete_prestador_aviso_doc TO editor;
GRANT EXECUTE ON prc_delete_prestador_aviso_doc TO editor_custom;
GRANT EXECUTE ON prc_delete_prestador_aviso_doc TO mv2000;
GRANT EXECUTE ON prc_delete_prestador_aviso_doc TO mvintegra;
