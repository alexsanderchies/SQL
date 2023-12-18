SELECT cd_produto
      ,ds_produto
      ,cd_pro_fat
      ,e.cd_especie 
      ,e.ds_especie
      ,c.cd_classe
      ,c.ds_classe
      ,sc.cd_sub_cla
      ,sc.ds_sub_cla 
FROM produto p
JOIN especie e ON e.cd_especie = p.cd_especie 
JOIN classe c ON p.cd_classe = c.cd_classe AND e.cd_especie = c.cd_especie
JOIN sub_clas sc ON p.cd_sub_cla = sc.cd_sub_cla AND sc.cd_classe = c.cd_classe AND sc.cd_especie = p.cd_especie
WHERE p.cd_especie = 1
  AND p.sn_movimentacao = 'S'
  AND cd_pro_fat NOT IN (SELECT cd_pro_fat FROM val_pro WHERE cd_tab_fat = 515 )
