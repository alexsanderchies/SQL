SELECT GoLive, Tipo, Realizado

from(
select
'MacroProcesso - Atendimento' GoLive,
'Atendimentos Ambulatorial' tipo,
count (a.cd_atendimento) Realizado
 from dbamv.atendime a
where a.tp_atendimento = 'A'
--and a.nm_usuario not in 'DBAMV'
and  a.dt_atendimento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


 union ALL

select
'MacroProcesso - Atendimento' GoLive,
'Atendimentos Urgência'  tipo,
count (a.cd_atendimento) Realizado

 from dbamv.atendime a
where a.tp_atendimento = 'U'
--and a.nm_usuario not in 'DBAMV'
and  a.dt_atendimento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


      union all

      select
'MacroProcesso - Atendimento' GoLive,
'Atendimentos Externo' tipo,
count (a.cd_atendimento) Realizado

 from dbamv.atendime a
where a.tp_atendimento = 'E'
--and a.nm_usuario not in 'DBAMV'
and  a.dt_atendimento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


 union all

select
'MacroProcesso - Atendimento' GoLive,
  'Atendimentos Internação GO LIVE ' tipo,
count (a.cd_atendimento) Realizado

from dbamv.atendime a
where a.tp_atendimento = 'I'
--and a.nm_usuario not in 'DBAMV'
and  a.dt_atendimento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

UNION ALL

SELECT
'MacroProcesso - Atendimento' GoLive,
  'Solicitacao para Central de leitos' tipo,
Count(lei.cd_solic_transferencia_leito)

 FROM solic_transferencia_leito lei
 WHERE lei.dt_solic_transf between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


UNION ALL

select
'MacroProcesso - Atendimento' GoLive,
'Censo de Internação' tipo,
count (a.cd_atendimento) Realizado

from dbamv.atendime a
where a.tp_atendimento = 'I'
--and a.nm_usuario not in 'DBAMV'
AND a.dt_alta IS  null
and  a.dt_atendimento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


      union all

      select
'MacroProcesso - Atendimento' GoLive,
'Alta Hospitalar' tipo,
count (a.cd_atendimento) Realizado

 from dbamv.atendime a
where a.tp_atendimento = 'I'
and a.dt_alta is not null
--and a.nm_usuario not in 'DBAMV'
and  a.dt_alta between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


  UNION ALL


      select
'MacroProcesso - Atendimento' GoLive,
'Alta Médica' tipo,
count (a.cd_atendimento) Realizado

 from dbamv.atendime a
where a.tp_atendimento = 'I'
and a.dt_alta_medica is not null
--and a.nm_usuario not in 'DBAMV'
and  a.dt_alta between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



union all

select
'MacroProcesso - Atendimento' GoLive,
'Senhas retiradas TOTEM' tipo,
count (TRI.CD_SENHA) Realizado

 from  DBAMV.SACR_SENHA_TRIAGEM TRI
where  tri.dh_senha between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



                           UNION ALL

    SELECT
'MacroProcesso - Apoio Limpeza' GoLive,
'Limpeza de Leito' tipo,
count (cd_SOLIC_LIMPEZA) Realizado

 from  DBAMV.SOLIC_LIMPEZA

 where   DT_realizado between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')
                          AND tp_solicitacao = 'A'


 union all


 select
'MacroProcesso - Agendamento' GoLive,
'Agendamento de consulta' tipo,
count (i.cd_it_agenda_central) Realizado

 from dbamv.it_agenda_central i, dbamv.escala_central ec, dbamv.agenda_central ac, dbamv.atendime a
where i.cd_agenda_central = ac.cd_agenda_central
and   ac.cd_escala_central = ec.cd_escala_central
and i.cd_atendimento = a.cd_atendimento (+)
and i.nm_paciente is not null
--AND I.CD_USUARIO NOT IN 'DBAMV'
and ec.tp_escala = 'A'
and  i.hr_agenda between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


     union all

      select
'MacroProcesso - Agendamento' GoLive,
'Agendamento de imagem' tipo,
count (i.cd_it_agenda_central) Realizado

 from dbamv.it_agenda_central i, dbamv.escala_central ec, dbamv.agenda_central ac, dbamv.atendime a
where i.cd_agenda_central = ac.cd_agenda_central
and   ac.cd_escala_central = ec.cd_escala_central
and  i.cd_atendimento = a.cd_atendimento (+)
and i.nm_paciente is not null
--AND I.CD_USUARIO NOT IN 'DBAMV'
and ec.tp_escala = 'I'
and  i.hr_agenda between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')




     union all

      select
'MacroProcesso - Agendamento' GoLive,
'Agendamento de laboratorio' tipo,
count (i.cd_it_agenda_central) Realizado

from dbamv.it_agenda_central i, dbamv.escala_central ec, dbamv.agenda_central ac, dbamv.atendime a
where i.cd_agenda_central = ac.cd_agenda_central
and   ac.cd_escala_central = ec.cd_escala_central
and i.cd_atendimento = a.cd_atendimento (+)
and i.nm_paciente is not null
--AND I.CD_USUARIO NOT IN 'DBAMV'
and ec.tp_escala = 'L'
and  i.hr_agenda between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



      union all

select
'MacroProcesso - Centro cirurgico' GoLive,
'Cirurgias de Urgência' tipo,
count (b.cd_aviso_cirurgia) Realizado

from dbamv.aviso_cirurgia b,atendime a
where a.cd_atendimento = b.cd_atendimento
AND b.tp_situacao = 'A'
--AND A.NM_USUARIO NOT IN 'DBAMV'
and b.dt_aviso_cirurgia between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

UNION ALL

SELECT
'MacroProcesso - Centro cirurgico' GoLive,
'Cirurgias Canceladas' tipo,
count (b.cd_aviso_cirurgia) Realizado

from dbamv.aviso_cirurgia b,atendime a
where a.cd_atendimento = b.cd_atendimento
--AND A.NM_USUARIO NOT IN 'DBAMV'
AND b.tp_situacao = 'C'
and b.dt_aviso_cirurgia between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

                          UNION ALL

 SELECT
'MacroProcesso - Centro cirurgico' GoLive,
'Cirurgias Agendadas' tipo,
count (b.cd_aviso_cirurgia) Realizado

from dbamv.aviso_cirurgia b,atendime a
where a.cd_atendimento = b.cd_atendimento
--AND A.NM_USUARIO NOT IN 'DBAMV'
AND b.tp_situacao = 'G'
and b.dt_aviso_cirurgia between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



      union all

  select
'MacroProcesso - Centro cirurgico' GoLive,
'Cirurgias Realizadas' tipo,
count (b.cd_aviso_cirurgia) Realizado

from dbamv.aviso_cirurgia b,atendime a
where a.cd_atendimento = b.cd_atendimento
and b.tp_situacao = 'R'
--AND B.CD_USUARIO NOT IN 'DBAMV'
and b.dt_aviso_cirurgia between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


      union all

        select
'MacroProcesso - Centro cirurgico' GoLive,
'Descrição de cirurgia' tipo,
count (b.cd_aviso_cirurgia) Realizado

 from dbamv.aviso_cirurgia b,atendime a
where a.cd_atendimento = b.cd_atendimento
--and b.sn_libera_aviso = 'S'
--AND B.CD_USUARIO NOT IN 'DBAMV'
and b.dt_aviso_cirurgia between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


      union all

        select
'MacroProcesso - Centro cirurgico' GoLive,
'Ficha obstetrica' tipo,
count (a.cd_atendimento) Realizado

from dbamv.atendime a
where a.tp_atendimento = 'I'
and  a.cd_atendimento_pai is not null
--AND A.NM_USUARIO NOT IN 'DBAMV'
and a.dt_atendimento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

UNION ALL

SELECT
'MacroProcesso - Documentos Eletrônicos' GoLive,
'Documentos Clinicos' tipo,
 Count (pdc.Cd_Documento_clinico)
  FROM Dbamv.Pw_Documento_Clinico   Pdc
     , Dbamv.Pw_Editor_Clinico      Pec
     , Dbamv.Atendime               Ate
     , Dbamv.Editor_Documento       Doc
     , Dbamv.Paciente               Pac
 WHERE Pec.Cd_Documento_Clinico    = Pdc.Cd_Documento_Clinico
   AND Pdc.Cd_Atendimento          = Ate.Cd_Atendimento
   AND Pec.Cd_Documento            = Doc.Cd_Documento
   AND Ate.Cd_Paciente             = Pac.Cd_Paciente
   and pdc.dh_fechamento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')
                         -- AND pdc.CD_USUARIO NOT IN 'DBAMV'

 union all

select
'MacroProcesso - Médico' GoLive,
'Prescrições Médicas' tipo,
count (c.cd_pre_med) Realizado

from dbamv.pre_med c , dbamv.atendime a
where a.cd_atendimento = c.cd_atendimento
and  c.tp_pre_med = 'M'
--AND C.NM_USUARIO NOT IN 'DBAMV'
and c.dt_pre_med between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

           union all
select
'MacroProcesso - Médico' GoLive,
'Evolução Médica' tipo,
count (a.cd_pre_med) Realizado

FROM pre_med A
WHERE ds_evolucao IS NOT NULL
AND tp_pre_med = 'M'
--AND A.NM_USUARIO NOT IN 'DBAMV'
and a.dh_criacao between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



           union all
select
'MacroProcesso - Médico' GoLive,
'Avaliação' tipo,
count (pa.cd_avaliacao) Realizado

from dbamv.pagu_avaliacao pa, atendime a
where a.cd_atendimento = pa.cd_atendimento
--AND PA.NM_USUARIO NOT IN 'DBAMV'
and pa.dh_avaliacao between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


 union all

select
'MacroProcesso - Enfermagem' GoLive,
'Prescrições Enfermagem' tipo,
count (c.cd_pre_med) Realizado

from dbamv.pre_med c , atendime a
where a.cd_atendimento = c.cd_atendimento
and  c.tp_pre_med = 'E'
--AND C.NM_USUARIO NOT IN 'DBAMV'
and c.dt_pre_med between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

           union all
select
'MacroProcesso - Enfermagem' GoLive,
'Evolução Enfermagem' tipo,
count (a.cd_pre_med) Realizado

FROM pre_med A
WHERE ds_evolucao IS NOT NULL
AND tp_pre_med <> 'M'
--AND A.NM_USUARIO NOT IN 'DBAMV'
and a.dh_criacao between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

  union all

  select
'MacroProcesso - Enfermagem' GoLive,
'Aferições' tipo,
count (sv.cd_coleta_sinal_vital) Realizado

from dbamv.coleta_sinal_vital sv , atendime a
where a.cd_atendimento = sv.cd_atendimento
--AND SV.NM_USUARIO NOT IN 'DBAMV'
and sv.data_coleta between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

                          UNION ALL
                                  select
'MacroProcesso - Enfermagem' GoLive,
'Evolução de Técnico' tipo,
count (tec.cd_evo_enf) Realizado

from dbamv.evo_enf tec
WHERE tec.dt_evo_enf between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



      union all
        SELECT
'MacroProcesso - Enfermagem' GoLive,
'Balanço Hídrico' tipo,
count (bh.cd_atendimento) Realizado

from dbamv.pw_balanco_hidrico bh , atendime a
WHERE a.cd_atendimento = bh.cd_atendimento
--AND BH.CD_USUARIO NOT IN 'DBAMV'
AND bh.dt_referencia between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                         and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



union all

select
'MacroProcesso - Enfermagem' GoLive,
'Classificação de risco' tipo,
count (SAC.CD_CLASSIFICACAO_RISCO) Realizado

 from  DBAMV.SACR_CLASSIFICACAO_RISCO SAC
  where sac.dh_classificacao_risco between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


union all

select
'MacroProcesso - Enfermagem' GoLive,
'Checagem de enfermagem' tipo,
count (chec.cd_itpre_med) Realizado

FROM DBAMV.hritpre_cons chec
  where chec.dh_checagem between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')
/*
UNION ALL

select
'MacroProcesso - Enfermagem' GoLive,
'Aprazamento de enfermagem' tipo,
count (chec.cd_itpre_med) Realizado

FROM DBAMV.hritpre_cons chec
  where chec.dh_checagem between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

*/

 union all

select
'MacroProcesso - Imagem' GoLive,
'Exames de Imagem' tipo,
count (d.cd_ped_rx) Realizado

 from dbamv.ped_rx d, atendime a
Where a.cd_atendimento = d.cd_atendimento
AND D.NM_USUARIO NOT IN 'DBAMV'
and d.dt_pedido between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



       union all

  select
'MacroProcesso - Imagem' GoLive,
'Laudo de imagem' tipo,
count (lr.cd_laudo) Realizado

from dbamv.ped_rx d, atendime a, laudo_rx lr
Where a.cd_atendimento = d.cd_atendimento
--AND LR.CD_USUARIO_ASSINADO NOT IN 'DBAMV'
and d.cd_ped_rx = lr.cd_ped_rx
and lr.dt_laudo between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')




 union all

select
'MacroProcesso - Laboratório' GoLive,
'Exames de Laboratorio' tipo,
count (d.cd_ped_lab) Realizado

from dbamv.ped_lab d, atendime a
Where a.cd_atendimento = d.cd_atendimento
--AND D.NM_USUARIO NOT IN 'DBAMV'
and d.dt_pedido between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



             union all
select
'MacroProcesso - Laboratório' GoLive,
'Laudo de laboratorio' tipo,
count (i.cd_ped_lab) Realizado

from dbamv.ped_lab d, atendime a, dbamv.itped_lab i
Where a.cd_atendimento = d.cd_atendimento
and d.cd_ped_lab = i.cd_ped_lab
--AND I.CD_USUARIO_ASSINADO NOT IN 'DBAMV'
and i.dt_laudo is not null
and i.dt_laudo between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

 union all

select
'MacroProcesso - Suprimentos' GoLive,
'Solicitações Atendidas de pacientes' tipo,
count (t.cd_solsai_pro) Realizado

 from dbamv.solsai_pro t, dbamv.atendime a
where t.cd_atendimento = a.cd_atendimento
and   t.tp_solsai_pro = 'P'
and   t.tp_situacao = 'S'
--AND T.CD_USUARIO NOT IN 'DBAMV'
and t.dt_solsai_pro between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



 union all

select
'MacroProcesso - Suprimentos' GoLive,
'Solicitações Atendidas para setor' tipo,
count (t.cd_solsai_pro) Realizado

 from dbamv.solsai_pro t, dbamv.atendime a
where t.cd_atendimento = a.cd_atendimento (+)
and   t.tp_situacao = 'S'
and   t.tp_solsai_pro = 'S'
--AND T.CD_USUARIO NOT IN 'DBAMV'
and t.dt_solsai_pro between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


 union all

select
'MacroProcesso - Suprimentos' GoLive,
'Solicitações Atendidas para estoque' tipo,
count (t.cd_solsai_pro) Realizado

 from dbamv.solsai_pro t, dbamv.atendime a
where t.cd_atendimento = a.cd_atendimento (+)
and   t.tp_situacao = 'S'
and   t.tp_solsai_pro = 'E'
--AND T.CD_USUARIO NOT IN 'DBAMV'
and t.dt_solsai_pro between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



 union all

select
'MacroProcesso - Suprimentos' GoLive,
'Devolução de paciente' tipo,
count (t.cd_solsai_pro) Realizado

 from dbamv.solsai_pro t, dbamv.atendime a
where t.cd_atendimento = a.cd_atendimento
and   t.tp_situacao = 'S'
and   t.tp_solsai_pro = 'C'
--AND T.CD_USUARIO NOT IN 'DBAMV'
and t.dt_solsai_pro between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


 union all

select
'MacroProcesso - Suprimentos' GoLive,
'Solicitação Devolução de paciente' tipo,
count (t.cd_solsai_pro) Realizado

 from dbamv.solsai_pro t, dbamv.atendime a
where t.cd_atendimento = a.cd_atendimento
and   t.tp_situacao = 'P'
and   t.tp_solsai_pro = 'C'
AND T.CD_USUARIO NOT IN 'DBAMV'
and t.dt_solsai_pro between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



 union all

select
'MacroProcesso - Suprimentos' GoLive,
'Entrada de produto'  tipo,
count (p.cd_ent_pro) Realizado

from dbamv.ent_pro p, dbamv.atendime a
where p.cd_atendimento = a.cd_atendimento (+)
--AND P.CD_USUARIO NOT IN 'DBAMV'
and p.dt_entrada between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



 union all

select
'MacroProcesso - Suprimentos' GoLive,
'Gasto de sala de cirurgia' tipo,
count (k.cd_mvto_estoque) Realizado

 from dbamv.mvto_estoque k, dbamv.atendime a
where k.cd_atendimento = a.cd_atendimento (+)
and   k.cd_aviso_cirurgia is not null
--AND K.CD_USUARIO NOT IN 'DBAMV'
and k.dt_mvto_estoque between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



 union all

select
'MacroProcesso - Suprimentos' GoLive,
'Entrada de serviço' tipo,
count (s.cd_ent_serv) Realizado

 from dbamv.ent_serv s
 where s.dt_entrada between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')
                          AND S.CD_USUARIO NOT IN 'DBAMV'


      union all

      select
'MacroProcesso - Suprimentos' GoLive,
'Entrada de consignado' tipo,
count (p.cd_ent_pro) Realizado

 from dbamv.ent_pro p, dbamv.atendime a
where p.cd_atendimento = a.cd_atendimento (+)
and tp_documento_entrada = 'C'
                      --AND P.CD_USUARIO NOT IN 'DBAMV'
and p.dt_entrada between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


                          UNION ALL

 SELECT
     'MacroProcesso - Compras' GoLive,
     'Ordem de Compras' tipo,
     Count(cd_ord_com)  realizado
    FROM DBAMV.ORD_COM
          WHERE dt_ord_com between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                               and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

                               UNION ALL

      SELECT
     'MacroProcesso - Compras' GoLive,
     'Solicitacao de Compras' tipo,
     Count(cd_sol_com) realizado
    FROM DBAMV.sol_com
          WHERE dt_sol_com between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                               and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:mi:ss')


union all

      select
'MacroProcesso - Faturamento convênio' GoLive,
'Contas fechadas internados'  tipo,
count (distinct rf.cd_reg_fat) Realizado

 from dbamv.REG_FAT RF, dbamv.atendime a
where a.cd_atendimento = rf.cd_atendimento
and   rf.cd_convenio <> 1
and rf.dt_fechamento is not null
--AND RF.NM_USUARIO NOT IN 'DBAMV'
and   rf.sn_fechada = 'S'
and rf.dt_fechamento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


       union all

 select
'MacroProcesso - Faturamento convênio' GoLive,
'Contas fechadas ambulatorial' tipo,
count (distinct reg.cd_reg_amb) Realizado

 from dbamv.REG_amb ra, itreg_amb reg, dbamv.atendime a
where ra.cd_reg_amb  = reg.cd_reg_amb
and   reg.cd_atendimento = a.cd_atendimento
and reg.dt_fechamento is not null
and   ra.cd_convenio <> 2
--AND REG.CD_USUARIO NOT IN 'DBAMV'
and   reg.sn_fechada = 'S'
and reg.dt_fechamento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


union all

select
'MacroProcesso - Faturamento convênio' GoLive,
'Guias autorizadas' tipo,
count (G.CD_GUIA) Realizado

 from  DBAMV.GUIA G
 where g.dt_autorizacao is not null
 and g.tp_guia <> 'C'
 and g.tp_situacao = 'A'
 and g.dt_autorizacao between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

 UNION ALL

 select
'MacroProcesso - Faturamento convênio' GoLive,
'Remessas' tipo,
count (re.cd_remessa) Realizado

 from  DBAMV.remessa_fatura re
where re.cd_remessa not in (select cd_remessa from dbamv.remessa_fatura where ds_remessa like 'AIH%')
and re.cd_remessa not in (select cd_remessa from dbamv.remessa_fatura where ds_remessa like 'APAC%')
and re.cd_remessa not in (select cd_remessa from dbamv.remessa_fatura where ds_remessa like 'BPA%')
and re.dt_fechamento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



union all

     select
'MacroProcesso - Faturamento SUS' GoLive,
'Contas fechadas internados' tipo,
count (distinct rf.cd_reg_fat) Realizado

from dbamv.REG_FAT RF, dbamv.atendime a
where a.cd_atendimento = rf.cd_atendimento
and rf.dt_fechamento is not null
and   rf.cd_convenio = 1
and   rf.sn_fechada = 'S'
and rf.dt_fechamento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


union all

select
'MacroProcesso - Faturamento SUS' GoLive,
'Remessas AIH' tipo,
count (re.cd_remessa) Realizado

 from  DBAMV.remessa_fatura re
 where   ds_remessa like 'AIH%'
 and re.dt_fechamento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



union all

 select
'MacroProcesso - Faturamento SUS' GoLive,
'Contas fechadas ambulatorial' tipo,
count (distinct ra.cd_reg_amb) Realizado

from dbamv.REG_amb ra, itreg_amb reg, dbamv.atendime a
where ra.cd_reg_amb  = reg.cd_reg_amb
and   reg.cd_atendimento = a.cd_atendimento (+)
and reg.dt_fechamento is not null
and   ra.cd_convenio = 2
and   reg.sn_fechada = 'S'
and reg.dt_fechamento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


union all

 select
'MacroProcesso - Faturamento SUS' GoLive,
'Remessas APAC' tipo,
count (re.cd_remessa) Realizado

 from  DBAMV.remessa_apac re
 where
 --ds_remessa like 'BPA%'
 --AND
  re.dt_competencia_apresentacao between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')



 union all

 select
'MacroProcesso - Faturamento SUS' GoLive,
'Remessas BPA' tipo,
count (re.cd_remessa) Realizado

 from  DBAMV.remessa_bpa re
 where  re.dt_fechamento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


 UNION ALL

  select
'MacroProcesso - Faturamento' tipo,
'Movimentação de Documentos' GoLive,
count (a.cd_protocolo_doc) Realizado

from dbamv.protocolo_doc a
where a.dt_envio between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')




UNION ALL

  SELECT
     'MacroProcesso - Financeiro' GoLive,
     'Contas a pagar' tipo,
      Count(cd_con_pag) Realizado

      FROM con_pag
     WHERE dt_lancamento between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

UNION ALL

  SELECT
     'MacroProcesso - Financeiro' GoLive,
     'Contas a receber' tipo,
      Count(cd_con_rec) Realizado

      FROM con_rec
     WHERE dt_emissao between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

                          UNION ALL


           SELECT
     'MacroProcesso - Financeiro' GoLive,
     'Movimentação do CAIXA' tipo,
      Count(cd_MOV_CAIXA) Realizado

      FROM MOV_CAIXA
     WHERE dt_MOVIMENTACAO between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

                          UNION ALL


                 SELECT
     'MacroProcesso - Financeiro' GoLive,
     'Movimentação de Contas Correntes' tipo,
      Count(cd_MOV_concor) Realizado

      FROM MOV_concor
     WHERE dt_MOVIMENTACAO between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')

UNION ALL

               SELECT
     'MacroProcesso - Contabilidade' GoLive,
     'Lançamentos Contabeis' tipo,
      Count(cd_lcto_contabil) Realizado

      FROM lcto_contabil
     WHERE dt_integra between to_date('07.09.2023 00:00:00', 'dd/mm/yyyy HH24:MI:SS')
                          and to_date('07.09.2023 23:59:00', 'dd/mm/yyyy HH24:MI:SS')


  ) GOlive         WHERE realizado >0



