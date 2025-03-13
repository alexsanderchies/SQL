CREATE OR REPLACE TRIGGER dbamvfor.trg_moe_multi_emp_gera_cod BEFORE
    INSERT ON dbamv.moeda_multi_empresa
    REFERENCING
            NEW AS new
            OLD AS old
    FOR EACH ROW
DECLARE
    parametro                NUMBER(1);
    codigo_estabelecimento   NUMBER;
BEGIN
  -- Parametro Liga e Desliga unificac?o entre Soul, Regulador e SIGS
    BEGIN
        SELECT
            valor
        INTO parametro
        FROM
            dbamvfor.mv_parametro
        WHERE
            chave = 'unificaSoulRegSigs';

    EXCEPTION
        WHEN OTHERS THEN
            dbamvfor.prc_insert_log_integracao(0, 'MV_PARAMETRO', 'SOUL', 'REGULADOR', 'SELECT',
                                               sqlerrm, 'N?o existe o parametro unificaSoulRegSigs');
    END;

    IF ( parametro = 1 ) THEN
    -- o codigo da USUARIO_MULTI_EMPRESA passara a usar a sequence publica SQ_TB_ESTABELECIMENTO do estabelecimento
        BEGIN
            SELECT
                dbamvfor.sq_tb_estabelecimento.currval
            INTO codigo_estabelecimento
            FROM
                dual;

        EXCEPTION
            WHEN OTHERS THEN
                dbamvfor.prc_insert_log_integracao(:new.cd_multi_empresa,                 --cd_referencia
                 'SQ_TB_ESTABELECIMENTO',               --tp_referencia
                 'SOUL',                                --ds_origem
                 'REGULADOR',                           --ds_destino
                 'SELECT',                              --ds_acao
                                                   substr(sqlerrm, 1, 150),                 --ds_erro_oracle
                                                    'MOEDA_MULTI_EMPRESA: Erro ao procurar o proximo valor da sequence SQ_TB_ESTABELECIMENTO na trigger .');
        END;

        :new.cd_multi_empresa := codigo_estabelecimento;
    END IF;

END;


/

