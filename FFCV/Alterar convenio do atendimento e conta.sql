SELECT DISTINCT  atendime.cd_atendimento, reg_amb.cd_reg_amb  
  FROM dbamv.itreg_amb
  JOIN reg_amb
    ON reg_amb.cd_reg_amb = itreg_amb.cd_reg_amb
  JOIN atendime
    ON itreg_amb.cd_atendimento = atendime.cd_atendimento
  JOIN paciente
    ON paciente.cd_paciente = atendime.cd_paciente
  WHERE reg_amb.cd_convenio = 3
    AND paciente.cd_profissao = 999 
    AND atendime.DT_ATENDIMENTO BETWEEN '27/02/2024' AND '31/03/2024' 
    AND itreg_amb.sn_fechada = 'N'
    AND atendime.cd_ori_ate = 14

UPDATE atendime SET cd_convenio = 51 , cd_con_pla = 1 WHERE cd_atendimento IN ( 679224,679071,679358)  AND cd_convenio = 3
UPDATE reg_amb SET cd_convenio = 51 WHERE cd_reg_amb in (808092,807956,808257) AND cd_convenio = 3
UPDATE itreg_amb SET cd_convenio = 51, cd_con_pla = 1 WHERE cd_reg_amb  in (808092,807956,808257) AND cd_convenio = 3