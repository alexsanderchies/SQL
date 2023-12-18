--ALTERA FORMATO DA DATA
ALTER Session SET nls_date_format = 'DD/MM/YYYY HH24:MI'


--BUSCA DATA E HORA DO ATENDIMENTO
SELECT CD_ATENDIMENTO, DT_ATENDIMENTO, HR_ATENDIMENTO FROM DBAMV.ATENDIME WHERE CD_ATENDIMENTO = 585116

-- UPDATE NA DATA E HORA DA INTERNAÇÃO
UPDATE ATENDIME
  SET DT_ATENDIMENTO = '05/06/2022 00:00'  -- Nova Data Atendimento
     ,HR_ATENDIMENTO = '05/06/2022 22:59'  -- Nova Data e Hora do Atendimento
  WHERE CD_ATENDIMENTO  = 585116 -- CÓDIGO DO ATENDIMENTO



--BUSCA MOVIMENTAÇÃO DE LEITO
select  cd_mov_int, dt_mov_int, hr_mov_int,dt_lib_mov, hr_lib_mov
from dbamv.mov_int where cd_atendimento = 585116
ORDER BY cd_mov_int


--ALTERA MOVIMENTAÇÃO DE LEITO
update dbamv.mov_int
SET dt_mov_int = ('05/06/2022 00:00')
   ,hr_mov_int = ('05/06/2022 22:59')
where cd_mov_int = 89034  -- CÓDIGO DA MOVIMENTAÇÃO DE LEITO
