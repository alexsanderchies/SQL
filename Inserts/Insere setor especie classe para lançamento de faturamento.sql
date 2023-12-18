/*ESTE SCRIPT INSERE A INFORMAÇÃO DE ESPÉCIE, CLASSE, SETORES PRODUTIVOS PARA LANÇAMENTO EM

SEUS RESPECTIVOS GRUPOS DE FATURAMENTO.



ATENÇÃO: NA LINHA "4" INFORMAR O CÓDIGO DO GRUPO DE FATURAMENTO( MATERIAIS, MEDICAMENTOS OU MAT/MED) PARA O QUAL

DEVERÁ SER LANÇADO OS ITENS DA ESPÉCIE INFORMADOS NA LINHA "10')
*/



insert into configu_importacao_gru_fat

select c.cd_especie,

       c.cd_classe,

      11, -- Código do grupo de faturamento para o qual deve ser lançado os itens das espécies abaixo.

       s.cd_setor,

       null,

       seq_conf_import.NEXTVAL

  from classe c,

       setor  s

 where c.cd_especie in (1)-- Coloque aqui o código das espécies que devem ser lançadas para o Grupo de Faturamento informado acima.

   and s.tp_setor   = 'P'



-- Os campos devem estar na ordem describe da tabela ou informados na clausula insert.