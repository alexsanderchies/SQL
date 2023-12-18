insert into configu_importacao_gru_fat 

select c.cd_especie, 

       c.cd_classe, 

       10, -- Código do grupo de faturamento para o qual deve ser lançado os itens das espécies abaixo. 

       s.cd_setor, 

       NULL, 

       seq_conf_import.NEXTVAL 

  from classe c, 

       setor  s 

 where c.cd_especie in (2)-- Coloque aqui o código das espécies que devem ser lançadas para o Grupo de Faturamento informado acima. 

   and s.tp_setor   = 'P' 

   AND (s.cd_setor, cd_especie, cd_classe) NOT IN (SELECT CD_SETOR, CD_ESPECIE, CD_CLASSE FROM DBAMV.CONFIGU_IMPORTACAO_GRU_FAT )

-- Os campos devem estar na ordem describe da tabela ou informados na clausula insert. 
