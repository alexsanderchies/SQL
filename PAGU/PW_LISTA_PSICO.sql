PROMPT CREATE OR REPLACE VIEW pw_lista_psico
CREATE OR REPLACE VIEW pw_lista_psico (
  par_cd_atendimento,
  par_cd_paciente,
  par_sn_pendente,
  par_nm_filtro,
  par_cd_parmed,
  par_cd_setor,
  par_cd_doc_clinico,
  par_status,
  "Data Atendimento",
  "Prontuario",
  "Atendimento",
  "Paciente",
  "Idade",
  "Especialidade",
  "Assistente",
  "Setor",
  "Leito"
) AS
Select DISTINCT Atendime.Cd_Atendimento                                    Par_Cd_Atendimento
      ,Atendime.Cd_Paciente                                       Par_Cd_Paciente
        ,Decode(Atendime.Dt_Alta,Null,'N', 'S')                       Par_Sn_Pendente
      ,Nvl( (SELECT RTrim( Decode( Filtro_Rapido.Doc_Med, 0, NULL, 'Com Atend. Medico Hoje;' )
              || Decode( Filtro_Rapido.Doc_Enf, 0, NULL, 'Com Atend. Enfermagem Hoje;' )
              || Decode( Filtro_Rapido.Doc_Fis, 0, NULL, 'Com Evolucao PSICO Hoje;' )
              , ';' ) Filtro
              FROM (
                    SELECT pw_documento_clinico.cd_atendimento
                          ,Count( Decode( premed_tip_presta.tp_funcao, 'M', 1 ) ) Doc_Med
                          ,Count( Decode( premed_tip_presta.tp_funcao, 'E', 1 ) ) Doc_Enf
                          ,Count( Decode( pw_documento_clinico.cd_objeto, 434, 1 ) ) Doc_Fis
                      FROM dbamv.pw_documento_clinico
                          ,dbamv.prestador
                          ,dbamv.premed_tip_presta
                    WHERE prestador.cd_prestador = pw_documento_clinico.cd_prestador
                      AND premed_tip_presta.cd_tip_presta = prestador.cd_tip_presta
                      AND To_Date(pw_documento_clinico.dh_referencia,'DD/MM/YYYY') = To_Date(SYSDATE,'DD/MM/YYYY')
                    GROUP BY pw_documento_clinico.cd_atendimento ) Filtro_Rapido
              WHERE Filtro_Rapido.Cd_Atendimento = Atendime.Cd_Atendimento
            ) , 'Pendente(s)' )                                 Par_Nm_Filtro
      ,Null                                                       Par_Cd_ParMed
      ,Nvl(UNID_INT.cd_setor,ori_ate.cd_setor)                    Par_Cd_Setor
      ,Null                                                       Par_Cd_Doc_Clinico
      -- *** Acima estao as colunas não visiveis na grid ***
      --
    ,dbamv.fnc_mv_retor_stat_list_pacien( Atendime.Tp_Atendimento
                                           ,Atendime.Cd_Atendimento
                                           ,Null
                                           ,Null
                                           ,Pkg_MVPEP_Area_Pessoal.Fn_Get_Cd_Prestador
                                           ,null
                                           ,null
                                           ,UNID_INT.cd_setor
                                           ,Nvl(PreMed_Tip_Presta.Tp_Funcao,'O') )
                                                          Par_Status
      ,To_Char(Dbamv.Fnc_Mv_Recupera_Data_Hora( Atendime.Dt_Atendimento
                                       ,Atendime.Hr_Atendimento )
            ,'DD/MM/YYYY hh24:mi' )                                          "Data Atendimento"
    ,Atendime.Cd_Paciente                                        "Prontuario"
      ,Atendime.Cd_Atendimento                                     "Atendimento"
      ,Paciente.Nm_Paciente                                        "Paciente"
      ,Dbamv.Fn_Idade( Paciente.Dt_Nascimento,'x X' )              "Idade"
    ,Especialid.Ds_Especialid                                    "Especialidade"
    ,Prestador.Nm_Prestador                                      "Assistente"
    ,Nvl(SETOR.NM_SETOR,setor2.nm_setor)                         "Setor"
    ,leito.ds_leito                                              "Leito"
  FROM DBAMV.ATENDIME
  JOIN PACIENTE
    ON PACIENTE.CD_PACIENTE = ATENDIME.CD_PACIENTE
  JOIN DBAMV.ESPECIALID
    ON ATENDIME.CD_ESPECIALID = ESPECIALID.CD_ESPECIALID
  JOIN DBAMV.PRE_MED
    ON PRE_MED.CD_ATENDIMENTO = ATENDIME.CD_ATENDIMENTO
  JOIN DBAMV.ITPRE_MED
    ON ITPRE_MED.CD_PRE_MED = PRE_MED.CD_PRE_MED
  JOIN DBAMV.ORI_ATE
    ON ATENDIME.CD_ORI_ATE = ORI_ATE.CD_ORI_ATE
  LEFT JOIN DBAMV.LEITO
    ON ATENDIME.CD_LEITO = LEITO.CD_LEITO
    JOIN DBAMV.PRESTADOR
    ON PRESTADOR.CD_PRESTADOR = ATENDIME.CD_PRESTADOR
  LEFT JOIN Dbamv.PreMed_Tip_Presta
    ON PRESTADOR.CD_TIP_PRESTA = PREMED_TIP_PRESTA.CD_TIP_PRESTA
    LEFT JOIN DBAMV.UNID_INT
    ON UNID_INT.CD_UNID_INT = LEITO.CD_UNID_INT
  LEFT JOIN DBAMV.SETOR
    ON UNID_INT.CD_SETOR = SETOR.CD_SETOR
  left JOIN DBAMV.SETOR setor2
    ON SETOR2.CD_SETOR = ORI_ATE.CD_SETOR
Where ATENDIME.TP_ATENDIMENTO IN ('I','A','U')
   AND (ATENDIME.DT_ALTA IS NULL OR ATENDIME.DT_ALTA > (SYSDATE-1/24) ) -->> Paciente de alta. fica na lista por 1 hora
   AND ITPRE_MED.CD_TIP_ESQ = 'AVP'
   AND PRE_MED.DT_VALIDADE > SYSDATE
   AND PRE_MED.HR_PRE_MED < SYSDATE
/

COMMENT ON TABLE pw_lista_psico IS 'Paciente com procedimentos PSICOLOGIA prescritos';

COMMENT ON COLUMN pw_lista_psico.par_cd_atendimento IS 'Codigo do atendimento para ser passado a area de prontuario';
COMMENT ON COLUMN pw_lista_psico.par_cd_paciente IS 'Codigo do paciente para ser passado a area de prontuario';
COMMENT ON COLUMN pw_lista_psico.par_nm_filtro IS 'Lista de nomes a ser usado no filtro rapido, cada nome deve ser separado por ponto e virgula';
COMMENT ON COLUMN pw_lista_psico.par_cd_parmed IS 'Codigo da solicitacao de parecer medico para ser passado a area de prontuario';
COMMENT ON COLUMN pw_lista_psico.par_cd_setor IS 'Codigo do setor do atendimento para ser usado no filtro de setores';
COMMENT ON COLUMN pw_lista_psico.par_cd_doc_clinico IS 'Codigo do documento clinico para ser passado a area de prontuario, necessario para a rotina de avaliacao farmaceutica';
COMMENT ON COLUMN pw_lista_psico.par_status IS 'Lista de status atual do atendimento deste paciente, indica se esta em atendimento, de alta, etc. TAMANHO_50';
COMMENT ON COLUMN pw_lista_psico."Data Atendimento" IS 'Data e hora que  feito o registro do atendimento. TAMANHO_60';
COMMENT ON COLUMN pw_lista_psico."Prontuario" IS 'Codigo do paciente vigente.TAMANHO_40';
COMMENT ON COLUMN pw_lista_psico."Atendimento" IS 'Codigo do atendimento vigente.TAMANHO_40';
COMMENT ON COLUMN pw_lista_psico."Paciente" IS 'Nome do paciente. TAMANHO_15%';
COMMENT ON COLUMN pw_lista_psico."Idade" IS 'Idade atual do paciente. TAMANHO_40';
COMMENT ON COLUMN pw_lista_psico."Especialidade" IS 'Especialidade registrada no atendimento. TAMANHO_90';
COMMENT ON COLUMN pw_lista_psico."Assistente" IS 'Responsavel pelo paciente neste atendimento. TAMANHO_10%';
COMMENT ON COLUMN pw_lista_psico."Setor" IS 'Setor de origem do atendimento. TAMANHO_90';
COMMENT ON COLUMN pw_lista_psico."Leito" IS 'Leito do atendimento. TAMANHO_60';

GRANT SELECT ON pw_lista_psico TO dbacp WITH GRANT OPTION;
GRANT SELECT ON pw_lista_psico TO dbaportal WITH GRANT OPTION;
GRANT DELETE,INSERT,SELECT,UPDATE ON pw_lista_psico TO dbaps;
GRANT DELETE,INSERT,SELECT,UPDATE ON pw_lista_psico TO dbasgu;
GRANT DELETE,INSERT,SELECT,UPDATE ON pw_lista_psico TO mv2000;
GRANT DELETE,INSERT,SELECT,UPDATE ON pw_lista_psico TO mvintegra;




CREATE OR REPLACE PUBLIC SYNONYM pw_lista_psico FOR dbamv.pw_lista_psico
