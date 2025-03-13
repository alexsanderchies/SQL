SELECT FAT_SUS.dt_competencia
      ,FAT_SUS.cd_prestador
      ,prestador.nm_prestador
      ,FAT_SUS.cd_setor
      ,setor.nm_setor
      ,reg_fat.nr_guia
      ,atendime.cd_paciente
      ,paciente.nm_paciente
      ,FAT_SUS.cd_procedimento
      ,procedimento_sus.ds_procedimento
      ,reg_fat.dt_inicio
      ,FAT_SUS.dt_final
      ,FAT_SUS.Qt_pontos
      ,FAT_SUS.CD_ATENDIMENTO
      ,FAT_SUS.CD_REG_FAT
      ,( vlr_anestesista
        +vlr_analg_obstetrica
        +vlr_consulta_pediatrica
        +vlr_neonatologia
        +vlr_perfusionista
        +vlr_prof_uti
        +vlr_prof_uti_especializada
        +Vlr_Profissionais
        )vlr_profissionais
FROM                                                          
 
(
select reg_fat.cd_multi_empresa
     , REG_FAT.CD_REG_FAT_GLOSA
     , reg_fat.cd_atendimento
     , reg_fat.cd_convenio
     , reg_fat.cd_con_pla
     , fatura.dt_competencia
     , remessa_fatura.cd_remessa
     , remessa_fatura.sn_fechada remessa_fechada
     , reg_fat.cd_reg_fat
     , reg_fat.sn_fechada conta_fechada
     , reg_fat.cd_espec_sus
     , reg_fat.dt_final
     , Item_Res.Cd_Item_Res
     , Item_Res.Tp_Receita
     , nvl(itreg_fat.cd_setor, 0) cd_setor
     , nvl(itreg_fat.cd_setor_produziu, 0) cd_setor_produziu
     , itreg_fat.cd_prestador
     , Decode(d.SN_Ortese_Protese,'N',itreg_fat.cd_tipo_vinculo,dbamv.fnc_ffis_define_vinculo_opm(itcob_pre.cd_fornecedor)) tp_vincu -- PDA 269072
     , itreg_fat.cd_procedimento
     , itreg_fat.CD_LANCAMENTO
     , itreg_fat.dt_lancamento
     , itreg_fat.hr_lancamento
     , d.cd_gru_pro
     , gru_pro.cd_gru_fat
     , atendime.cd_tipo_internacao
     , trunc(reg_fat.vl_ponto_prof_aih, 4) vl_ponto
     , nvl(itreg_fat.qt_pontos,0) qt_pontos
-- Serviços Hospitalares Inicio
     , decode(nvl(d.sn_enfermaria         ,'N'), 'S' , nvl(itreg_fat.qt_lancamento,0), 0) Qtd_Enfermaria
     , decode(nvl(d.sn_permanencia_maior  ,'N'), 'S' , nvl(itreg_fat.qt_lancamento,0), 0) Qtd_Permanencia_Maior
     , decode(nvl(d.sn_acompanhante       ,'N'), 'S' , decode(nvl(d.tp_acompanhante,'X'),'IC',0, nvl(itreg_fat.qt_lancamento,0)), 0) Qtd_Acompanhante
     , decode(nvl(d.tp_acompanhante       ,'X'), 'IC', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_Acomp_Idoso
     , decode(nvl(d.sn_uti_normal         ,'N'), 'S' , nvl(itreg_fat.qt_lancamento,0), 0) Qtd_Uti_Normal
     , decode(nvl(d.sn_uti                ,'N'), 'S' , nvl(itreg_fat.qt_lancamento,0), 0) Qtd_Uti_Espec
     , decode(nvl(d.sn_uci                ,'N'), 'S' , nvl(itreg_fat.qt_lancamento,0), 0) Qtd_Uci
     , decode(nvl(d.sn_enfermaria         ,'N'), 'S' , nvl(itreg_fat.vl_sh,0), 0) Vlr_Enfermaria
     , decode(nvl(d.sn_permanencia_maior  ,'N'), 'S' , nvl(itreg_fat.vl_sh,0), 0) Vlr_Permanencia_Maior
     , decode(nvl(d.sn_acompanhante       ,'N'), 'S' , nvl(itreg_fat.vl_sh, 0), 0) Vlr_Acompanhante
     , decode(nvl(d.tp_acompanhante       ,'X'), 'IC', nvl(itreg_fat.vl_sh,0), 0) Vlr_Acomp_Idoso
     , decode(nvl(d.sn_uti_normal         ,'N'), 'S' , nvl(itreg_fat.vl_sh,0), 0) Vlr_Uti_Normal
     , decode(nvl(d.sn_uti                ,'N'), 'S' , nvl(itreg_fat.vl_sh,0), 0) Vlr_Uti_Espec
     , decode(nvl(d.sn_uci                ,'N'), 'S' , nvl(itreg_fat.vl_sh,0), 0) Vlr_Uci
     , nvl(d.sn_uti_normal                ,'N') sn_uti_normal
     , nvl(d.sn_uti                       ,'N') sn_uti
-- Serviços Hospitalares Final
-- Serviços Profissionais Inicio   (Emilio)
     , 0                                                                                                Vlr_Anestesista
     , 0                                                                                                Vlr_Analg_Obstetrica
     , decode(nvl(d.sn_consulta_pediatrica,'N'), 'S',
     decode(nvl(itreg_fat.vl_sp,0), 0,
     decode(nvl(d.sn_aih_especial,'N'), 'S', nvl(itreg_fat.vl_sh,0), 0), itreg_fat.vl_sp), 0) Vlr_Consulta_Pediatrica
     , decode(nvl(d.sn_neonatologia       ,'N'), 'S',
     decode(nvl(itreg_fat.vl_sp,0), 0,
     decode(nvl(d.sn_aih_especial,'N'), 'S', nvl(itreg_fat.vl_sh,0), 0), itreg_fat.vl_sp), 0) Vlr_Neonatologia
     , decode(nvl(d.sn_perfusionista      ,'N'), 'S',
     decode(nvl(itreg_fat.vl_sp,0), 0,
     decode(nvl(d.sn_aih_especial,'N'), 'S', nvl(itreg_fat.vl_sh,0), 0), itreg_fat.vl_sp), 0) Vlr_Perfusionista
       --[PDA 422294]
     --  , decode(nvl(d.sn_uti_normal         ,'N'), 'S',
   --  decode(nvl(itreg_fat.vl_sp,0), 0,
     --  decode(nvl(d.sn_aih_especial,'N'), 'S', nvl(itreg_fat.vl_sh,0), 0), itreg_fat.vl_sp), 0) Vlr_Prof_Uti
   --  decode(nvl(d.sn_aih_especial,'N'), 'S', 0, 0), itreg_fat.vl_sp), 0) Vlr_Prof_Uti
     , decode(nvl(d.sn_uti_normal,'N'), 'S', nvl(itreg_fat.vl_sp,0), 0) Vlr_Prof_Uti
       --[PDA 422294]
     --, decode(nvl(d.sn_uti                ,'N'), 'S',
   --  decode(nvl(itreg_fat.vl_sp,0), 0,
   --  decode(nvl(d.sn_aih_especial,'N'), 'S', nvl(itreg_fat.vl_sh,0), 0), itreg_fat.vl_sp), 0) Vlr_Prof_Uti_Especializada
   --  decode(nvl(d.sn_aih_especial,'N'), 'S', nvl(itreg_fat.vl_sh,0), 0), itreg_fat.vl_sp), 0) Vlr_Prof_Uti_Especializada
     , decode(nvl(d.sn_uti,'N'), 'S', nvl(itreg_fat.vl_sp,0), 0 ) Vlr_Prof_Uti_Especializada
     , decode(nvl(d.sn_consulta_pediatrica,'N'), 'S', 0,
       decode(nvl(d.sn_neonatologia       ,'N'), 'S', 0,
--       decode(nvl(d.sn_notificacao_agravo ,'N'), 'B', 0,
       decode(nvl(d.sn_perfusionista      ,'N'), 'S', 0,
       decode(nvl(itreg_fat.cd_procedimento       ,'0'), '0802010199' , 0, --- Permanência A Maior
--       decode(nvl(itreg_fat.cd_procedimento       ,'0'), '0802010199', nvl(itreg_fat.vl_sp,0),
       decode(nvl(itreg_fat.cd_procedimento       ,'0'), '0211020028', 0,
      /*
        [Início PDA 357310]
        Em meados de 2009 o procedimento passou a montar equipe.
        Para mantar a compatibilidade foi adicionada a consulta
        na tabela itlan_med.
      */
       --decode(nvl(itreg_fat.cd_procedimento       ,'0'), '0211020010', nvl(itreg_fat.vl_sp,0),
       decode(nvl(itreg_fat.cd_procedimento       ,'0'), '0211020010', decode(( select count(*) qtd
                                                                                  from dbamv.itlan_med
                                                                                 where itlan_med.cd_reg_fat = itreg_fat.cd_reg_fat
                                                                                   and itlan_med.cd_lancamento = itreg_fat.cd_lancamento ), 0, nvl(itreg_fat.vl_sp,0), 0),
       --[Fim PDA 357310]
       decode(nvl(itreg_fat.cd_procedimento       ,'0'), '0301010072', nvl(itreg_fat.vl_sp,0),
       --decode(nvl(d.sn_enfermaria         ,'N'), 'N', 0,
       decode(nvl(d.sn_uti_normal         ,'N'), 'S', 0,
       decode(nvl(d.sn_uti                ,'N'), 'S', 0,
       decode(nvl(dbamv.FNC_FFIS_CHECA_REGRA_SUS( 'SH_ESP_NAO_ENTRA_PARA_SP', itreg_fat.cd_procedimento ),'N'), 'S', 0,
       decode(nvl(itreg_fat.vl_sp                                ,  0),   0,
       decode(nvl(d.sn_aih_especial       ,'N'), 'S', nvl(itreg_fat.vl_sh,0)
                                                                           , 0)
                                                                           ,
       decode(itreg_fat.cd_prestador                             ,Null     ,
       decode(nvl(d.sn_ortese_protese,'N'),'N'      , 0, nvl(itreg_fat.vl_sp,0))
                                                                              , nvl(itreg_fat.vl_sp,0))))))))))))) Vlr_Profissionais
      , DECODE(ITREG_FAT.CD_PRESTADOR,NULL,0
              ,DECODE(d.SN_AIH_ESPECIAL,'S'
                     ,DECODE(NVL(DBAMV.PACK_SUS.FNC_SUS_MAX_VALOR_SP(ITREG_FAT.CD_PROCEDIMENTO
                                                                    ,ITREG_FAT.CD_REG_FAT),0),0,ITREG_FAT.VL_SH,0),0)) VLR_SH_PROFISSIONAL
     , 'N'                                                                                  Prof_Anestesista
     , 'N'                                                                                  Prof_Analg_Obstetrica
     , nvl(d.sn_consulta_pediatrica       ,'N')                      Prof_Pediatria
     , nvl(d.sn_neonatologia              ,'N')                      Prof_Neonatologia
     , nvl(d.sn_perfusionista             ,'N')                      Prof_Perfusionista
     , nvl(d.sn_uti_normal                ,'N')                      Prof_Uti_Normal
     , nvl(d.sn_uti                       ,'N')                      Prof_Uti_Especializada
     , decode(nvl(d.sn_consulta_pediatrica,'N'), 'S', 'N' ,
       decode(nvl(d.sn_neonatologia       ,'N'), 'S', 'N' ,
       decode(nvl(d.sn_perfusionista      ,'N'), 'S', 'N' ,
       decode(nvl(d.sn_uti_normal         ,'N'), 'S', 'N' ,
       decode(nvl(d.sn_uti                ,'N'), 'S', 'N' , 'S'))))) Prof_Profissionais
-- Serviços Profissionais Final
-- Procedimentos Especiais Inicio
     , decode(nvl(d.sn_concentrado_fator_viii ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_concentrado_fator_viii
     , decode(nvl(d.sn_fatores_x_coagulacao   ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_fatores_x_coagulacao
     , decode(nvl(d.sn_albumina_humana        ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_albumina_humana
     , decode(nvl(d.sn_plasma_humano          ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_plasma_humano
     , decode(nvl(d.sn_arterior_neuro         ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_arterior_neuro
     , decode(nvl(d.sn_litotripsia            ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_litotripsia
     , decode(nvl(d.sn_anticorpo_anti_rh      ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_anticorpo_anti_rh
     , decode(nvl(d.sn_exosanguineo_transfusao,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_exosanguineo_transfusao
     , decode(nvl(d.sn_ciclosporina           ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_ciclosporina
     , decode(nvl(d.sn_ortese_protese         ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_ortese_protese
     , decode(nvl(d.sn_sangue                 ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_sangue
     , decode(nvl(d.sn_tomografias            ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_tomografias
     , decode(nvl(d.sn_sangue_taxa_aplicacao  ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_sangue_taxa_aplicacao
     , decode(nvl(d.sn_estudos_hemodinamicos  ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_estudos_hemodinamicos
     , decode(nvl(d.sn_imunoglobulina_g       ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_imunoglobulina_g
     , decode(nvl(d.sn_estreptoquinase        ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_estreptoquinase
     , decode(nvl(d.sn_criacao_fav            ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_criacao_fav
     , decode(nvl(d.sn_anticorpo_monocloral   ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_anticorpo_monocloral
     , decode(nvl(d.sn_globulina_antimocitaria,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_globulina_antimocitaria
     , decode(nvl(d.sn_ciclosporina_capsula   ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_ciclosporina_capsula
     , decode(nvl(d.sn_metilprednisilona      ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_metilprednisilona
     , decode(nvl(d.sn_surfactante_fr_amp     ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_surfactante_fr_amp
     , decode(nvl(d.sn_nutricao_enteral       ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_nutricao_enteral
     , decode(nvl(d.sn_tomografias_neuro      ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_tomografias_neuro
     , decode(nvl(d.sn_componente_i           ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_componente_i
     , decode(nvl(d.sn_registro_civil         ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_registro_civil
     , decode(nvl(d.sn_teste_hiv              ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_teste_hiv
     , decode(nvl(d.sn_hemodialise_pac_renais ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_hemodialise_pac_renais
     , decode(nvl(d.sn_dialise_pac_renais     ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_dialise_pac_renais
     , decode(nvl(d.sn_hemoperfusao           ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_hemoperfusao
     , decode(nvl(d.sn_ultrafiltracao_continua,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_ultrafiltracao_continua
     , decode(nvl(d.sn_hemodialise_continua   ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_hemodialise_continua
     , decode(nvl(d.sn_hemofiltracao_continua ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_hemofiltracao_continua
     , decode(nvl(d.sn_hediafiltracao_continua,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_hediafiltracao_continua
     , decode(nvl(d.sn_hemofiltracao          ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_hemofiltracao
     , decode(nvl(d.sn_concentrado_fator_viii ,'N'),'S', 0,
       decode(nvl(d.sn_fatores_x_coagulacao   ,'N'),'S', 0,
       decode(nvl(d.sn_albumina_humana        ,'N'),'S', 0,
       decode(nvl(d.sn_plasma_humano          ,'N'),'S', 0,
       decode(nvl(d.sn_arterior_neuro         ,'N'),'S', 0,
       decode(nvl(d.sn_litotripsia            ,'N'),'S', 0,
       decode(nvl(d.sn_anticorpo_anti_rh      ,'N'),'S', 0,
       decode(nvl(d.sn_exosanguineo_transfusao,'N'),'S', 0,
       decode(nvl(d.sn_ciclosporina           ,'N'),'S', 0,
       decode(nvl(d.sn_ortese_protese         ,'N'),'S', 0,
       decode(nvl(d.sn_sangue                 ,'N'),'S', 0,
       decode(nvl(d.sn_tomografias            ,'N'),'S', 0,
       decode(nvl(d.sn_sangue_taxa_aplicacao  ,'N'),'S', 0,
       decode(nvl(d.sn_estudos_hemodinamicos  ,'N'),'S', 0,
       decode(nvl(d.sn_imunoglobulina_g       ,'N'),'S', 0,
       decode(nvl(d.sn_estreptoquinase        ,'N'),'S', 0,
       decode(nvl(d.sn_criacao_fav            ,'N'),'S', 0,
       decode(nvl(d.sn_anticorpo_monocloral   ,'N'),'S', 0,
       decode(nvl(d.sn_globulina_antimocitaria,'N'),'S', 0,
       decode(nvl(d.sn_ciclosporina_capsula   ,'N'),'S', 0,
       decode(nvl(d.sn_metilprednisilona      ,'N'),'S', 0,
       decode(nvl(d.sn_surfactante_fr_amp     ,'N'),'S', 0,
       decode(nvl(d.sn_nutricao_enteral       ,'N'),'S', 0,
       decode(nvl(d.sn_tomografias_neuro      ,'N'),'S', 0,
       decode(nvl(d.sn_componente_i           ,'N'),'S', 0,
       decode(nvl(d.sn_registro_civil         ,'N'),'S', 0,
       decode(nvl(d.sn_teste_hiv              ,'N'),'S', 0,
       decode(nvl(d.sn_hemodialise_pac_renais ,'N'),'S', 0,
       decode(nvl(d.sn_dialise_pac_renais     ,'N'),'S', 0,
       decode(nvl(d.sn_hemoperfusao           ,'N'),'S', 0,
       decode(nvl(d.sn_ultrafiltracao_continua,'N'),'S', 0,
       decode(nvl(d.sn_hemodialise_continua   ,'N'),'S', 0,
       decode(nvl(d.sn_hemofiltracao_continua ,'N'),'S', 0,
       decode(nvl(d.sn_hediafiltracao_continua,'N'),'S', 0,
       decode(nvl(d.sn_hemofiltracao          ,'N'),'S', 0,
       decode(nvl(d.sn_notificacao_agravo     ,'N'),'S', 0,   -- Previsao Valores Teto
       decode(nvl(d.sn_cateterismo            ,'N'),'S', 0,   -- Previsao Valores Teto
       decode(nvl(d.sn_enfermaria             ,'N'),'S', 0,
       decode(nvl(d.sn_permanencia_maior      ,'N'),'S', 0,
       decode(nvl(d.sn_acompanhante           ,'N'),'S', 0,
       decode(nvl(d.tp_acompanhante          ,'X'),'IC', 0,
       decode(nvl(d.sn_uti_normal             ,'N'),'S', 0,
       decode(nvl(d.sn_uti                    ,'N'),'S', 0,
       decode(nvl(d.sn_uci                    ,'N'),'S', 0,
       decode(nvl(dbamv.FNC_FFIS_CHECA_REGRA_SUS( 'VALOR_SH_AGRUPAMENTO_ESPECIAIS', itreg_fat.cd_procedimento ),'N'),'S',0,
              nvl(itreg_fat.qt_lancamento,0)))))))))))))))))))))))))))))))))))))))))))))) Qtd_Proc_Diversos
     , decode(nvl(d.sn_concentrado_fator_viii ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_concentrado_fator_viii
     , decode(nvl(d.sn_fatores_x_coagulacao   ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_fatores_x_coagulacao
     , decode(nvl(d.sn_albumina_humana        ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_albumina_humana
     , decode(nvl(d.sn_plasma_humano          ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_plasma_humano
     , decode(nvl(d.sn_arterior_neuro         ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_arterior_neuro
     , decode(nvl(d.sn_litotripsia            ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_litotripsia
     , decode(nvl(d.sn_anticorpo_anti_rh      ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_anticorpo_anti_rh
     , decode(nvl(d.sn_exosanguineo_transfusao,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_exosanguineo_transfusao
     , decode(nvl(d.sn_ciclosporina           ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_ciclosporina
     , decode(nvl(d.sn_ortese_protese         ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_ortese_protese
     , decode(nvl(d.sn_sangue                 ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_sangue    -- (Emilio)
     , decode(nvl(d.sn_tomografias            ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_tomografias
     , decode(nvl(d.sn_sangue_taxa_aplicacao  ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_sangue_taxa_aplicacao
     , decode(nvl(d.sn_estudos_hemodinamicos  ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_estudos_hemodinamicos
     , decode(nvl(d.sn_imunoglobulina_g       ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_imunoglobulina_g
     , decode(nvl(d.sn_estreptoquinase        ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_estreptoquinase
     , decode(nvl(d.sn_criacao_fav            ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_criacao_fav
     , decode(nvl(d.sn_anticorpo_monocloral   ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_anticorpo_monocloral
     , decode(nvl(d.sn_globulina_antimocitaria,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_globulina_antimocitaria
     , decode(nvl(d.sn_ciclosporina_capsula   ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_ciclosporina_capsula
     , decode(nvl(d.sn_metilprednisilona      ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_metilprednisilona
     , decode(nvl(d.sn_surfactante_fr_amp     ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_surfactante_fr_amp
     , decode(nvl(d.sn_nutricao_enteral       ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_nutricao_enteral
     , decode(nvl(d.sn_tomografias_neuro      ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_tomografias_neuro
     , decode(nvl(d.sn_componente_i           ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_componente_i
     , decode(nvl(d.sn_registro_civil         ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_registro_civil
     , decode(nvl(d.sn_teste_hiv              ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_teste_hiv
     , decode(nvl(d.sn_hemodialise_pac_renais ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_hemodialise_pac_renais
     , decode(nvl(d.sn_dialise_pac_renais     ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_dialise_pac_renais
     , decode(nvl(d.sn_hemoperfusao           ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_hemoperfusao
     , decode(nvl(d.sn_ultrafiltracao_continua,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_ultrafiltracao_continua
     , decode(nvl(d.sn_hemodialise_continua   ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_hemodialise_continua
     , decode(nvl(d.sn_hemofiltracao_continua ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_hemofiltracao_continua
     , decode(nvl(d.sn_hediafiltracao_continua,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_hediafiltracao_continua
     , decode(nvl(d.sn_hemofiltracao          ,'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_hemofiltracao
     , decode(nvl(d.sn_concentrado_fator_viii ,'N'),'S', 0,
       decode(nvl(d.sn_fatores_x_coagulacao   ,'N'),'S', 0,
       decode(nvl(d.sn_albumina_humana        ,'N'),'S', 0,
       decode(nvl(d.sn_plasma_humano          ,'N'),'S', 0,
       decode(nvl(d.sn_arterior_neuro         ,'N'),'S', 0,
       decode(nvl(d.sn_litotripsia            ,'N'),'S', 0,
       decode(nvl(d.sn_anticorpo_anti_rh      ,'N'),'S', 0,
       decode(nvl(d.sn_exosanguineo_transfusao,'N'),'S', 0,
       decode(nvl(d.sn_ciclosporina           ,'N'),'S', 0,
       decode(nvl(d.sn_ortese_protese         ,'N'),'S', 0,
       decode(nvl(d.sn_sangue                 ,'N'),'S', 0,
       decode(nvl(d.sn_tomografias            ,'N'),'S', 0,
       decode(nvl(d.sn_sangue_taxa_aplicacao  ,'N'),'S', 0,
       decode(nvl(d.sn_estudos_hemodinamicos  ,'N'),'S', 0,
       decode(nvl(d.sn_imunoglobulina_g       ,'N'),'S', 0,
       decode(nvl(d.sn_estreptoquinase        ,'N'),'S', 0,
       decode(nvl(d.sn_criacao_fav            ,'N'),'S', 0,
       decode(nvl(d.sn_anticorpo_monocloral   ,'N'),'S', 0,
       decode(nvl(d.sn_globulina_antimocitaria,'N'),'S', 0,
       decode(nvl(d.sn_ciclosporina_capsula   ,'N'),'S', 0,
       decode(nvl(d.sn_metilprednisilona      ,'N'),'S', 0,
       decode(nvl(d.sn_surfactante_fr_amp     ,'N'),'S', 0,
       decode(nvl(d.sn_nutricao_enteral       ,'N'),'S', 0,
       decode(nvl(d.sn_tomografias_neuro      ,'N'),'S', 0,
       decode(nvl(d.sn_componente_i           ,'N'),'S', 0,
       decode(nvl(d.sn_registro_civil         ,'N'),'S', 0,
       decode(nvl(d.sn_teste_hiv              ,'N'),'S', 0,
       decode(nvl(d.sn_hemodialise_pac_renais ,'N'),'S', 0,
       decode(nvl(d.sn_dialise_pac_renais     ,'N'),'S', 0,
       decode(nvl(d.sn_hemoperfusao           ,'N'),'S', 0,
       decode(nvl(d.sn_ultrafiltracao_continua,'N'),'S', 0,
       decode(nvl(d.sn_hemodialise_continua   ,'N'),'S', 0,
       decode(nvl(d.sn_hemofiltracao_continua ,'N'),'S', 0,
       decode(nvl(d.sn_hediafiltracao_continua,'N'),'S', 0,
       decode(nvl(d.sn_hemofiltracao          ,'N'),'S', 0,
       decode(nvl(d.sn_notificacao_agravo     ,'N'),'S', 0,   -- Previsao Valores Teto
       decode(nvl(d.sn_cateterismo            ,'N'),'S', 0,   -- Previsao Valores Teto
       decode(nvl(d.sn_enfermaria             ,'N'),'S', 0,
       decode(nvl(d.sn_permanencia_maior      ,'N'),'S', 0,
       decode(nvl(d.sn_acompanhante           ,'N'),'S', 0,
       decode(nvl(d.tp_acompanhante          ,'X'),'IC', 0,
       decode(nvl(d.sn_uti_normal             ,'N'),'S', 0,
       decode(nvl(d.sn_uti                    ,'N'),'S', 0,
       decode(nvl(d.sn_uci                    ,'N'),'S', 0,
       decode(nvl(dbamv.FNC_FFIS_CHECA_REGRA_SUS( 'VALOR_SH_AGRUPAMENTO_ESPECIAIS', itreg_fat.cd_procedimento ),'N'),'S',0,
              nvl(itreg_fat.vl_sh,0)))))))))))))))))))))))))))))))))))))))))))))) Vlr_Proc_Diversos
     , nvl(d.sn_ortese_protese,'N') sn_ortese_protese
     , nvl(d.sn_teste_hiv     ,'N') sn_teste_hiv
-- Procedimentos Especiais Final
-- Previsao Valores Teto Inicio
     , decode(nvl(d.sn_notificacao_agravo  ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_notificacao_agravo
     , decode(nvl(d.sn_cateterismo         ,'N'),'S', nvl(itreg_fat.qt_lancamento,0), 0) Qtd_cateterismo
     , decode(nvl(dbamv.FNC_FFIS_CHECA_REGRA_SUS( 'INSTALACAO_CATETER_ACESSO_VENOSO', itreg_fat.cd_procedimento ),'N'),'S', nvl(itreg_fat.qt_lancamento,0) , 0) Qtd_Acesso_Venoso
     , decode(nvl(d.sn_notificacao_agravo  ,'N'),'S', nvl(itreg_fat.vl_sh,0)        , 0) Vlr_notificacao_agravo
     , decode(nvl(d.sn_cateterismo         ,'N'),'S', decode(nvl(itreg_fat.vl_sh,0),0,itreg_fat.vl_sp,nvl(itreg_fat.vl_sh,0)) , 0) Vlr_cateterismo
     , decode(nvl(dbamv.FNC_FFIS_CHECA_REGRA_SUS( 'INSTALACAO_CATETER_ACESSO_VENOSO', itreg_fat.cd_procedimento ),'N'),'S', nvl(itreg_fat.vl_sh,0), 0) Vlr_Acesso_Venoso
--   , decode(nvl(d.sn_paciente_renal_agudo,'N'),'S', nvl(itreg_fat.vl_sh,0)+
--                                                                           nvl(itreg_fat.vl_sp,0), 0) Vlr_paciente_renal_agudo
-- Previsao Valores Teto Final
  , decode(d.sn_ortese_protese,'S','N',decode(itreg_fat.cd_prestador,null,'S','N')) sn_equipe
  , d.sn_parto --OP 34237
  , ITREG_FAT.SN_PERTENCE_PACOTE -- #OP:37790 // Leone Oliveira :
  from dbamv.reg_fat
     , dbamv.itreg_fat
     , dbamv.itcob_pre -- PDA 269072
     , dbamv.remessa_fatura
     , dbamv.fatura
     , dbamv.procedimento_detalhe_vigencia d
     , dbamv.gru_pro
     , dbamv.atendime
     , dbamv.gru_fat --
     , dbamv.item_res --
 where reg_fat.cd_convenio              in (21,22)
   and reg_fat.cd_reg_fat               = itreg_fat.cd_reg_fat
   and itcob_pre.cd_reg_fat(+)          = itreg_fat.cd_reg_fat -- PDA 269072
   and itcob_pre.cd_lancamento(+)       = itreg_fat.cd_lancamento -- PDA 269072
   and ItReg_Fat.Cd_Gru_Fat             = Gru_Fat.Cd_Gru_Fat
   and item_res.cd_item_res(+)          = NVL (gru_fat.cd_item_res_sh, gru_fat.cd_item_res)
   and remessa_fatura.cd_remessa(+)     = reg_fat.cd_remessa
   and fatura.cd_fatura(+)              = remessa_fatura.cd_fatura -- #OP:39927 // Leone Oliveira
   and atendime.cd_atendimento          = reg_fat.cd_atendimento
   and gru_pro.cd_gru_pro               = d.cd_gru_pro
   and itreg_fat.cd_procedimento        = d.cd_procedimento
   and trunc(itreg_fat.dt_lancamento, 'MONTH') between d.dt_validade_inicial and nvl(d.dt_validade_final, trunc(itreg_fat.dt_lancamento, 'MONTH'))
   and fatura.cd_convenio(+)            in (21,22) -- #OP:39927 // Leone Oliveira
   and fatura.cd_multi_empresa          = 3 -- #OP:45780 // LPDO
   AND itreg_fat.sn_pertence_pacote     = 'N'
   AND FATURA.DT_COMPETENCIA = to_date('{V_COMPETENCIA}','MM/YYYY') 
--   and (itreg_fat.cd_prestador is not null or                       -- Sem equipe
--        nvl(d.sn_ortese_protese,'N') = 'S')  -- ou Ortese e protese
 union all
-- Contas com equipe medica
select reg_fat.cd_multi_empresa
     , REG_FAT.CD_REG_FAT_GLOSA
     , reg_fat.cd_atendimento
     , reg_fat.cd_convenio
     , reg_fat.cd_con_pla
     , fatura.dt_competencia
     , remessa_fatura.cd_remessa
     , remessa_fatura.sn_fechada remessa_fechada
     , reg_fat.cd_reg_fat
     , reg_fat.sn_fechada conta_fechada
     , reg_fat.cd_espec_sus
     , reg_fat.dt_final
     , Item_Res.Cd_Item_Res
     , Item_Res.Tp_Receita
     , nvl(itreg_fat.cd_setor, 0) cd_setor
     , nvl(itreg_fat.cd_setor_produziu, 0) cd_setor_produziu
     , itlan_med.cd_prestador
     , itlan_med.cd_tipo_vinculo tp_vincu
     , itreg_fat.cd_procedimento
     , itreg_fat.CD_LANCAMENTO
     , itreg_fat.dt_lancamento
     , itreg_fat.hr_lancamento
     , d.cd_gru_pro
     , gru_pro.cd_gru_fat
     , atendime.cd_tipo_internacao
     , trunc(reg_fat.vl_ponto_prof_aih, 4) vl_ponto
     , nvl(itlan_med.qt_pontos,0) qt_pontos
-- Serviços Hospitalares Inicio
     , 0 Qtd_Enfermaria
     , 0 Qtd_Permanencia_Maior
     , 0 Qtd_Acompanhante
     , 0 Qtd_Acomp_Idoso
     , 0 Qtd_Uti_Normal
     , 0 Qtd_Uti_Espec
     , 0 Qtd_Uci
     , 0 Vlr_Enfermaria
     , 0 Vlr_Permanencia_Maior
     , 0 Vlr_Acompanhante
     , 0 Vlr_Acomp_Idoso
     , 0 Vlr_Uti_Normal
     , 0 Vlr_Uti_Espec
     , 0 Vlr_Uci
     , nvl(d.sn_uti_normal, 'N') sn_uti_normal
     , nvl(d.sn_uti       , 'N') sn_uti
-- Serviços Hospitalares Final
-- Serviços Profissionais Inicio
     , decode(nvl(itlan_med.cd_ati_med,'XX'), '06', itlan_med.vl_ato, 0) Vlr_Anestesista
     , 0 Vlr_Analg_Obstetrica
     , 0 Vlr_Consulta_Pediatrica
     , 0 Vlr_Neonatologia
     , 0 Vlr_Perfusionista
     , 0 Vlr_Prof_Uti
     , 0 Vlr_Prof_Uti_Especializada
     , decode(nvl(itlan_med.cd_ati_med,'XX'), '06', 0, itlan_med.vl_ato) Vlr_Profissionais
     , 0 VLR_SH_PROFISSIONAL
     , decode(nvl(itlan_med.cd_ati_med,'XX'), '06', 'S', 'N')            Prof_Anestesista
     , 'N' Prof_Analg_Obstetrica
     , 'N' Prof_Pediatria
     , 'N' Prof_Neonatologia
     , 'N' Prof_Perfusionista
     , 'N' Prof_Uti_Normal
     , 'N' Prof_Uti_Especializada
     , decode(nvl(itlan_med.cd_ati_med,'XX'), '06', 'N', 'S')            Prof_Profissionais
-- Serviços Profissionais Final
-- Procedimentos Especiais Inicio
     , 0 Qtd_concentrado_fator_viii
     , 0 Qtd_fatores_x_coagulacao
     , 0 Qtd_albumina_humana
     , 0 Qtd_plasma_humano
     , 0 Qtd_arterior_neuro
     , 0 Qtd_litotripsia
     , 0 Qtd_anticorpo_anti_rh
     , 0 Qtd_exosanguineo_transfusao
     , 0 Qtd_ciclosporina
     , 0 Qtd_ortese_protese
     , 0 Qtd_sangue
     , 0 Qtd_tomografias
     , 0 Qtd_sangue_taxa_aplicacao
     , 0 Qtd_estudos_hemodinamicos
     , 0 Qtd_imunoglobulina_g
     , 0 Qtd_estreptoquinase
     , 0 Qtd_criacao_fav
     , 0 Qtd_anticorpo_monocloral
     , 0 Qtd_globulina_antimocitaria
     , 0 Qtd_ciclosporina_capsula
     , 0 Qtd_metilprednisilona
     , 0 Qtd_surfactante_fr_amp
     , 0 Qtd_nutricao_enteral
     , 0 Qtd_tomografias_neuro
     , 0 Qtd_componente_i
     , 0 Qtd_registro_civil
     , 0 Qtd_teste_hiv
     , 0 Qtd_hemodialise_pac_renais
     , 0 Qtd_dialise_pac_renais
     , 0 Qtd_hemoperfusao
     , 0 Qtd_ultrafiltracao_continua
     , 0 Qtd_hemodialise_continua
     , 0 Qtd_hemofiltracao_continua
     , 0 Qtd_hediafiltracao_continua
     , 0 Qtd_hemofiltracao
     , 0 Qtd_Proc_Diversos
     , 0 Vlr_concentrado_fator_viii
     , 0 Vlr_fatores_x_coagulacao
     , 0 Vlr_albumina_humana
     , 0 Vlr_plasma_humano
     , 0 Vlr_arterior_neuro
     , 0 Vlr_litotripsia
     , 0 Vlr_anticorpo_anti_rh
     , 0 Vlr_exosanguineo_transfusao
     , 0 Vlr_ciclosporina
     , 0 Vlr_ortese_protese
     , 0 Vlr_sangue
     , 0 Vlr_tomografias
     , 0 Vlr_sangue_taxa_aplicacao
     , 0 Vlr_estudos_hemodinamicos
     , 0 Vlr_imunoglobulina_g
     , 0 Vlr_estreptoquinase
     , 0 Vlr_criacao_fav
     , 0 Vlr_anticorpo_monocloral
     , 0 Vlr_globulina_antimocitaria
     , 0 Vlr_ciclosporina_capsula
     , 0 Vlr_metilprednisilona
     , 0 Vlr_surfactante_fr_amp
     , 0 Vlr_nutricao_enteral
     , 0 Vlr_tomografias_neuro
     , 0 Vlr_componente_i
     , 0 Vlr_registro_civil
     , 0 Vlr_teste_hiv
     , 0 Vlr_hemodialise_pac_renais
     , 0 Vlr_dialise_pac_renais
     , 0 Vlr_hemoperfusao
     , 0 Vlr_ultrafiltracao_continua
     , 0 Vlr_hemodialise_continua
     , 0 Vlr_hemofiltracao_continua
     , 0 Vlr_hediafiltracao_continua
     , 0 Vlr_hemofiltracao
     , 0 Vlr_Proc_Diversos
     , nvl(d.sn_ortese_protese,'N') sn_ortese_protese
     , nvl(d.sn_teste_hiv     ,'N') sn_teste_hiv
-- Procedimentos Especiais Final
-- Previsao Valores Teto Inicio
     -- << Falta Definicao Transplante  >>
     , 0 Qtd_notificacao_agravo
     , 0 Qtd_cateterismo
     , 0 Qtd_Acesso_Venoso
     , 0 Vlr_notificacao_agravo
     , 0 Vlr_cateterismo
     , 0 Vlr_Acesso_Venoso
--   , 0 Vlr_paciente_renal_agudo
-- Previsao Valores Teto Final
  , decode(d.sn_ortese_protese,'S','N',decode(itreg_fat.cd_prestador,null,'S','N')) sn_equipe
  , d.sn_parto --OP 34237
  , ITREG_FAT.SN_PERTENCE_PACOTE -- #OP:37790 // Leone Oliveira :
  from dbamv.reg_fat
     , dbamv.itreg_fat
     , dbamv.itlan_med
     , dbamv.remessa_fatura
     , dbamv.fatura
     , dbamv.procedimento_detalhe_vigencia d
     , dbamv.gru_pro
     , dbamv.atendime
     , dbamv.gru_fat --
     , dbamv.item_res --
 where reg_fat.cd_convenio              IN (21,22) --
   and reg_fat.cd_reg_fat               = itreg_fat.cd_reg_fat
   and ItReg_Fat.Cd_Gru_Fat             = Gru_Fat.Cd_Gru_Fat --
   and item_res.cd_item_res(+)          = NVL (gru_fat.cd_item_res_sh, gru_fat.cd_item_res) --
   and remessa_fatura.cd_remessa(+)     = reg_fat.cd_remessa
   and fatura.cd_fatura(+)              = remessa_fatura.cd_fatura -- #OP:39927 // Leone Oliveira
   and gru_pro.cd_gru_pro               = d.cd_gru_pro
   and atendime.cd_atendimento          = reg_fat.cd_atendimento
   and itreg_fat.cd_procedimento        = d.cd_procedimento
   and trunc(itreg_fat.dt_lancamento, 'MONTH') between d.dt_validade_inicial and nvl(d.dt_validade_final, trunc(itreg_fat.dt_lancamento, 'MONTH'))
   and itreg_fat.cd_reg_fat             = itlan_med.cd_reg_fat
   and itreg_fat.cd_lancamento          = itlan_med.cd_lancamento
   and fatura.cd_convenio(+)            IN( 21,22) -- #OP:39927 // Leone Oliveira
   and fatura.cd_multi_empresa          = 3
   AND itreg_fat.sn_pertence_pacote     = 'N'
   AND fatura.dt_competencia = to_date('{V_COMPETENCIA}','MM/YYYY')  
   ) fat_sus
   JOIN dbamv.ATENDIME
     ON FAT_SUS.CD_ATENDIMENTO = ATENDIME.CD_ATENDIMENTO
   JOIN DBAMV.PACIENTE
     ON ATENDIME.CD_PACIENTE = PACIENTE.CD_PACIENTE
   LEFT JOIN DBAMV.PROCEDIMENTO_SUS 
     ON FAT_SUS.CD_PROCEDIMENTO = PROCEDIMENTO_SUS.CD_PROCEDIMENTO
   LEFT JOIN DBAMV.PRESTADOR 
     ON FAT_SUS.CD_PRESTADOR = PRESTADOR.CD_PRESTADOR 
   LEFT JOIN DBAMV.SETOR
     ON FAT_SUS.CD_SETOR = SETOR.CD_SETOR
   LEFT JOIN DBAMV.REG_FAT
     ON FAT_SUS.CD_REG_FAT = REG_FAT.CD_REG_FAT
    AND fat_sus.cd_atendimento = reg_fat.cd_atendimento 
WHERE PRESTADOR.CD_PRESTADOR IN ({V_LISTA_PRESTADOR_AUX})
  AND SETOR.CD_SETOR IN ({V_LISTA_SETOR_AUX})
  and tp_vincu In (1, 2)
   

ORDER BY 1,3,5
                                                                                            

                                                              