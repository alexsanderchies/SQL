SELECT 'ALTER SEQUENCE'
      ,OWNER||'.'||object_name
       ,'INCREMENT BY 1000;'
FROM all_objects  WHERE object_type = 'SEQUENCE' AND OWNER = 'DBAMV'


