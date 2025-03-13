SELECT cd_atendimento,
       hr_atendimento,
       nm_usuario,
       sn_retorno,
       dt_usuario_retorno,
       nm_usuario_retorno
FROM atendime 
WHERE  dt_atendimento BETWEEN '01/04/2022' AND '30/06/2022'
  AND tp_atendimento = 'U'
  AND dt_usuario_retorno IS NOT NULL 
  AND nm_usuario_retorno IS NOT NULL 
ORDER BY 1
