PROMPT CREATE OR REPLACE FUNCTION fnc_campos_checklist_relatorio
CREATE OR REPLACE Function fnc_campos_checklist_relatorio (P_CD_ATENDIMENTO         IN NUMBER ,
                                                           P_CD_DOCUMENTO_CLINICO   IN NUMBER,
                                                           P_TIPO_CAMPO             IN VARCHAR2
                                                          )
  RETURN Char IS Resposta Char(1000);

Cursor cHouveIntercorrencia IS
  SELECT CASE
            WHEN HOUVE_INTERCORRENCIA_S = 'true' THEN 'Intercorrências: Sim'
            WHEN HOUVE_INTERCORRENCIA_N = 'true' THEN 'Intercorrências: Não'
          ELSE 'Intercorrências: NÃO INFORMADO'
          END RESPOSTA
    FROM (
          SELECT dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_HOUVE_INTERCORRENCIA_S')           HOUVE_INTERCORRENCIA_S
                ,dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_HOUVE_INTERCORRENCIA_N')           HOUVE_INTERCORRENCIA_N
          FROM DUAL
        );
Cursor cCulturaIdentificada IS
  SELECT CASE
          WHEN CULTURA_IDENTIFICADA_AUSENTE = 'true' THEN 'Identificação de peças anatômicas: Ausente'
          WHEN CULTURA_IDENTIFICADA_N = 'true' THEN 'Identificação de peças anatômicas: Não'
          WHEN CULTURA_IDENTIFICADA_S = 'true' THEN 'Identificação de peças anatômicas: Sim'
        ELSE 'Identificação de peças anatômicas: NÃO INFORMADO '
        END RESPOSTA
    FROM (
          SELECT dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_CULTURA_IDENTIFICADA_AUSENTE')     CULTURA_IDENTIFICADA_AUSENTE
                ,dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_CULTURA_IDENTIFICADA_N')           CULTURA_IDENTIFICADA_N
                ,dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_CULTURA_IDENTIFICADA_S')           CULTURA_IDENTIFICADA_S

          FROM DUAL
        );

Cursor cEventoAdverso IS
  SELECT CASE
            WHEN HOUVE_EVENTO_ADVERSO_S = 'true' THEN 'Evento Adverso: Sim'
            WHEN HOUVE_EVENTO_ADVERSO_N = 'true' THEN 'Evento Adverso: Não'
          ELSE 'Evento Adverso: NÃO INFORMADO'
          END RESPOSTA
    FROM (
          SELECT dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_HOUVE_EVENTO_ADVERSO_N')           HOUVE_EVENTO_ADVERSO_N
                ,dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_HOUVE_EVENTO_ADVERSO_S')           HOUVE_EVENTO_ADVERSO_S
          FROM DUAL
        );

Cursor cDocumentoPreenchido IS

  SELECT CASE
            WHEN Max(PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO) IS NULL THEN 'DOCUMENTO NÃO PREENCHIDO'
          ELSE NULL
        END RESPOSTA
    FROM dbamv.PW_DOCUMENTO_CLINICO
    JOIN dbamv.pw_editor_clinico
      ON PW_DOCUMENTO_CLINICO.cd_documento_clinico = pw_editor_clinico.cd_documento_clinico
    WHERE pw_editor_clinico.cd_documento = 1253
      AND PW_DOCUMENTO_CLINICO.CD_ATENDIMENTO = P_CD_ATENDIMENTO;

Cursor cCdDocumentoPreenchido IS

  SELECT CASE
            WHEN Max( PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO) IS NULL THEN 0
          ELSE 1
        END RESPOSTA
    FROM dbamv.PW_DOCUMENTO_CLINICO
    JOIN dbamv.pw_editor_clinico
      ON PW_DOCUMENTO_CLINICO.cd_documento_clinico = pw_editor_clinico.cd_documento_clinico
    WHERE pw_editor_clinico.cd_documento = 1253
      AND PW_DOCUMENTO_CLINICO.CD_ATENDIMENTO = P_CD_ATENDIMENTO
      AND (PW_DOCUMENTO_CLINICO.TP_STATUS = 'FECHADO' OR PW_DOCUMENTO_CLINICO.TP_STATUS = 'ASSINADO');


Cursor cCdDocumentoNaoPreenchido IS

  SELECT CASE
            WHEN Max( PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO) IS NULL THEN 1
          ELSE 0
        END RESPOSTA
    FROM dbamv.PW_DOCUMENTO_CLINICO
    JOIN dbamv.pw_editor_clinico
      ON PW_DOCUMENTO_CLINICO.cd_documento_clinico = pw_editor_clinico.cd_documento_clinico
    WHERE pw_editor_clinico.cd_documento = 1253
      AND PW_DOCUMENTO_CLINICO.CD_ATENDIMENTO = P_CD_ATENDIMENTO
      AND (PW_DOCUMENTO_CLINICO.TP_STATUS = 'FECHADO' OR PW_DOCUMENTO_CLINICO.TP_STATUS = 'ASSINADO');


CURSOR cRetornaProcedimentos IS

  SELECT *
    FROM (
          SELECT listagg(cirurgia.ds_cirurgia, CHR(10)) within group (order by AVISO_CIRURGIA.CD_ATENDIMENTO) DS_PROCEDIMENTO
            FROM DBAMV.AVISO_CIRURGIA
            JOIN DBAMV.CIRURGIA_AVISO
              ON AVISO_CIRURGIA.CD_AVISO_CIRURGIA = CIRURGIA_AVISO.CD_AVISO_CIRURGIA
            JOIN DBAMV.CIRURGIA
              ON CIRURGIA_AVISO.CD_CIRURGIA = CIRURGIA.CD_CIRURGIA
            WHERE AVISO_CIRURGIA.CD_CEN_CIR = 4
              AND AVISO_CIRURGIA.TP_SITUACAO <> 'C'
              AND AVISO_CIRURGIA.CD_ATENDIMENTO = P_CD_ATENDIMENTO
          UNION
          SELECT listagg(EXA_RX.DS_EXA_RX, CHR(10)) within group (order by PED_RX.CD_ATENDIMENTO) DS_PROCEDIMENTO
            FROM DBAMV.PED_RX
            JOIN DBAMV.ITPED_RX
              ON PED_RX.CD_PED_RX = ITPED_RX.CD_PED_RX
            JOIN DBAMV.EXA_RX
              ON ITPED_RX.CD_EXA_RX = EXA_RX.CD_EXA_RX
            WHERE PED_RX.CD_SET_EXA = 35
              AND PED_RX.CD_ATENDIMENTO = P_CD_ATENDIMENTO
          )  ;

Cursor cTranspAmbulancia IS

  SELECT CASE
            WHEN TRANSP_AMBULANCIA_BASICA = 'true' THEN 'Transporte: Ambulância Básica'
            WHEN TRANSP_UTI_COM_MEDICO = 'true' THEN 'Transporte: UTI com Médico'
          ELSE 'Transporte: NÃO INFORMADO'
          END RESPOSTA
    FROM (
          SELECT dbamv.Fnc_Editor_Retorna_Historico(P_CD_ATENDIMENTO,
                                                    'DOCUMENTO',
                                                    'RB_TRANSP_UTI_COM_MEDICO', --nome do campo
                                                    'A',
                                                    'N',
                                                    1250, --código do documento
                                                    'AMBOS',
                                                    'N')TRANSP_UTI_COM_MEDICO
                ,dbamv.Fnc_Editor_Retorna_Historico(P_CD_ATENDIMENTO,
                                                    'DOCUMENTO',
                                                    'RB_TRANSP_AMBULANCIA_BASICA', --nome do campo
                                                    'A',
                                                    'N',
                                                    1250, --código do documento
                                                    'AMBOS',
                                                    'N')TRANSP_AMBULANCIA_BASICA
          FROM DUAL
        );

Cursor cQuimioterapia IS

  SELECT CASE
            WHEN QUIMIO_S = 'true' THEN 'Quimioterapia: Sim'
            WHEN QUIMIO_N = 'true' THEN 'Quimioterapia: Não'
          ELSE 'Quimioterapia: NÃO INFORMADO'
          END RESPOSTA
    FROM (
          SELECT dbamv.Fnc_Editor_Retorna_Historico(P_CD_ATENDIMENTO,
                                                    'DOCUMENTO',
                                                    'RB_QUIMIO_S', --nome do campo
                                                    'A',
                                                    'N',
                                                    1250, --código do documento
                                                    'AMBOS',
                                                    'N')QUIMIO_S
                ,dbamv.Fnc_Editor_Retorna_Historico(P_CD_ATENDIMENTO,
                                                    'DOCUMENTO',
                                                    'RB_QUIMIO_N', --nome do campo
                                                    'A',
                                                    'N',
                                                    1250, --código do documento
                                                    'AMBOS',
                                                    'N')QUIMIO_N
          FROM DUAL
        );

Begin

if P_TIPO_CAMPO = 'INTERCORRENCIA' then
open cHouveIntercorrencia;
fetch cHouveIntercorrencia into Resposta;
close cHouveIntercorrencia;
end if;

if P_TIPO_CAMPO = 'CULTURAIDENTIFICADA' then
open cCulturaIdentificada;
fetch cCulturaIdentificada into Resposta;
close cCulturaIdentificada;
end if;

if P_TIPO_CAMPO = 'EVENTOADVERSO' then
open cEventoAdverso;
fetch cEventoAdverso into Resposta;
close cEventoAdverso;
end if;

if P_TIPO_CAMPO = 'DOCUMENTOPREENCHIDO' then
open cDocumentoPreenchido;
fetch cDocumentoPreenchido into Resposta;
close cDocumentoPreenchido;
end if;

if P_TIPO_CAMPO = 'CDDOCUMENTOPREENCHIDO' then
open cCdDocumentoPreenchido;
fetch cCdDocumentoPreenchido into Resposta;
close cCdDocumentoPreenchido;
end if;

if P_TIPO_CAMPO = 'CDDOCUMENTONAOPREENCHIDO' then
open cCdDocumentoNaoPreenchido;
fetch cCdDocumentoNaoPreenchido into Resposta;
close cCdDocumentoNaoPreenchido;
end if;

if P_TIPO_CAMPO = 'RETORNAPROCEDIMENTOS' then
open cRetornaProcedimentos;
fetch cRetornaProcedimentos into Resposta;
close cRetornaProcedimentos;
end if;

if P_TIPO_CAMPO = 'TRANSPAMBULANCIA' then
open cTranspAmbulancia;
fetch cTranspAmbulancia into Resposta;
close cTranspAmbulancia;
end if;

if P_TIPO_CAMPO = 'QUIMIOTERAPIA' then
open cQuimioterapia;
fetch cQuimioterapia into Resposta;
close cQuimioterapia;
end if;

Return Trim (Resposta);

Exception
   When no_data_found then
      Return sqlerrm;
end;
/

GRANT EXECUTE ON fnc_campos_checklist_relatorio TO dbaps;
GRANT EXECUTE ON fnc_campos_checklist_relatorio TO dbasgu;
GRANT EXECUTE ON fnc_campos_checklist_relatorio TO mv2000;
GRANT EXECUTE ON fnc_campos_checklist_relatorio TO mvintegra;
GRANT EXECUTE ON fnc_campos_checklist_relatorio TO remweb;
