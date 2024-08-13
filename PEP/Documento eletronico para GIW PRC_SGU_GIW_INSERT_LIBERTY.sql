
CREATE OR REPLACE PROCEDURE DBASGU.PRC_SGU_GIW_INSERT_LIBERTY( cdEditorRegistro NUMBER
                                                              ,dsTerminal VARCHAR2
                                                              ,dtPrevisao DATE DEFAULT NULL
                                                              ,cdUsuarioSolicitante VARCHAR2 DEFAULT NULL
                                                              ,dsSoliticante VARCHAR2 DEFAULT NULL
                                                              ,cdRegistro NUMBER DEFAULT NULL )
IS
  --
  pCdEditor NUMBER := cdRegistro;
  --
BEGIN
  --
  IF ( (cdEditorRegistro IS NOT NULL OR pCdEditor IS NOT NULL ) AND
        dsTerminal       IS NOT NULL ) THEN
    --
    IF (pCdEditor IS NULL ) THEN
      --
      FOR rReg IN ( SELECT CD_EDITOR_REGISTRO
                      FROM DBAMV.PW_EDITOR_CLINICO
                     WHERE CD_EDITOR_CLINICO = cdEditorRegistro)
      LOOP
        --
        pCdEditor := rReg.CD_EDITOR_REGISTRO;
        --
      END LOOP;
      --
    END IF;
    --
    INSERT INTO DBAMV.IMPRESSAO ( CD_IMPRESSAO
                                 ,TITULO
                                 ,NM_RELATORIO
                                 ,NM_USUARIO
                                 ,DT_SOLICITACAO
                                 ,TP_ACAO
                                 ,DT_PREVISTA_IMPRESSAO
                                 ,DESTINO
                                 ,SOLICITANTE
                                 )
                         VALUES ( DBAMV.SEQ_IMPRESSAO.NEXTVAL
                                 ,'Documento Eletronico 2'
                                 ,'LIBERTY'
                                 ,Nvl(cdUsuarioSolicitante,DBAMV.PKG_MV_VARIAVEIS.FNC_GET_USUARIO())
                                 ,SYSDATE
                                 ,'E'
                                 ,dtPrevisao
                                 ,dsTerminal
                                 ,Nvl(dsSoliticante,'['||DBAMV.PKG_MV_VARIAVEIS.FNC_GET_USUARIO()||'] - Liberty') );
    --
    INSERT INTO DBAMV.IMP_PARAMETRO ( CD_IMPRESSAO
                                     ,NOME
                                     ,VALOR)
                             VALUES ( DBAMV.SEQ_IMPRESSAO.CURRVAL
                                     ,'CD_EDITOR_REGISTRO'
                                     ,pCdEditor);
    --
  END IF;
  --
END;
/

ALTER PROCEDURE DBASGU.PRC_SGU_GIW_INSERT_LIBERTY COMPILE
/

CREATE OR REPLACE PROCEDURE DBASGU.PRC_LIBERTY_GIW( paramEditorRegistro  VARCHAR2
                                                   ,dsTerminal           VARCHAR2
                                                   ,dtPrevisao           DATE DEFAULT NULL
                                                   ,cdUsuarioSolicitante VARCHAR2 DEFAULT NULL
                                                   ,dsSoliticante        VARCHAR2 DEFAULT NULL
                                                   ,paramCdAtendimento   VARCHAR2
                                                   ,paramCdItpreMed      VARCHAR2 )
IS
  --
  cdEditorRegistro NUMBER;
  cdAtendimento    NUMBER;
  cdItpreMed       NUMBER;
  cdRegistro       NUMBER;
  --
BEGIN
  --
  IF(UPPER(paramEditorRegistro) <> 'NULL') THEN
    cdEditorRegistro := To_Number(paramEditorRegistro);
  END IF;
  --
  IF(UPPER(paramCdAtendimento) <> 'NULL') THEN
    cdAtendimento := To_Number(paramCdAtendimento);
  END IF;
  --
  IF(UPPER(paramCdItpreMed) <> 'NULL') THEN
    cdItpreMed := To_Number(paramCdItpreMed);
  END IF;
  --
  IF ( cdEditorRegistro IS NULL     AND
       cdItpreMed       IS NOT NULL ) THEN
    --
    FOR rEdit IN (SELECT R.CD_EDITOR_CLINICO
                        ,P.CD_ATENDIMENTO
                    FROM DBAMV.REGISTRO_DOCUMENTO_OBRIGATORIO R
                        ,DBAMV.PRE_MED P
                        ,DBAMV.ITPRE_MED I
                   WHERE P.CD_PRE_MED   = I.CD_PRE_MED
                     AND I.CD_ITPRE_MED = R.CD_ITPRE_MED
                     AND I.CD_ITPRE_MED = cdItpreMed )
    LOOP
      --
      cdRegistro    := rEdit.CD_EDITOR_CLINICO;
      cdAtendimento := rEdit.CD_ATENDIMENTO;
      --
    END LOOP;
    --
  END IF;
  --
  IF ( cdAtendimento    IS NOT NULL                             AND
      (cdEditorRegistro IS NOT NULL OR cdRegistro IS NOT NULL ) AND
       dsTerminal       IS NOT NULL ) THEN
    --
    DBASGU.PRC_SGU_GIW_INSERT_LIBERTY(cdEditorRegistro
                                     ,dsTerminal
                                     ,dtPrevisao
                                     ,cdUsuarioSolicitante
                                     ,dsSoliticante
                                     ,cdRegistro);
    --
  END IF;
  --
END;
/

ALTER PROCEDURE DBASGU.PRC_LIBERTY_GIW COMPILE
/

--Chamada da PRC
/*CALL								
DBASGU.PRC_LIBERTY_GIW('&<PAR_CD_REGISTRO_DOCUMENTO>'
                       ,'COAGULACAO'
                       ,SYSDATE
					             ,'&<PAR_CD_USUARIO>'
                       ,'Requisicao de Sangue'
                       ,'&<PAR_CD_ATENDIMENTO>'
                       , '&<PAR_CD_ITPRE_MED>')	