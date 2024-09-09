SELECT  ROUND ( SQRT ( ( fnc_pagu_super_corporea_peso(496) * 
                       (SELECT CASE
                                  WHEN fnc_pagu_super_corporea_altura(496) < 3 THEN fnc_pagu_super_corporea_altura(496) * 100
                                  ELSE  fnc_pagu_super_corporea_altura(496)
                                END altura 
                            FROM dual)  
                       ) / 3600 ),  2 )
FROM dual 


