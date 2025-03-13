-- query com exemplo de regra de validação com query
select case
  when trim('&<ds_nome_1>') is null  and
           '&<rb_com_quem_outro_1>' = 'true' then 'N'
  else 'S' end from dual

--validação com RB
Select case
when '&<RB_1_ANAMNESE>' = 'true' OR
'&<RB_1_EVOLUCAO>' = 'true'
then 'S' Else 'N' end from dual