PROMPT CREATE OR REPLACE FUNCTION fnc_retorna_usuarios_evolucao
CREATE OR REPLACE Function fnc_retorna_usuarios_evolucao (P_CD_ATENDIMENTO      NUMBER,
                                                          P_TIPO_DOC            VARCHAR2
                                                          )

  RETURN Char IS EVOL Char(3000);
-------------------------------------------------------------------------------------------
Cursor cEvolEnf IS

  SELECT
        listagg('Tipo: '||NM_OBJETO||' por: '||NM_USUARIO, CHR(10)) within group (order by CD_ATENDIMENTO) EVOL
      FROM (
          SELECT DISTINCT PW_DOCUMENTO_CLINICO.CD_USUARIO
                ,USUARIOS.NM_USUARIO
                ,PAGU_OBJETO.NM_OBJETO
                ,PW_DOCUMENTO_CLINICO.CD_ATENDIMENTO
            FROM DBAMV.PW_DOCUMENTO_CLINICO
            JOIN DBASGU.USUARIOS
              ON PW_DOCUMENTO_CLINICO.CD_USUARIO = USUARIOS.CD_USUARIO
            JOIN DBAMV.PAGU_OBJETO
              ON PW_DOCUMENTO_CLINICO.CD_OBJETO = PAGU_OBJETO.CD_OBJETO
            WHERE pw_documento_clinico.cd_objeto IN (1653)
          UNION ALL
          SELECT DISTINCT PW_DOCUMENTO_CLINICO.CD_USUARIO
                ,USUARIOS.NM_USUARIO
                ,PW_DOCUMENTO_CLINICO.NM_DOCUMENTO NM_OBJETO
                ,PW_DOCUMENTO_CLINICO.CD_ATENDIMENTO
            FROM DBAMV.PW_DOCUMENTO_CLINICO
            JOIN DBAMV.PW_EDITOR_CLINICO
              ON PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO = PW_EDITOR_CLINICO.CD_DOCUMENTO_CLINICO
            JOIN DBASGU.USUARIOS
              ON PW_DOCUMENTO_CLINICO.CD_USUARIO = USUARIOS.CD_USUARIO
            WHERE PW_EDITOR_CLINICO.CD_DOCUMENTO = 1223
          )
      WHERE CD_ATENDIMENTO = P_CD_ATENDIMENTO;

Cursor cEvolProc IS

  SELECT
        listagg('Tipo: '||NM_OBJETO||' por: '||NM_USUARIO, CHR(10)) within group (order by CD_ATENDIMENTO) EVOL
      FROM (
            SELECT DISTINCT PW_DOCUMENTO_CLINICO.CD_USUARIO
                  ,USUARIOS.NM_USUARIO
                  ,PW_DOCUMENTO_CLINICO.NM_DOCUMENTO NM_OBJETO
                  ,PW_DOCUMENTO_CLINICO.CD_ATENDIMENTO
              FROM DBAMV.PW_DOCUMENTO_CLINICO
              JOIN DBAMV.PW_EDITOR_CLINICO
                ON PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO = PW_EDITOR_CLINICO.CD_DOCUMENTO_CLINICO
              JOIN DBASGU.USUARIOS
                ON PW_DOCUMENTO_CLINICO.CD_USUARIO = USUARIOS.CD_USUARIO
              WHERE PW_EDITOR_CLINICO.CD_DOCUMENTO = 1241
            )
      WHERE CD_ATENDIMENTO = P_CD_ATENDIMENTO;

BEGIN

if P_TIPO_DOC = 'EVOLENF' then
open cEvolEnf;
fetch cEvolEnf into EVOL;
close cEvolEnf;
end if;

if P_TIPO_DOC = 'EVOLPROC' then
open cEvolProc;
fetch cEvolProc into EVOL;
close cEvolProc;
end if;


Return EVOL;

Exception
   When no_data_found then
      Return sqlerrm;

end;
/

GRANT EXECUTE ON fnc_retorna_usuarios_evolucao TO dbaps;
GRANT EXECUTE ON fnc_retorna_usuarios_evolucao TO dbasgu;
GRANT EXECUTE ON fnc_retorna_usuarios_evolucao TO mv2000;
GRANT EXECUTE ON fnc_retorna_usuarios_evolucao TO mvintegra;
GRANT EXECUTE ON fnc_retorna_usuarios_evolucao TO remweb;
