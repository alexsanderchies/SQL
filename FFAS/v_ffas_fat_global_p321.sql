SELECT   eve_siasus.cd_apac
         , eve_siasus.cd_atendimento
         , eve_siasus.cd_carater_atendimento
         , eve_siasus.cd_cbo_prestador
         , eve_siasus.cd_cid_principal
         , eve_siasus.cd_cid_secundario
         , eve_siasus.cd_cidade
         , eve_siasus.cd_cirurgia_aviso
         , eve_siasus.cd_convenio
         , eve_siasus.cd_decendio
         , eve_siasus.cd_especialid
         , eve_siasus.cd_eventos
         , eve_siasus.cd_faixa_etaria
         , eve_siasus.cd_fat_sia
         , eve_siasus.cd_fat_sia_reapresent
         , eve_siasus.cd_gru_ate
         , eve_siasus.cd_imp_fat
         , eve_siasus.cd_it_marcacao
         , eve_siasus.cd_itped_lab
         , eve_siasus.cd_itped_rx
         , eve_siasus.cd_multi_empresa
         , nvl( eve_siasus.cd_ori_ate, atendime.cd_ori_ate ) cd_ori_ate
         , eve_siasus.cd_paciente
         , eve_siasus.cd_prestador
         , eve_siasus.cd_prestador_executante
         , eve_siasus.cd_prestador_pode_ter
         , eve_siasus.cd_procedimento
         , eve_siasus.cd_servico
         , nvl( eve_siasus.cd_setor, nvl( ori_ate.cd_setor , nvl( set_ori_ate.cd_setor , 9999) ) )  cd_setor
         , eve_siasus.cd_setor_produziu
         , eve_siasus.cd_sisco_cito
         , eve_siasus.cd_sisco_histo
         , eve_siasus.cd_sms
         , eve_siasus.cd_ssm
         , eve_siasus.cd_unidade_regional
         , eve_siasus.cd_ups
         , eve_siasus.ds_local_exportacao
         , eve_siasus.dt_decendio
         , eve_siasus.dt_eve_siasus
         , eve_siasus.nm_paciente
         , eve_siasus.nm_usuario
         , eve_siasus.nr_autorizacao_gestor
         , eve_siasus.nr_cnpj
         , eve_siasus.nr_idade
         , eve_siasus.nr_nota
         , eve_siasus.qt_lancada
         , eve_siasus.sn_sobra
         , eve_siasus.vl_base_repassado
         , eve_siasus.vl_base_repassado_anest
         , eve_siasus.vl_servico_ambulatorial
         , eve_siasus.vl_servico_anestesia
         , eve_siasus.vl_servico_profissional
         , eve_siasus.vl_total_ambulatorial
         , eve_siasus.vl_servico_ambulatorial vl_unitario
         , tip_ate_apac.ds_tip_ate
         , tip_ate_apac.nr_validade
         , apac.cd_remessa
         , fat_sia.ds_fat_sia
         , fat_sia.dt_competencia
         , fat_sia.dt_fechamento
         , fat_sia.dt_periodo_final
         , fat_sia.dt_periodo_inicial
         , fat_sia.hr_fechamento
         , fat_sia.lg_situacao
         , fat_sia.nm_usuario_fechou
         , fat_sia.tipo_fatura
         , decendios_fat_sia.ds_decendio
         , decendios_fat_sia.dt_final
         , decendios_fat_sia.dt_inicial
         , decendios_fat_sia.sn_aberto
         , procedimento_sus.cd_grupo_procedimento
         , procedimento_sus.cd_organiza_grupo_procedimento
         , procedimento_sus.cd_sub_grupo_procedimento
         , procedimento_sus.ds_procedimento
         , procedimento_sus.nr_dias_internacao
         , procedimento_sus.nr_idade_maxima
         , procedimento_sus.nr_idade_minima
         , procedimento_sus.qt_maxima
         , procedimento_sus.sn_ativo sn_ativo_pro_sus
         , procedimento_sus.sn_ato_anestesico
         , procedimento_sus.tp_financiamento
         , procedimento_sus.tp_sexo
         , procedimento_detalhe_vigencia.qt_maxima_autorizado
         , procedimento_detalhe_vigencia.sn_admite_longa_permanencia
         , procedimento_detalhe_vigencia.sn_permite_aih_continuacao
         , procedimento_detalhe_vigencia.sn_hemoterapia
         , procedimento_detalhe_vigencia.sn_siscolo
         , procedimento_detalhe_vigencia.sn_sismama
         , procedimento_detalhe_vigencia.sn_parto
         , procedimento_detalhe_vigencia.sn_vasectomia
         , procedimento_detalhe_vigencia.sn_laqueadura
         , procedimento_detalhe_vigencia.sn_valida_cancer_hiv
         , procedimento_detalhe_vigencia.sn_valida_espec_sus
         , procedimento_detalhe_vigencia.sn_calcula_pt_profissional
         , procedimento_detalhe_vigencia.sn_uti
         , procedimento_detalhe_vigencia.tp_uti
         , procedimento_detalhe_vigencia.sn_cnrac
         , procedimento_detalhe_vigencia.sn_cirurgia_eletiva
         , procedimento_detalhe_vigencia.sn_cirurgia_multipla
         , procedimento_detalhe_vigencia.sn_calcula_aih
         , procedimento_detalhe_vigencia.sn_alta_reoperacao
         , procedimento_detalhe_vigencia.sn_obriga_cnpj_prestador
         , procedimento_detalhe_vigencia.sn_obriga_proc_compat
         , procedimento_detalhe_vigencia.sn_urgencia
         , procedimento_detalhe_vigencia.sn_diaria_acompanhante
         , procedimento_detalhe_vigencia.sn_obriga_vdrl
         , procedimento_detalhe_vigencia.cd_gru_pro_amb cd_gru_pro
         , gru_pro.cd_gru_fat --OP 2116
         , procedimento_detalhe_vigencia.sn_modulo_transfusional
         , procedimento_detalhe_vigencia.sn_exige_multiplo
         , procedimento_detalhe_vigencia.sn_admite_mudanca_procedimento
         , procedimento_detalhe_vigencia.sn_solicitado_igual_realizado
         , procedimento_detalhe_vigencia.sn_permite_conta_sem_dt_alta
         , procedimento_detalhe_vigencia.sn_pode_ser_autorizado
         , procedimento_detalhe_vigencia.tp_apac
         , procedimento_detalhe_vigencia.sn_obriga_feto_vivo
         , procedimento_detalhe_vigencia.sn_permite_zerado
         , procedimento_detalhe_vigencia.sn_obriga_compatibilidade
         , procedimento_detalhe_vigencia.nr_auxiliar
         , procedimento_detalhe_vigencia.sn_permite_permanencia_maior
         , procedimento_detalhe_vigencia.cd_codigo_reduzido
         , procedimento_detalhe_vigencia.sn_permite_busca_ativa
         , procedimento_detalhe_vigencia.sn_permite_exames
         , procedimento_detalhe_vigencia.sn_permite_alta_uti
         , procedimento_detalhe_vigencia.sn_carater_internacao_hosp_dia
         , decode(dbamv.fnc_ctrl_procedimento('A', '06', NULL, eve_siasus.cd_procedimento, to_char(eve_siasus.dt_eve_siasus,'dd/mm/yyyy'), 'E'),'P','S','N') sn_apac_principal
         , decode(dbamv.fnc_ctrl_procedimento('A', '07', NULL, eve_siasus.cd_procedimento, to_char(eve_siasus.dt_eve_siasus,'dd/mm/yyyy'), 'E'),'S','S','N') sn_apac_secundario
         , decode(dbamv.fnc_ctrl_procedimento('A', '01', NULL, eve_siasus.cd_procedimento, to_char(eve_siasus.dt_eve_siasus,'dd/mm/yyyy'), 'E'),'C','S','N') sn_bpa_consolidado
         , decode(dbamv.fnc_ctrl_procedimento('A', '02', NULL, eve_siasus.cd_procedimento, to_char(eve_siasus.dt_eve_siasus,'dd/mm/yyyy'), 'E'),'I','S','N') sn_bpa_individualizado
         , procedimento_detalhe_vigencia.sn_aih_principal
         , procedimento_detalhe_vigencia.sn_aih_secundario
         , procedimento_detalhe_vigencia.sn_aih_especial
         , procedimento_detalhe_vigencia.cd_tip_ate
         , procedimento_sus_valor.dt_vigencia
         , procedimento_sus_valor.qt_pontos
         , procedimento_sus_valor.vl_servico_ambulatorial p_vl_servico_ambulatorial
         , procedimento_sus_valor.vl_servico_anestesia_amb p_vl_servico_anestesia_amb
         , procedimento_sus_valor.vl_servico_hospitalar p_vl_servico_hospitalar
         , procedimento_sus_valor.vl_servico_profissional p_vl_servico_profissional
         , procedimento_sus_valor.vl_servico_profissional_amb p_vl_servico_profissional_amb
         , procedimento_sus_valor.vl_total_ambulatorial p_vl_total_ambulatorial
         , procedimento_sus_valor.vl_total_internacao p_vl_total_internacao
         , grupo_procedimentos.ds_grupo_procedimento
         , grupo_procedimentos.sn_ativo sn_ativo_gru_pro
         , sub_grupo_procedimentos.ds_sub_grupo_procedimento
         , sub_grupo_procedimentos.sn_ativo sn_ativo_sub_gru_pro
         , organiza_grupo_procedimentos.ds_organiza_grupo_procedimento
         , organiza_grupo_procedimentos.sn_ativo sn_ativo_org_gru_pro
         , procedimento_detalhe_vigencia.tp_complexidade_procedimento
         , '' sn_ativo_pro_sus_com
         , complexidade_procedimento.ds_complexidade_procedimento
         , unidade_regional.cd_diretoria_regional
         , unidade_regional.ds_unidade_regional
         , DECODE ((SELECT sn_gera_atend
                      FROM dbamv.config_ffas
                     WHERE config_ffas.cd_multi_empresa = 1), 'N', '-', NVL (unidade_regional.tp_unidade, 'I')) tp_unidade
         , (select glosas_sia_sus.cd_glosa_sia_sus
              from glosas_sia_sus
             where glosas_sia_sus.cd_apac = apac.cd_apac
               and glosas_sia_sus.cd_fat_sia = apac.cd_fat_sia) cd_glosa_sia_sus --op 22502
         , nvl( atendime.tp_Atendimento,'A')tp_atendimento
         , eve_siasus.cd_remessa
         , eve_siasus.sn_pacote
         , remessa_bpa.tp_remessa --OP:1834
		 , eve_siasus.cd_motivo_glosa  	   -- OP 15493
		 , eve_siasus.cd_eve_reapresentada -- OP 15493
      FROM dbamv.eve_siasus
         , dbamv.tip_ate_apac
         , dbamv.fat_sia
         , dbamv.decendios_fat_sia
         , dbamv.procedimento_sus
         , dbamv.procedimento_detalhe_vigencia
         , dbamv.procedimento_sus_valor
         , dbamv.grupo_procedimentos
         , dbamv.sub_grupo_procedimentos
         , dbamv.organiza_grupo_procedimentos
         , dbamv.complexidade_procedimento
         , dbamv.unidade_regional
         , dbamv.apac
         , dbamv.config_ffas
         , dbamv.ori_ate
         , dbamv.atendime atendime
         , dbamv.ori_ate set_ori_ate
         , dbamv.remessa_bpa remessa_bpa --OP:1834
         , dbamv.gru_pro gru_pro         --OP 2116
     WHERE eve_siasus.cd_multi_empresa = 1
       -- OP 16358 InÃ­cio.
       and Nvl(remessa_bpa.sn_temporaria,'N') = 'N'
       -- OP 16358 Fim.
       and nvl(ori_ate.tp_origem,'X') <> 'I'
       and fat_sia.cd_multi_empresa = 1 --OP 17753 InÃ­cio/Fim.
       AND fat_sia.cd_multi_empresa = eve_siasus.cd_multi_empresa
       AND eve_siasus.cd_remessa = remessa_bpa.cd_remessa(+) --OP:1834
       --OP 22502 INICIO
       AND  (((procedimento_detalhe_vigencia.sn_apac_principal = 'S' or procedimento_detalhe_vigencia.sn_apac_secundario = 'S') AND apac.cd_multi_empresa = 1)
               OR (procedimento_detalhe_vigencia.sn_apac_principal = 'N' or procedimento_detalhe_vigencia.sn_apac_secundario = 'N'))
       --OP 22502 FIM
       AND eve_siasus.cd_convenio in (config_ffas.cd_convenio, Dbamv.Pkt_Config_Sisco.Retorna_Campo('cd_convenio')) -- PDA 320419
       and config_ffas.cd_multi_empresa = 1
       and eve_siasus.cd_atendimento = atendime.cd_atendimento(+)
       AND procedimento_sus_valor.cd_procedimento = eve_siasus.cd_procedimento
       AND procedimento_sus_valor.dt_vigencia =
            DECODE ((SELECT COUNT (*)
                       FROM dbamv.procedimento_sus_valor proc
                      WHERE proc.cd_procedimento = procedimento_sus_valor.cd_procedimento)
                  , 1, procedimento_sus_valor.dt_vigencia
                  , (SELECT max (proc.dt_vigencia) dt_vigencia
                        FROM dbamv.procedimento_sus_valor proc
                       WHERE proc.dt_vigencia <= nvl(fat_sia.dt_periodo_final, sysdate)
                         AND proc.cd_procedimento = procedimento_sus_valor.cd_procedimento)
                   )
       AND nvl(eve_siasus.nr_idade,0) >= decode(fat_sia.tipo_fatura, 'SISC', Decode(eve_siasus.cd_procedimento, '0203020081', 12, '0203010019',10), 0)--- 363943
       AND eve_siasus.cd_fat_sia = fat_sia.cd_fat_sia
       AND eve_siasus.cd_decendio = decendios_fat_sia.cd_decendio(+)
       AND eve_siasus.cd_fat_sia = decendios_fat_sia.cd_fat_sia(+)
       AND eve_siasus.cd_procedimento = procedimento_sus.cd_procedimento
       AND procedimento_sus.cd_procedimento = procedimento_detalhe_vigencia.cd_procedimento
       AND procedimento_sus.cd_procedimento = procedimento_sus_valor.cd_procedimento
       AND nvl(eve_siasus.qt_lancada,0) <> 0 -- #OP:38700 // Leone Oliveira
       AND procedimento_sus.cd_grupo_procedimento = grupo_procedimentos.cd_grupo_procedimento
       AND procedimento_sus.cd_grupo_procedimento = sub_grupo_procedimentos.cd_grupo_procedimento
       AND procedimento_sus.cd_sub_grupo_procedimento = sub_grupo_procedimentos.cd_sub_grupo_procedimento
       AND procedimento_sus.cd_grupo_procedimento = organiza_grupo_procedimentos.cd_grupo_procedimento
       AND procedimento_sus.cd_sub_grupo_procedimento = organiza_grupo_procedimentos.cd_sub_grupo_procedimento
       AND procedimento_sus.cd_organiza_grupo_procedimento = organiza_grupo_procedimentos.cd_organiza_grupo_procedimento
       AND procedimento_detalhe_vigencia.cd_tip_ate = tip_ate_apac.cd_tip_ate(+)
       AND procedimento_detalhe_vigencia.tp_complexidade_procedimento = complexidade_procedimento.tp_complexidade_procedimento
       AND unidade_regional.cd_unidade_regional(+) = eve_siasus.cd_unidade_regional
       AND eve_siasus.cd_apac = apac.cd_apac(+)
       and ori_ate.cd_ori_ate(+) = eve_siasus.cd_ori_ate
       and atendime.cd_ori_ate = set_ori_ate.cd_ori_ate(+)
       and procedimento_detalhe_vigencia.cd_gru_pro_amb = gru_pro.cd_gru_pro(+)
       and trunc(eve_siasus.dt_eve_siasus) between trunc(procedimento_detalhe_vigencia.dt_validade_inicial) and trunc(nvl(procedimento_detalhe_vigencia.dt_validade_final,sysdate)) --  OP 33164