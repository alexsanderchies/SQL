ALTER TABLE dbamv.log_vinc_prod_danfe
ADD (nr_ide_nfe VARCHAR2(100) NOT NULL , qt_entrada   NUMBER(16,4)  NULL);

COMMENT ON COLUMN log_vinc_prod_danfe.nr_ide_nfe IS 'Chave de Acesso da NFE.';
COMMENT ON COLUMN log_vinc_prod_danfe.qt_entrada IS 'QUANTIDADE DE ENTRADA DO PRODUTO/NCM';

PROMPT ALTER TABLE log_vinc_prod_danfe ADD CONSTRAINT cnt_temp_it_log_prod_danf_1_uk UNIQUE
ALTER TABLE log_vinc_prod_danfe
  ADD CONSTRAINT cnt_temp_it_log_prod_danf_1_uk UNIQUE (
    cd_linha_ncm,
    cd_ncm,
    cd_produto,
    nr_ide_nfe
  )
  USING INDEX
    STORAGE (
      NEXT       1024 K
    )
    LOGGING
/
GRANT DELETE,INSERT,REFERENCES,SELECT,UPDATE ON log_vinc_prod_danfe TO dbaps;
GRANT DELETE,INSERT,REFERENCES,SELECT,UPDATE ON log_vinc_prod_danfe TO dbasgu;
GRANT DELETE,INSERT,SELECT,UPDATE ON log_vinc_prod_danfe TO mv2000;
GRANT DELETE,INSERT,REFERENCES,SELECT,UPDATE ON log_vinc_prod_danfe TO mvintegra;