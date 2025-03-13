DECLARE
  --##############################################################################
  --##############################################################################
  -- cursor cGrants
  --##############################################################################
  --##############################################################################
  CURSOR cGrants
  IS
    SELECT comando
    FROM
      (
      --##############################################################################
      -- grants para tabelas (REVISADO)
      --##############################################################################
      SELECT 'GRANT SELECT,UPDATE,DELETE,INSERT ON '
        ||d.owner
        ||'.'
        ||d.object_name
        ||' TO '
        ||(
        CASE
          WHEN d.owner = 'DBAMV'
          THEN 'DBAPS,DBASGU,MVINTEGRA,MV2000'
          WHEN d.owner = 'DBAPS'
          THEN 'DBAMV,DBASGU,MVINTEGRA,MV2000'
          WHEN d.owner = 'DBASGU'
          THEN 'DBAMV,DBAPS,MVINTEGRA,MV2000'
          WHEN d.owner = 'MVINTEGRA'
          THEN 'DBAMV,DBAPS,DBASGU,MV2000'
        END ) COMANDO
      FROM DBA_OBJECTS d
      WHERE D.OWNER     IN( 'DBAMV', 'DBASGU', 'DBAPS', 'MVINTEGRA' )
      AND d.object_type IN( 'TABLE' )
      AND d.object_name NOT LIKE '%BIN$%'
      AND ((SELECT COUNT(*)
        FROM DBA_TAB_PRIVS TP
        WHERE TP.TABLE_NAME = D.OBJECT_NAME
        AND TP.OWNER        = D.OWNER
        AND tp.grantee     IN( 'DBAMV', 'DBASGU', 'DBAPS', 'MVINTEGRA','MV2000' )
        AND TP.PRIVILEGE   <> 'EXECUTE' ) < 16)
      UNION ALL
      --##############################################################################
      -- grants para views (REVISADO)
      --##############################################################################
      SELECT 'GRANT SELECT,UPDATE,DELETE,INSERT ON '
        ||d.owner
        ||'.'
        ||d.object_name
        ||' TO '
        ||(
        CASE
          WHEN d.owner = 'DBAMV'
          THEN 'DBAPS,DBASGU,MVINTEGRA,MV2000'
          WHEN d.owner = 'DBAPS'
          THEN 'DBAMV,DBASGU,MVINTEGRA,MV2000'
          WHEN d.owner = 'DBASGU'
          THEN 'DBAMV,DBAPS,MVINTEGRA,MV2000'
          WHEN d.owner = 'MVINTEGRA'
          THEN 'DBAMV,DBAPS,DBASGU,MV2000'
        END ) COMANDO
      FROM DBA_OBJECTS d
      WHERE D.OWNER     IN( 'DBAMV', 'DBASGU', 'DBAPS', 'MVINTEGRA' )
      AND d.object_type IN( 'VIEW' )
      AND d.object_name NOT LIKE '%BIN$%'
      AND ((SELECT COUNT(*)
        FROM DBA_TAB_PRIVS TP
        WHERE TP.TABLE_NAME = D.OBJECT_NAME
        AND TP.OWNER        = D.OWNER
        AND tp.grantee     IN( 'DBAMV', 'DBASGU', 'DBAPS', 'MVINTEGRA' ,'MV2000')
        AND TP.PRIVILEGE   <> 'EXECUTE' ) < 16)
      UNION ALL
      --##############################################################################
      -- GRANTS PARA SEQUENCES (REVISADO)
      --##############################################################################
      SELECT 'GRANT SELECT ON '
        ||o.owner
        ||'.'
        ||o.object_name
        ||' TO '
        ||(
        CASE
          WHEN o.owner = 'DBAMV'
          THEN 'DBAPS,DBASGU,MVINTEGRA,MV2000'
          WHEN o.owner = 'DBAPS'
          THEN 'DBAMV,DBASGU,MVINTEGRA,MV2000'
          WHEN o.owner = 'DBASGU'
          THEN 'DBAMV,DBAPS,MVINTEGRA,MV2000'
          WHEN o.owner = 'MVINTEGRA'
          THEN 'DBAMV,DBAPS,DBASGU,MV2000'
        END ) COMANDO
      FROM dba_objects o
      WHERE o.object_type = 'SEQUENCE'
      AND o.owner        IN( 'DBAMV', 'DBAPS', 'DBASGU', 'MVINTEGRA' )
      AND o.object_name NOT LIKE '%BIN$%'
      AND ( (SELECT COUNT(*)
        FROM dba_tab_privs tp
        WHERE tp.table_name = o.object_name
        AND tp.privilege    = 'SELECT'
        AND TP.OWNER        = O.OWNER
        AND TP.GRANTEE     IN( 'DBAMV', 'DBASGU', 'DBAPS', 'MVINTEGRA', 'MV2000' ) ) < 4)
      UNION ALL
      --##############################################################################
      -- GRANT EXECUTE EM FUNCTIONS, PROCEDURES, PACKAGES (REVISADO)
      --##############################################################################
      SELECT 'GRANT EXECUTE ON '
        ||o.owner
        ||'.'
        ||o.object_name
        ||' TO '
        ||(
        CASE
          WHEN o.owner = 'DBAMV'
          THEN 'DBAPS,DBASGU,MVINTEGRA,MV2000'
          WHEN o.owner = 'DBAPS'
          THEN 'DBAMV,DBASGU,MVINTEGRA,MV2000'
          WHEN o.owner = 'DBASGU'
          THEN 'DBAMV,DBAPS,MVINTEGRA,MV2000'
          WHEN o.owner = 'MVINTEGRA'
          THEN 'DBAMV,DBAPS,DBASGU,MV2000'
        END ) COMANDO
      FROM DBA_OBJECTS O
      WHERE o.object_type IN( 'FUNCTION', 'PROCEDURE', 'PACKAGE' )
      AND o.owner         IN( 'DBAMV', 'DBAPS', 'DBASGU', 'MVINTEGRA' )
      AND o.object_name NOT LIKE '%BIN$%'
      AND ( (SELECT COUNT(*)
        FROM dba_tab_privs tp
        WHERE tp.table_name = o.object_name
        AND tp.privilege    = 'EXECUTE'
        AND TP.OWNER        = O.OWNER
        AND TP.GRANTEE     IN( 'DBAMV', 'DBASGU', 'DBAPS', 'MVINTEGRA', 'MV2000' ) ) < 4)
      );
    --##############################################################################
    --##############################################################################
    -- cursor cPubSyn
    --##############################################################################
    --##############################################################################
    CURSOR cPubSyn
    IS
      SELECT comando
      FROM
        (
        --##############################################################################
        -- CRIA sinonimos publicos para tabelas e views (REVISADO)
        --##############################################################################
        SELECT 'CREATE OR REPLACE PUBLIC SYNONYM '
          ||o.object_name
          ||' FOR '
          || o.owner
          || '.'
          ||o.object_name comando
        FROM dba_objects o
        WHERE O.OBJECT_TYPE IN( 'TABLE', 'VIEW' )
        AND o.owner         IN( 'DBAMV' , 'DBASGU', 'DBAPS', 'MVINTEGRA' )
        AND O.OBJECT_NAME NOT LIKE '%BIN$%'
        AND o.object_name       <> 'PLAN_TABLE'
        AND (O.OBJECT_NAME) NOT IN
          (SELECT S.TABLE_NAME
          FROM dba_synonyms s
          WHERE s.owner     = 'PUBLIC'
          AND S.TABLE_OWNER = 'DBAMV'
          )
        )
        order by comando desc;
      --##############################################################################
      --##############################################################################
      -- cursor cPubSynObj
      --##############################################################################
      --##############################################################################
      CURSOR cPubSynObj
      IS
        --##############################################################################
        -- CRIA sinonimos publicos para functions, procedures, packages, sequences (nao alterado)
        --##############################################################################
        SELECT 'CREATE OR REPLACE PUBLIC SYNONYM '
          || o.object_name
          ||' FOR '
          || o.owner
          ||'.'
          ||o.object_name comando
        FROM DBA_OBJECTS O
        WHERE O.OBJECT_TYPE IN( 'FUNCTION', 'PROCEDURE', 'PACKAGE', 'SEQUENCE' )
        AND o.owner         IN( 'DBAMV', 'DBASGU', 'DBAPS', 'MVINTEGRA' )
        AND O.OBJECT_NAME NOT LIKE '%BIN$%'
        AND NOT EXISTS
          (SELECT 1
          FROM dba_synonyms s
          WHERE s.owner     = 'PUBLIC'
          AND s.table_name  = o.object_name
          AND S.TABLE_OWNER = O.OWNER
          )
          ORDER BY o.owner DESC;
      --##############################################################################
      --##############################################################################
    BEGIN
      --##############################################################################
      -- executa os comandos gerados no cursor de grants
      --##############################################################################
      FOR vcGrants IN cGrants
      LOOP
        BEGIN
          EXECUTE IMMEDIATE( vcGrants.comando );
        EXCEPTION
        WHEN OTHERS THEN
          Dbms_Output.put_line( vcGrants.comando );
        END;
      END LOOP;
      --##############################################################################
      -- executa os comandos gerados no cursor de sinonimos publicos para tabelas
      --##############################################################################
      FOR vcPubSyn IN cPubSyn
      LOOP
        BEGIN
          EXECUTE IMMEDIATE( vcPubSyn.comando );
        EXCEPTION
        WHEN OTHERS THEN
          Dbms_Output.put_line( vcPubSyn.comando );
        END;
      END LOOP;
      --##############################################################################
      -- executa os comandos gerados no cursor de sinonimos publicos de outros objetos
      --##############################################################################
      FOR vcPubSynObj IN cPubSynObj
      LOOP
        BEGIN
          EXECUTE IMMEDIATE( vcPubSynObj.comando );
        EXCEPTION
        WHEN OTHERS THEN
          Dbms_Output.put_line( vcPubSynObj.comando );
        END;
      END LOOP;
    END;
/


CREATE PUBLIC synonym arg_list for dbamv.arg_list;
CREATE PUBLIC SYNONYM SEQ_T_ITLOT_ENT FOR dbamv.SEQ_ITLOT_ENT;

