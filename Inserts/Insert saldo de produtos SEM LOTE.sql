DECLARE
   CURSOR w (p_estoque IN NUMBER,
             p_produto in NUMBER) IS
      SELECT 1
        FROM dbamv.est_Pro
       WHERE cd_estoque = p_estoque
         AND cd_produto = p_produto
         AND CD_ESTOQUE = 17;
   v_existe NUMBER(1);
BEGIN
     FOR insere IN (SELECT * FROM produto
                     WHERE cd_especie IN (1,2,15) /*(Coloca a espécie que quer inserir)*/
                       AND (sn_controle_validade = 'N' AND SN_LOTE = 'N')
                       AND SN_KIT = 'N'
                       AND CD_PRODUTO NOT IN (SELECT CD_PRODUTO FROM EST_PRO WHERE CD_ESTOQUE = 17)
                     )

    LOOP
        OPEN  w(1, insere.cd_Produto); /*(1 Código do estoque que quer inserir)*/
        FETCH w INTO v_existe;
          IF ( w%NOTFOUND ) then
              insert INTO dbamv.est_pro (cd_estoque, cd_produto, qt_estoque_atual)
              VALUES (17, insere.cd_produto, 5042);  /*(1 Código do estoque que quer inserir)*/
          END IF;
        CLOSE w;
    END LOOP;

END;
-- Insert do lote

DECLARE
   CURSOR w (p_estoque IN NUMBER,
             p_produto in NUMBER) IS
      SELECT 1
        FROM dbamv.LOT_PRO
       WHERE cd_estoque = p_estoque
         AND cd_produto = p_produto
         AND cd_estoque = 17;
   v_existe NUMBER(1);

BEGIN
     FOR insere_lote IN (SELECT * FROM produto
                     WHERE cd_especie IN (1,2,15) /*(Coloca a espécie que quer inserir)*/
                       AND (sn_controle_validade = 'N' AND  SN_LOTE = 'N') --ALTERAR PARA QUANDO O PRODUTO NAO CONTROLA LOTE NEM VALIDADE
                       AND SN_KIT = 'N'
                       AND CD_PRODUTO IN (SELECT CD_PRODUTO FROM EST_PRO WHERE CD_ESTOQUE = 17 AND QT_ESTOQUE_ATUAL = 5042)
                       AND CD_PRODUTO NOT IN (SELECT CD_PRODUTO FROM LOT_PRO WHERE CD_ESTOQUE = 17)
                     )
 LOOP
        OPEN  w(1, insere_lote.cd_Produto); /*(1 Código do estoque que quer inserir)*/
        FETCH w INTO v_existe;
          IF ( w%NOTFOUND ) then
              insert INTO dbamv.LOT_PRO (cd_lot_pro, cd_estoque, cd_produto, dt_validade, qt_estoque_atual, cd_lote)
              VALUES (seq_lot_pro.NEXTVAL,
                     17   --estoque
                     ,insere_lote.cd_produto
                     ,NULL  -- validade ** se produto nao controla validade tem que estar como NULL
                     ,5042
                     ,NULL);  /*(1 Código do estoque que quer inserir)*/  -- lote ** se produto nao controla lote tem que estar como NULL
          END IF;
        CLOSE w;
    END LOOP;
END;



















