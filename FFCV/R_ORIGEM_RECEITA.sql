SELECT reg_fat.cd_atendimento cd_atendimento                    
      ,nvl( itreg_fat.cd_setor_produziu, itreg_fat.cd_setor )  cd_setor_produziu            
      ,itreg_fat.cd_setor cd_setor                              
      ,NULL cd_grupo_procedimento                               
      ,NULL cd_sub_grupo_procedimento                           
      ,NULL cd_organiza_grupo_procedimento                      
      ,NULL cd_procedimento                                     
      ,item_res.cd_item_res                                     
      ,itreg_fat.cd_gru_fat                                     
      ,gru_pro.cd_gru_pro cd_gru_pro                            
      ,itreg_fat.cd_pro_fat cd_pro_fat                          
      ,reg_fat.cd_convenio                                      
      ,'S' sn_importado                                       
      ,'CH' tp_origem_faturamento                             
      ,NVL( item_res.tp_receita, gru_pro.tp_gru_pro ) tipo_receita        
      ,itreg_fat.dt_lancamento        
      ,NVL( atendime.cd_multi_empresa, 1) cd_multi_empresa        
      ,NVL( NVL(itlan_med.vl_liquido, itreg_fat.vl_total_conta), 0) vl_total_conta        
      ,NVL( itreg_fat.qt_lancamento, 0 )  qt_lancamento         
      ,'I' tp_mensagem        
      ,reg_fat.cd_reg_fat cd_reg_fat        
      ,itreg_fat.cd_lancamento cd_lancamento        
      ,pro_fat.sn_pacote sn_pacote        
      ,itreg_fat.sn_pertence_pacote sn_pertence_pacote     
  FROM dbamv.reg_fat          
      ,dbamv.itreg_fat         
      ,dbamv.pro_fat         
      ,dbamv.gru_pro         
      ,dbamv.gru_fat        
      ,dbamv.itlan_med  
      ,dbamv.remessa_fatura remessa  
      ,dbamv.fatura        
      ,dbamv.convenio        
      ,dbamv.atendime        
      ,dbamv.empresa_convenio        
      ,dbamv.item_res        
      ,dbamv.setor    
  WHERE empresa_convenio.cd_convenio = convenio.cd_convenio         
    AND empresa_convenio.cd_multi_empresa = 1      
    AND reg_fat.cd_reg_fat = itreg_fat.cd_reg_fat           
    AND reg_fat.cd_atendimento = atendime.cd_atendimento          
    AND itreg_fat.cd_pro_fat = pro_fat.cd_pro_fat           
    AND gru_fat.cd_gru_fat = gru_pro.cd_gru_fat           
    AND item_res.cd_item_res = nvl(pro_fat.cd_item_res, gru_fat.cd_item_res)          
    AND pro_fat.cd_gru_pro = gru_pro.cd_gru_pro           
    AND reg_fat.cd_convenio = convenio.cd_convenio          
    AND NVL( itreg_fat.sn_pertence_pacote, 'N' ) = 'N'           
    AND NVL( reg_fat.sn_diagno, 'N' ) = 'N'            
    AND atendime.cd_multi_empresa = 1       
    AND convenio.tp_convenio <> 'H'            
    AND itlan_med.cd_reg_fat(+) = itreg_fat.cd_reg_fat        
    AND itlan_med.cd_lancamento(+) = itreg_fat.cd_lancamento        
    AND NVL( NVL(itlan_med.tp_pagamento, itreg_fat.tp_pagamento), 'P') <> 'C'  
    AND reg_fat.cd_remessa = remessa.cd_remessa    
    AND remessa.cd_fatura = fatura.cd_fatura    
    AND remessa.sn_fechada = 'S'  
    AND remessa.dt_entrega_da_fatura  BETWEEN '01/10/2022' AND '31/10/2022'
    AND nvl( itreg_fat.cd_setor_produziu, itreg_fat.cd_setor ) = setor.cd_setor 
UNION 
SELECT reg_fat.cd_atendimento cd_atendimento                    
      ,nvl( itreg_fat.cd_setor_produziu, itreg_fat.cd_setor )  cd_setor_produziu            
      ,itreg_fat.cd_setor cd_setor                              
      ,NULL cd_grupo_procedimento                               
      ,NULL cd_sub_grupo_procedimento                           
      ,NULL cd_organiza_grupo_procedimento                      
      ,NULL cd_procedimento                                     
      ,item_res.cd_item_res                                     
      ,itreg_fat.cd_gru_fat                                     
      ,gru_pro.cd_gru_pro cd_gru_pro                            
      ,itreg_fat.cd_pro_fat cd_pro_fat                          
      ,reg_fat.cd_convenio                                      
      ,'S' sn_importado                                       
      ,'CH' tp_origem_faturamento                             
      ,NVL( item_res.tp_receita, gru_pro.tp_gru_pro ) tipo_receita        
      ,itreg_fat.dt_lancamento        
      ,NVL( atendime.cd_multi_empresa, 1) cd_multi_empresa        
      ,NVL( NVL(itlan_med.vl_liquido, itreg_fat.vl_total_conta), 0) vl_total_conta        
      ,NVL( itreg_fat.qt_lancamento, 0 )  qt_lancamento         
      ,'I' tp_mensagem        
      ,reg_fat.cd_reg_fat cd_reg_fat        
      ,itreg_fat.cd_lancamento cd_lancamento        
      ,pro_fat.sn_pacote sn_pacote        
      ,itreg_fat.sn_pertence_pacote sn_pertence_pacote     
  FROM dbamv.reg_fat          
      ,dbamv.itreg_fat         
      ,dbamv.pro_fat         
      ,dbamv.gru_pro         
      ,dbamv.gru_fat        
      ,dbamv.itlan_med  
      ,dbamv.remessa_fatura remessa  
      ,dbamv.fatura        
      ,dbamv.convenio        
      ,dbamv.atendime        
      ,dbamv.empresa_convenio        
      ,dbamv.item_res        
      ,dbamv.setor    
  WHERE empresa_convenio.cd_convenio = convenio.cd_convenio         
    AND empresa_convenio.cd_multi_empresa = 1      
    AND reg_fat.cd_reg_fat = itreg_fat.cd_reg_fat           
    AND reg_fat.cd_atendimento = atendime.cd_atendimento          
    AND itreg_fat.cd_pro_fat = pro_fat.cd_pro_fat           
    AND gru_fat.cd_gru_fat = gru_pro.cd_gru_fat           
    AND item_res.cd_item_res = nvl(pro_fat.cd_item_res, gru_fat.cd_item_res)          
    AND pro_fat.cd_gru_pro = gru_pro.cd_gru_pro           
    AND reg_fat.cd_convenio = convenio.cd_convenio          
    AND NVL( itreg_fat.sn_pertence_pacote, 'N' ) = 'N'           
    AND NVL( reg_fat.sn_diagno, 'N' ) = 'N'            
    AND atendime.cd_multi_empresa = 1       
    AND convenio.tp_convenio <> 'H'            
    AND itlan_med.cd_reg_fat(+) = itreg_fat.cd_reg_fat        
    AND itlan_med.cd_lancamento(+) = itreg_fat.cd_lancamento        
    AND NVL( NVL(itlan_med.tp_pagamento, itreg_fat.tp_pagamento), 'P') <> 'C'  
    AND reg_fat.cd_remessa = remessa.cd_remessa    
    AND remessa.cd_fatura = fatura.cd_fatura    
    AND remessa.sn_fechada = 'S'  
    AND remessa.dt_entrega_da_fatura  BETWEEN '01/10/2022' AND '31/10/2022'
    AND nvl( itreg_fat.cd_setor_produziu, itreg_fat.cd_setor ) = setor.cd_setor 







                                                      