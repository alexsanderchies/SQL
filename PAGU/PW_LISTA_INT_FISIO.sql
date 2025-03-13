CREATE OR REPLACE VIEW dbamv.pw_lista_int_fisio (
  par_cd_atendimento,
  par_cd_paciente,
  par_sn_pendente,
  par_nm_filtro,
  par_cd_parmed,
  par_cd_setor,
  par_cd_doc_clinico,
  par_status,
  "Internação",
  "Prontuário",
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
      ,Nvl( (SELECT RTrim( Decode( Filtro_Rapido.Doc_Med, 0, NULL, 'Com Atend. Médico Hoje;' )
              || Decode( Filtro_Rapido.Doc_Enf, 0, NULL, 'Com Atend. Enfermagem Hoje;' )
              || Decode( Filtro_Rapido.Doc_Fis, 0, NULL, 'Com Evolução Fisio Hoje;' )
              , ';' ) Filtro
              FROM (
                    SELECT pw_documento_clinico.cd_atendimento
                          ,Count( Decode( premed_tip_presta.tp_funcao, 'M', 1 ) ) Doc_Med
                          ,Count( Decode( premed_tip_presta.tp_funcao, 'E', 1 ) ) Doc_Enf
                          ,Count( Decode( pw_documento_clinico.cd_objeto, 509, 1 ) ) Doc_Fis
                      FROM dbamv.pw_documento_clinico
                          ,dbamv.prestador
                          ,dbamv.premed_tip_presta
                    WHERE prestador.cd_prestador = pw_documento_clinico.cd_prestador
                      AND premed_tip_presta.cd_tip_presta = prestador.cd_tip_presta
                      AND To_Date(pw_documento_clinico.dh_referencia,'dd/mm/yyyy') = To_Date(SYSDATE,'dd/mm/yyyy')
                    GROUP BY pw_documento_clinico.cd_atendimento ) Filtro_Rapido
              WHERE Filtro_Rapido.Cd_Atendimento = Atendime.Cd_Atendimento
            ) , 'Pendente(s)' )                                 Par_Nm_Filtro
	  ,Null                                                       Par_Cd_ParMed
	  ,UNID_INT.cd_setor                                           Par_Cd_Setor
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
            ,'DD/MM/YYYY hh24:mi' )                                          "Internação"
    ,Atendime.Cd_Paciente                                        "Prontuário"
	,Atendime.Cd_Atendimento                                     "Atendimento"
	,Paciente.Nm_Paciente                                        "Paciente"
	,Dbamv.Fn_Idade( Paciente.Dt_Nascimento,'x X' )              "Idade"
    ,Especialid.Ds_Especialid                                    "Especialidade"
    ,Prestador.Nm_Prestador                                      "Assistente"
    ,Setor.Nm_Setor                                              "Setor"
    ,leito.ds_leito                                              "Leito"
  From Dbamv.Atendime
      ,Dbamv.Paciente
	  ,Dbamv.LEITO
	  ,Dbamv.Prestador
	  ,Dbamv.PreMed_Tip_Presta
	  ,Dbamv.Setor
    ,Dbamv.Especialid
    ,DBAMV.UNID_INT
    ,DBAMV.PRE_MED
    ,DBAMV.ITPRE_MED
 Where Atendime.Tp_Atendimento = 'I'
   AND (Atendime.Dt_Alta is null or Atendime.Dt_Alta > (Sysdate-1/24) ) -->> Paciente de alta. fica na lista por 1 hora
   AND Paciente.Cd_Paciente  = Atendime.Cd_Paciente
   AND Prestador.Cd_Prestador= Atendime.Cd_Prestador
   AND PreMed_Tip_Presta.Cd_Tip_Presta (+)= Prestador.Cd_Tip_Presta
   AND LEITO.CD_LEITO = ATENDIME.CD_LEITO
   AND LEITO.CD_UNID_INT = UNID_INT.CD_UNID_INT
   AND UNID_INT.CD_SETOR = SETOR.CD_SETOR
   AND Especialid.Cd_Especialid (+)= Atendime.Cd_Especialid
   AND PRE_MED.CD_ATENDIMENTO = ATENDIME.CD_ATENDIMENTO
   AND PRE_MED.CD_PRE_MED = ITPRE_MED.CD_PRE_MED
   AND ITPRE_MED.CD_TIP_ESQ = 'PFI' -- ESQUEMA DE SOLICITAÇÃO DE FISIO
   AND PRE_MED.DT_VALIDADE > SYSDATE
ORDER BY Setor.Nm_Setor
        ,leito.ds_leito
/

COMMENT ON TABLE dbamv.pw_lista_int_fisio IS 'INT - Paciente internados com procedimentos fisio prescritos'
/
CREATE OR REPLACE PUBLIC SYNONYM pw_lista_int_fisio FOR dbamv.pw_lista_int_fisio
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio.par_cd_atendimento IS 'Código do atendimento para ser passado a area de prontuário. Esta informação não é exibida na grid'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio.par_cd_paciente IS 'Código do paciente para ser passado a area de prontuário. Esta informação não é exibida na grid'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio.par_nm_filtro IS 'Lista de nomes a ser usado no filtro rápido, cada nome deve ser separado por ponto e vírgula. Esta informação é exibido como link de filtro rápido acima do grid'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio.par_cd_parmed IS 'Código da solicitação de parecer médico para ser passado a area de prontuário. Esta informação não é exibida na grid'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio.par_cd_setor IS 'Código do setor do atendimento para ser usado no filtro de setores. Esta informação não é exibida na grid'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio.par_cd_doc_clinico IS 'Código do documento clínico para ser passado a area de prontuário, necessário para a rotina de avaliação farmaceutica. Esta informação não é exibida na grid'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio.par_status IS 'Lista de status atual do atendimento deste paciente, indica se esta em atendimento, de alta, etc. TAMANHO_50'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio."Internação" IS 'Data e hora que é feito o registro do atendimento. TAMANHO_60'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio."Prontuário" IS 'Código do paciente vigente.TAMANHO_40'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio."Atendimento" IS 'Código do atendimento vigente.TAMANHO_40'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio."Paciente" IS 'Nome do paciente. TAMANHO_15%'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio."Idade" IS 'Idade atual do paciente. TAMANHO_40'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio."Especialidade" IS 'Especialidade registrada no atendimento. TAMANHO_90'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio."Assistente" IS 'Responsável pelo paciente neste atendimento. TAMANHO_10%'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio."Setor" IS 'Setor de origem do atendimento. TAMANHO_90'
/
COMMENT ON COLUMN dbamv.pw_lista_int_fisio."Leito" IS 'Leito do atendimento. TAMANHO_60'
/

GRANT SELECT ON dbamv.pw_lista_int_fisio TO acessoprd
/
GRANT DELETE,INSERT,SELECT,UPDATE ON dbamv.pw_lista_int_fisio TO dbaps
/
GRANT DELETE,INSERT,SELECT,UPDATE ON dbamv.pw_lista_int_fisio TO dbasgu
/
GRANT SELECT ON dbamv.pw_lista_int_fisio TO desenv_soleitura
/
GRANT DELETE,INSERT,SELECT,UPDATE ON dbamv.pw_lista_int_fisio TO mv2000
/
GRANT SELECT ON dbamv.pw_lista_int_fisio TO mvbike WITH GRANT OPTION
/
GRANT DELETE,INSERT,SELECT,UPDATE ON dbamv.pw_lista_int_fisio TO mvintegra
/
