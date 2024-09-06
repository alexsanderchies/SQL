SELECT Decode(pw_alergia_pac.tp_alergia,'S','Substancia','A','Alimento','Outros') tp_alergia
      ,substancia.ds_substancia
      ,Decode(pw_alergia_pac.tp_severidade,'G','Grave','L','Leve','M','Moderada') tp_severidade
      ,PW_ALERGIA_PAC.DS_OBSERVACAO
  FROM DBAMV.PW_ALERGIA_PAC 
  LEFT JOIN DBAMV.SUBSTANCIA
    ON PW_ALERGIA_PAC.CD_SUBSTANCIA = SUBSTANCIA.CD_SUBSTANCIA
  JOIN DBAMV.PW_DOC_ALERGIA_PAC
    ON PW_ALERGIA_PAC.CD_PROBLEMA = PW_DOC_ALERGIA_PAC.CD_PROBLEMA
  WHERE PW_ALERGIA_PAC.CD_USUARIO_INATIVACAO IS NULL
    AND PW_ALERGIA_PAC.TP_ALERGIA != 'D'
    AND PW_DOC_ALERGIA_PAC.cd_paciente = 4


-- 
select 'Alergia: ' ||rtrim(xmlagg(xmlelement(e, ds_substancia, ', ').extract('//text()')),', ') alergia
from pw_problema pp,
     pw_alergia_pac pap,
     dbamv.substancia s
where pp.cd_problema = pap.cd_problema
  and pap.cd_substancia = s.cd_substancia
  and pp.sn_ativo = 'S'
  and pp.cd_paciente = 1418
