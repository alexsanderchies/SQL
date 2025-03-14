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
        ELSE 'Identificação de peças anatômicas: NÃO INFORMADO'
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
          SELECT dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_TRANSP_UTI_COM_MEDICO')      TRANSP_UTI_COM_MEDICO
                ,dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_TRANSP_AMBULANCIA_BASICA')   TRANSP_AMBULANCIA_BASICA
          FROM DUAL
        );

Cursor cQuimioterapia IS

  SELECT CASE
            WHEN QUIMIO_S = 'true' THEN 'Quimioterapia: Sim'
            WHEN QUIMIO_N = 'true' THEN 'Quimioterapia: Não'
          ELSE 'Quimioterapia: NÃO INFORMADO'
          END RESPOSTA
    FROM (
          SELECT dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_QUIMIO_S')   QUIMIO_S
                ,dbamv.fnc_editor_retorna_campo(P_CD_DOCUMENTO_CLINICO,'RB_QUIMIO_N')   QUIMIO_N
          FROM DUAL
        );

Cursor cIntervFarm IS

  SELECT CASE
            WHEN INTERV_FARM_N = 'true' AND CD_DOCUMENTO_CLINICO IS NOT NULL THEN 'Continuar com acompanhamento farmacêutico: Não'
            WHEN INTERV_FARM_S = 'true' AND CD_DOCUMENTO_CLINICO IS NOT NULL THEN 'Continuar com acompanhamento farmacêutico: Sim'
            WHEN CD_DOCUMENTO_CLINICO IS NULL THEN NULL
            ELSE 'Continuar com acompanhamento farmacêutico: Não informado'
          END Resposta
  FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO,'RB_36_INTERV_FARM_N')INTERV_FARM_N
              ,DBAMV.FNC_EDITOR_RETORNA_CAMPO(PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO,'RB_36_INTERV_FARM_S') INTERV_FARM_S
              ,PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO
          FROM DBAMV.PW_DOCUMENTO_CLINICO
          JOIN DBASGU.USUARIOS
            ON PW_DOCUMENTO_CLINICO.CD_USUARIO = USUARIOS.CD_USUARIO
          WHERE PW_DOCUMENTO_CLINICO.CD_PACIENTE = P_CD_ATENDIMENTO
            AND (PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO, PW_DOCUMENTO_CLINICO.CD_PACIENTE) IN (
                                                                                                  SELECT Max(PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO)
                                                                                                        ,PW_DOCUMENTO_CLINICO.CD_PACIENTE
                                                                                                    FROM DBAMV.PW_DOCUMENTO_CLINICO
                                                                                                    JOIN DBAMV.PW_EDITOR_CLINICO
                                                                                                      ON PW_DOCUMENTO_CLINICO.CD_DOCUMENTO_CLINICO = PW_EDITOR_CLINICO.CD_DOCUMENTO_CLINICO
                                                                                                    WHERE PW_EDITOR_CLINICO.CD_DOCUMENTO = 1192
                                                                                                      AND PW_DOCUMENTO_CLINICO.TP_STATUS IN ('FECHADO','ASSINADO')
                                                                                                  GROUP BY PW_DOCUMENTO_CLINICO.CD_PACIENTE
                                                                                                  )
        );

CURSOR cTratPreMed IS

  SELECT listagg(DISTINCT TRATAMENTO.NM_PROTOCOLO, CHR(10)) within group (order by TRATAMENTO.CD_PACIENTE) Resposta
    FROM DBAMV.TRATAMENTO
    WHERE TRATAMENTO.CD_PACIENTE = P_CD_ATENDIMENTO
      AND TRATAMENTO.SN_ATIVO = 'S';

CURSOR cCondutasFarm IS 
  SELECT listagg(CONDUTAS_1, CHR(10)) RESPOSTA   
    FROM (
          SELECT CASE 
                    WHEN CONDUTAS_1 = 'true' THEN 'Oriento paciente e/ou acompanhante sobre o(s) medicamentos e posologia correta'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_1')CONDUTAS_1 FROM dual)
          UNION 
          SELECT CASE 
                    WHEN CONDUTAS_2 = 'true' THEN 'Entrego ao paciente e/ou acompanhante a prescrição farmacêutica com orientações sobre o(s) medicamento(s) e realizo a validação do entendimento das orientações repassadas'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_2')CONDUTAS_2 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_3 = 'true' THEN 'Solicito o médico oncologista avaliação das interação(es) encontrada(s)'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_3')CONDUTAS_3 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_4 = 'true' THEN 'Envio carta ao médico prescritor solicitando adequação do medicamento avaliado ao tratamento oncológico'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_4')CONDUTAS_4 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_5 = 'true' THEN 'Encaminho para equipe multidisciplinar'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_5')CONDUTAS_5 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_6 = 'true' THEN 'Informado ao médico sobre a duplicidade do medicamento e sugestão de suspensão de medicamento'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_6')CONDUTAS_6 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_7 = 'true' THEN 'Solicito ao médico oncologista a avaliação sobre as divergência(s) / erro(s) encontrados na prescrição'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_7')CONDUTAS_7 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_8 = 'true' THEN 'Sugiro inclusão de novo medicamento'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_8')CONDUTAS_8 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_9 = 'true' THEN 'Sugiro substituição do medicamento'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_9')CONDUTAS_9 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_10 = 'true' THEN 'Sugiro alteração da forma farmacêutica'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_10')CONDUTAS_10 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_11 = 'true' THEN 'Sugiro alteração na frequência de administração, sem alteração de dose'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_11')CONDUTAS_11 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_12 = 'true' THEN 'Sugiro alteração no horário de administração, sem alteração de dose'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_12')CONDUTAS_12 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_13 = 'true' THEN 'Sugiro alteração de via de administração'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_13')CONDUTAS_13 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_14 = 'true' THEN 'Sugiro aumento de dose do medicamento'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_14')CONDUTAS_14 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_15 = 'true' THEN 'Sugiro redução de dose do medicamento'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_15')CONDUTAS_15 FROM dual) 
          UNION
          SELECT CASE 
                    WHEN CONDUTAS_16 = 'true' THEN 'Sugiro suspensão de planta medicinal'
                  ELSE NULL
                  END CONDUTAS_1
            FROM (SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'SN_37_CONDUTAS_16')CONDUTAS_16 FROM dual) 
          UNION 
          SELECT DBAMV.FNC_EDITOR_RETORNA_CAMPO(P_CD_DOCUMENTO_CLINICO,'DS_37_CONDUTAS_17')CONDUTAS_17  FROM dual 
          )
  WHERE CONDUTAS_1 IS NOT NULL; 

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

if P_TIPO_CAMPO = 'INTERVFARM' then
open cIntervFarm;
fetch cIntervFarm into Resposta;
close cIntervFarm;
end if;

if P_TIPO_CAMPO = 'TRATPREMED' then
open cTratPreMed;
fetch cTratPreMed into Resposta;
close cTratPreMed;
end if;

if P_TIPO_CAMPO = 'CONDUTASFARM' then
open cCondutasFarm;
fetch cCondutasFarm into Resposta;
close cCondutasFarm;
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
