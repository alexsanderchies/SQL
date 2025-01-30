PROMPT CREATE OR REPLACE FUNCTION clob_to_blob
CREATE OR REPLACE FUNCTION clob_to_blob(
  value            IN CLOB,
  charset_id       IN INTEGER DEFAULT DBMS_LOB.DEFAULT_CSID,
  error_on_warning IN NUMBER  DEFAULT 0
) RETURN BLOB
IS
  result       BLOB;
  dest_offset  INTEGER := 1;
  src_offset   INTEGER := 1;
  lang_context INTEGER := DBMS_LOB.DEFAULT_LANG_CTX;
  warning      INTEGER;
  warning_msg  VARCHAR2(50);
BEGIN
  DBMS_LOB.CreateTemporary(
    lob_loc => result,
    cache   => TRUE
  );

  DBMS_LOB.CONVERTTOBLOB(
    dest_lob     => result,
    src_clob     => value,
    amount       => LENGTH( value ),
    dest_offset  => dest_offset,
    src_offset   => src_offset,
    blob_csid    => charset_id,
    lang_context => lang_context,
    warning      => warning
  );

  IF warning != DBMS_LOB.NO_WARNING THEN
    IF warning = DBMS_LOB.WARN_INCONVERTIBLE_CHAR THEN
      warning_msg := 'Warning: Inconvertible character.';
    ELSE
      warning_msg := 'Warning: (' || warning || ') during CLOB conversion.';
    END IF;

    IF error_on_warning = 0 THEN
      DBMS_OUTPUT.PUT_LINE( warning_msg );
    ELSE
      RAISE_APPLICATION_ERROR(
        -20567, -- random value between -20000 and -20999
        warning_msg
      );
    END IF;
  END IF;

  RETURN result;
END clob_to_blob;
/

GRANT EXECUTE ON clob_to_blob TO dbacp;
GRANT EXECUTE ON clob_to_blob TO dbadw;
GRANT EXECUTE ON clob_to_blob TO dbaportal;
GRANT EXECUTE ON clob_to_blob TO dbaps;
GRANT EXECUTE ON clob_to_blob TO dbasgu;
GRANT EXECUTE ON clob_to_blob TO editor;
GRANT EXECUTE ON clob_to_blob TO mv2000;
GRANT EXECUTE ON clob_to_blob TO mvbike WITH GRANT OPTION;
GRANT EXECUTE ON clob_to_blob TO mvcpoe;
GRANT EXECUTE ON clob_to_blob TO mvintegra;
GRANT EXECUTE ON clob_to_blob TO remweb;
