select '65PROD15665832'
      ,Substr('65PROD15665832',1,InStr('65PROD15665832','PROD')-1 )   -- pegar antes de determinada palavra
      ,Substr('65PROD15665832',InStr('65PROD15665832','PROD')+4,999 ) -- pegar após determinada palavra
  from dual