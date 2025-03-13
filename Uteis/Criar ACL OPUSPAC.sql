DECLARE
-----------------------------------------------------------
-------------------
-- Este parametro precisa ser ajustados obrigatoriamente
--
IP_SERVIDOR VARCHAR2(30) := '10.16.17.92';
-----------------------------------------------------------
-------------------
-----------------------------------------------------------
-------------------
-- O ajuste de porta inicial e porta final e opcional
PORTA_INI NUMBER := NULL;
PORTA_FIM NUMBER := NULL;
-----------------------------------------------------------
-------------------
-----------------------------------------------------------
-------------------
NM_ACL VARCHAR2(30) := 'acl_opuspac.xml'; -- mudar nome da acl
BEGIN
DBMS_NETWORK_ACL_ADMIN.CREATE_ACL(
ACL => NM_ACL,
DESCRIPTION => 'SOULMV Unitarizacao OpusPac',
PRINCIPAL => 'DBASGU',
IS_GRANT => true,
privilege => 'connect' );
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
ACL => NM_ACL,
PRINCIPAL => 'DBASGU',
IS_GRANT => true,
privilege => 'resolve' );
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
ACL => NM_ACL,
PRINCIPAL => 'DBAMV',
IS_GRANT => true,
privilege => 'resolve' );
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
ACL => NM_ACL,
PRINCIPAL => 'DBAMV',
IS_GRANT => true,
privilege => 'connect' );
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
ACL => NM_ACL,
PRINCIPAL => 'MVINTEGRA',
IS_GRANT => true,
privilege => 'resolve' );
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
ACL => NM_ACL,
PRINCIPAL => 'MVINTEGRA',
IS_GRANT => true,
privilege => 'connect' );
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
ACL => NM_ACL,
PRINCIPAL => 'MV2000',
IS_GRANT => true,
privilege => 'resolve' );
DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
ACL => NM_ACL,
PRINCIPAL => 'MV2000',
IS_GRANT => true,
privilege => 'connect' );
DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(
ACL => NM_ACL,
host => IP_SERVIDOR,
lower_port => PORTA_INI,
upper_port => PORTA_FIM);
COMMIT;
END;
/