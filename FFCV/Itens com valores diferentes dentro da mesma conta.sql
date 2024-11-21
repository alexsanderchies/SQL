SELECT * 
  FROM 
      (SELECT itreg_amb.cd_reg_amb
             ,itreg_amb.cd_pro_fat
             ,itreg_amb.vl_unitario
        FROM itreg_amb
        JOIN (SELECT Count(*)
                    ,cd_reg_amb
                    ,cd_pro_fat
                    ,Trunc(hr_lancamento)
                    ,vl_percentual_multipla
                FROM dbamv.itreg_amb 
                WHERE Trunc(hr_lancamento) > '15/11/2024'

              GROUP BY cd_reg_amb
                      ,cd_pro_fat
                      ,Trunc(hr_lancamento)
                      ,vl_percentual_multipla 
              HAVING COUNT (*) > 1 
            )a
          ON itreg_amb.cd_reg_amb = a.cd_reg_amb                                    
        AND itreg_amb.cd_pro_fat = a.cd_pro_fat
        AND itreg_amb.vl_percentual_multipla = a.vl_percentual_multipla 
        --WHERE itreg_amb.cd_pro_fat NOT IN ('01990155')
      ) y
  , 
      (SELECT itreg_amb.cd_reg_amb
             ,itreg_amb.cd_pro_fat
             ,itreg_amb.vl_unitario 
        FROM itreg_amb
        JOIN (SELECT Count(*)
                    ,cd_reg_amb
                    ,cd_pro_fat
                    ,Trunc(hr_lancamento)
                    ,vl_percentual_multipla
                FROM dbamv.itreg_amb 
                WHERE Trunc(hr_lancamento) > '15/11/2024'

              GROUP BY cd_reg_amb
                      ,cd_pro_fat
                      ,Trunc(hr_lancamento)
                      ,vl_percentual_multipla 
              HAVING COUNT (*) > 1 
            )a
          ON itreg_amb.cd_reg_amb = a.cd_reg_amb                                    
        AND itreg_amb.cd_pro_fat = a.cd_pro_fat
        AND itreg_amb.vl_percentual_multipla = a.vl_percentual_multipla 
        --WHERE itreg_amb.cd_pro_fat NOT IN ('01990155')
      ) e
  WHERE y.cd_reg_amb = e.cd_reg_amb
   AND y.cd_pro_fat = e.cd_pro_fat                           
   AND y.vl_unitario != e.vl_unitario
