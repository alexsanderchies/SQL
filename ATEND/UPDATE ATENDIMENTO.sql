--ALTERA FORMATO DA DATA
ALTER Session SET nls_date_format = 'DD/MM/YYYY HH24:MI'

--BUSCA DATA E HORA DO ATENDIMENTO
SELECT ATENDIME.CD_ATENDIMENTO
      ,ATENDIME.DT_ATENDIMENTO
      ,ATENDIME.HR_ATENDIMENTO
      ,ATENDIME.DT_ALTA_MEDICA
      ,ATENDIME.HR_ALTA_MEDICA 
      ,ATENDIME.DT_ALTA
      ,ATENDIME.HR_ALTA
  FROM DBAMV.ATENDIME 
  WHERE ATENDIME.CD_ATENDIMENTO = 696676

-- UPDATE NA DATA E HORA DA INTERNA??O
UPDATE ATENDIME
  SET DT_ATENDIMENTO = '15/06/2024 00:00'  -- Nova Data Atendimento
     ,HR_ATENDIMENTO = '15/06/2024 22:59'  -- Nova Data e Hora do Atendimento
  WHERE CD_ATENDIMENTO  = 696676 -- C?DIGO DO ATENDIMENTO

--
UPDATE ATENDIME
  SET dt_alta_medica = '27/05/2024 14:45' -- Nova Data ALTA MÉDICA
     ,hr_alta_medica = '27/05/2024 14:45' -- Nova Hora ALTA MÉDICA
     ,dt_alta = '27/05/2024 14:50'  -- Nova Data Atendimento
     ,hr_alta = '27/05/2024 14:50'  -- Nova Hora Atendimento
  WHERE CD_ATENDIMENTO  = 696676 -- CÓDIGO DO ATENDIMENTO

--BUSCA MOVIMENTA??O DE LEITO
select  cd_mov_int, dt_mov_int, hr_mov_int,dt_lib_mov, hr_lib_mov
from dbamv.mov_int where cd_atendimento = 696676
ORDER BY cd_mov_int

--ALTERA MOVIMENTA??O DE LEITO
update dbamv.mov_int
SET dt_lib_mov = ('17/05/2024 11:00')
   ,hr_lib_mov = ('17/05/2024 11:00')
where cd_mov_int = 103021  -- C?DIGO DA MOVIMENTA??O DE LEITO
