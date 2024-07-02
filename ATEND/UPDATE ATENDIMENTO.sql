--ALTERA FORMATO DA DATA
ALTER Session SET nls_date_format = 'DD/MM/YYYY HH24:MI'


--BUSCA DATA E HORA DO ATENDIMENTO
SELECT CD_ATENDIMENTO, DT_ATENDIMENTO, HR_ATENDIMENTO, dt_alta, hr_alta,dt_alta_medica
     ,hr_alta_medica FROM DBAMV.ATENDIME WHERE CD_ATENDIMENTO = 692611

-- UPDATE NA DATA E HORA DA INTERNAÇÃO
UPDATE ATENDIME
  SET DT_ATENDIMENTO = '05/06/2022 00:00'  -- Nova Data Atendimento
     ,HR_ATENDIMENTO = '05/06/2022 22:59'  -- Nova Data e Hora do Atendimento
  WHERE CD_ATENDIMENTO  = 692611 -- CÓDIGO DO ATENDIMENTO

--
UPDATE ATENDIME
  SET dt_alta = '15/05/2024 00:00'  -- Nova Data Atendimento
     ,hr_alta = '15/05/2024 10:10'  -- Nova Data e Hora do Atendimento
     ,dt_alta_medica = '15/05/2024 00:00'
     ,hr_alta_medica = '15/05/2024 10:05'
  WHERE CD_ATENDIMENTO  = 692611 -- CÓDIGO DO ATENDIMENTO



--BUSCA MOVIMENTAÇÃO DE LEITO
select  cd_mov_int, dt_mov_int, hr_mov_int,dt_lib_mov, hr_lib_mov
from dbamv.mov_int where cd_atendimento = 692611
ORDER BY cd_mov_int


--ALTERA MOVIMENTAÇÃO DE LEITO
update dbamv.mov_int
SET dt_lib_mov = ('15/05/2024 00:00')
   ,hr_lib_mov = ('15/05/2024 10:10')
where cd_mov_int = 102382  -- CÓDIGO DA MOVIMENTAÇÃO DE LEITO

