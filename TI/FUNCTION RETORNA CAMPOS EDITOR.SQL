PROMPT CREATE OR REPLACE FUNCTION fnc_editor3_retorna_campo
CREATE OR REPLACE Function fnc_editor3_retorna_campo (P_CD_REGISTRO       NUMBER,
                                                      P_DS_IDENTIFICADOR  VARCHAR
                                                     )
  RETURN Char IS Resposta Char(3000);
-------------------------------------------------------------------------------------------
Cursor cRespostaDocumento IS

SELECT EDITOR_REGISTRO_CAMPO.LO_CONTEUDO   Resposta
  FROM DBAMV.ATENDIME
  JOIN DBAMV.PW_DOCUMENTO_CLINICO
    ON ATENDIME.CD_ATENDIMENTO = PW_DOCUMENTO_CLINICO.CD_ATENDIMENTO
  JOIN DBAMV.PW_EDITOR_CLINICO
    ON PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO = PW_EDITOR_CLINICO.CD_DOCUMENTO_CLINICO
  JOIN EDITOR.EDITOR_REGISTRO
    ON PW_EDITOR_CLINICO.CD_EDITOR_REGISTRO = EDITOR_REGISTRO.CD_REGISTRO
  JOIN EDITOR.EDITOR_REGISTRO_CAMPO
    ON EDITOR_REGISTRO.CD_REGISTRO = EDITOR_REGISTRO_CAMPO.CD_REGISTRO
  JOIN EDITOR.EDITOR_CAMPO
    ON EDITOR_REGISTRO_CAMPO.CD_CAMPO = EDITOR_CAMPO.CD_CAMPO
  WHERE Trim(EDITOR_CAMPO.DS_IDENTIFICADOR) = Trim(Upper(P_DS_IDENTIFICADOR))
    AND PW_DOCUMENTO_CLINICO.TP_STATUS = 'FECHADO'
    AND EDITOR_REGISTRO.CD_REGISTRO = P_CD_REGISTRO ;

BEGIN

open cRespostaDocumento;
fetch cRespostaDocumento into Resposta;
close cRespostaDocumento;


Return Resposta;

Exception
   When no_data_found then
      Return sqlerrm;

end;

/

GRANT EXECUTE ON fnc_editor3_retorna_campo TO dbaps;
GRANT EXECUTE ON fnc_editor3_retorna_campo TO dbasgu;
GRANT EXECUTE ON fnc_editor3_retorna_campo TO editor;
GRANT EXECUTE ON fnc_editor3_retorna_campo TO editor_custom;
GRANT EXECUTE ON fnc_editor3_retorna_campo TO mv2000;
GRANT EXECUTE ON fnc_editor3_retorna_campo TO mvintegra;
GRANT EXECUTE ON fnc_editor3_retorna_campo TO remweb;
