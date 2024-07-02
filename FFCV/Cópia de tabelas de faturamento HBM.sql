INSERT INTO DBAMV.VAL_PRO
SELECT 35 --TABELA NOVA
      ,VAL_PRO.cd_pro_fat
      ,VAL_PRO.dt_vigencia
      ,VAL_PRO.vl_honorario
      ,VAL_PRO.vl_operacional
      ,VAL_PRO.vl_total
      ,VAL_PRO.cd_import
      ,VAL_PRO.vl_sh
      ,VAL_PRO.vl_sd
      ,VAL_PRO.qt_pontos
      ,VAL_PRO.qt_pontos_anest
      ,VAL_PRO.sn_ativo
      ,VAL_PRO.nm_usuario
      ,VAL_PRO.dt_ativacao
      ,VAL_PRO.cd_seq_integra
      ,VAL_PRO.dt_integra
  FROM DBAMV.VAL_PRO
  WHERE VAL_PRO.CD_TAB_FAT = 29 -- TABELA ANTIGA
    AND (VAL_PRO.CD_PRO_FAT, VAL_PRO.DT_VIGENCIA) IN (SELECT VAL_PRO.CD_PRO_FAT
                                                            ,Max(VAL_PRO.DT_VIGENCIA)
                                                        FROM DBAMV.VAL_PRO
                                                        WHERE CD_TAB_FAT = 29
                                                        GROUP BY VAL_PRO.CD_PRO_FAT) --CONDIÇÃO PARA PEGAR SOMENTE A ULTIMA VIGENCIA DE CADA PROCEDIMENTO
    AND (VAL_PRO.CD_PRO_FAT ,VAL_PRO.DT_VIGENCIA) NOT IN (SELECT VAL_PRO.CD_PRO_FAT
                                                                ,VAL_PRO.DT_VIGENCIA
                                                            FROM DBAMV.VAL_PRO
                                                            WHERE VAL_PRO.CD_TAB_FAT = 35) -- NÃO INSERIR VALORES QUE JÁ ESTÃO NA TABELA NOVA
    AND VAL_PRO.CD_PRO_FAT NOT IN (SELECT TAB_CONVENIO.CD_PRO_FAT
                                     FROM DBAMV.TAB_CONVENIO
                                     WHERE TAB_CONVENIO.DT_VIGENCIA = '01/04/2024'
                                       AND TAB_CONVENIO.CD_CONVENIO = 3) -- CONDIÇÃO PARA VER SE TEM EXCEÇÃO CADASTRADA
