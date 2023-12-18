PROMPT CREATE OR REPLACE VIEW dbamv.pw_lista_meus_paciente
CREATE OR REPLACE VIEW dbamv.pw_lista_meus_paciente (
  "Atendimento",
  par_cd_atendimento,
  par_cd_paciente,
  "Paciente",
  "Idade",
  "Sexo",
  "Data Atendimento",
  "Medico",
  "Unidade de Internação",
  par_cd_setor
) AS
SELECT
ATENDIME.CD_ATENDIMENTO AS "Atendimento",
ATENDIME.CD_ATENDIMENTO AS PAR_CD_ATENDIMENTO,
ATENDIME.CD_PACIENTE AS PAR_CD_PACIENTE,
PACIENTE.NM_PACIENTE AS "Paciente",
--PACIENTE.DT_NASCIMENTO AS "Nascimento",
DBAMV.FN_IDADE(PACIENTE.DT_NASCIMENTO,'A a M m D d') AS "Idade",
-- PACIENTE.TP_SEXO AS "Tipo Sexo",
TIPO_SEXO.NM_SEXO AS "Sexo",
TO_CHAR(ATENDIME.DT_ATENDIMENTO, 'DD/MM/RRRR') AS "Data Atendimento",
-- TO_CHAR(ATENDIME.HR_ATENDIMENTO, 'HH24:MI') AS "Hora Atendimento",
-- ATENDIME.CD_PRESTADOR AS "Prestador",
PRESTADOR.NM_PRESTADOR AS "Medico",
-- LEITO.CD_UNID_INT AS "Cod Unid Internação",
Nvl(UNID_INT.DS_UNID_INT,SET_ORI.NM_SETOR) AS "Unidade de Internação",
-- ATENDIME.CD_LEITO AS "Cod Leito",
-- LEITO.DS_LEITO AS "Leito",
Nvl(UNID_INT.CD_SETOR,ORI_ATE.CD_SETOR) PAR_CD_SETOR
FROM ATENDIME
JOIN DBAMV.PACIENTE
ON ATENDIME.CD_PACIENTE = PACIENTE.CD_PACIENTE
JOIN DBAMV.PRESTADOR
ON ATENDIME.CD_PRESTADOR = PRESTADOR.CD_PRESTADOR
AND ATENDIME.CD_PRESTADOR = DBAMV.PKG_MVPEP_AREA_PESSOAL.FN_GET_CD_PRESTADOR()
LEFT JOIN DBAMV.LEITO
ON ATENDIME.CD_LEITO = LEITO.CD_LEITO
LEFT JOIN DBAMV.UNID_INT
ON LEITO.CD_UNID_INT = UNID_INT.CD_UNID_INT
JOIN DBAMV.TIPO_SEXO
ON PACIENTE.TP_SEXO = TIPO_SEXO.TP_SEXO
LEFT JOIN DBAMV.ORI_ATE
ON ATENDIME.CD_ORI_ATE = ORI_ATE.CD_ORI_ATE
LEFT JOIN DBAMV.SETOR SET_ORI 
ON ORI_ATE.CD_SETOR = SET_ORI.CD_SETOR 
WHERE DT_ALTA IS NULL
/
                                     
COMMENT ON TABLE dbamv.pw_lista_meus_paciente IS 'Lista meus Pacientes';

COMMENT ON COLUMN dbamv.pw_lista_meus_paciente."Atendimento" IS 'TAMANHO_20';
COMMENT ON COLUMN dbamv.pw_lista_meus_paciente.par_cd_atendimento IS 'TAMANHO_20';
COMMENT ON COLUMN dbamv.pw_lista_meus_paciente.par_cd_paciente IS 'TAMANHO_20';
COMMENT ON COLUMN dbamv.pw_lista_meus_paciente."Paciente" IS 'TAMANHO_20';
COMMENT ON COLUMN dbamv.pw_lista_meus_paciente."Idade" IS 'TAMANHO_20';
COMMENT ON COLUMN dbamv.pw_lista_meus_paciente."Sexo" IS 'TAMANHO_20';
COMMENT ON COLUMN dbamv.pw_lista_meus_paciente."Data Atendimento" IS 'TAMANHO_20';
COMMENT ON COLUMN dbamv.pw_lista_meus_paciente."Medico" IS 'TAMANHO_20';
COMMENT ON COLUMN dbamv.pw_lista_meus_paciente."Unidade de Internação" IS 'TAMANHO_20';
COMMENT ON COLUMN dbamv.pw_lista_meus_paciente.par_cd_setor IS 'TAMANHO_20';

GRANT SELECT ON dbamv.pw_lista_meus_paciente TO dbacp WITH GRANT OPTION;
GRANT SELECT ON dbamv.pw_lista_meus_paciente TO dbaportal WITH GRANT OPTION;
GRANT DELETE,INSERT,SELECT,UPDATE ON dbamv.pw_lista_meus_paciente TO dbaps;
GRANT DELETE,INSERT,SELECT,UPDATE ON dbamv.pw_lista_meus_paciente TO dbasgu;
GRANT DELETE,INSERT,SELECT,UPDATE ON dbamv.pw_lista_meus_paciente TO mv2000;
GRANT SELECT ON dbamv.pw_lista_meus_paciente TO mvbike WITH GRANT OPTION;
GRANT DELETE,INSERT,SELECT,UPDATE ON dbamv.pw_lista_meus_paciente TO mvintegra;

CREATE OR REPLACE PUBLIC SYNONYM pw_lista_meus_paciente FOR dbamv.pw_lista_meus_paciente