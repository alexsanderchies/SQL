INSERT INTO  dbamv.procedimento_cbo_vigencia  (cd_procedimento, cd_cbo, dt_validade_inicial, dt_validade_final)
      VALUES('0407030255', '2231F9', To_Date('01.01.2021 00:00:00', 'dd.mm.yyyy hh24:mi:ss'), NULL)
      /
INSERT INTO  dbamv.procedimento_cbo_vigencia  (cd_procedimento, cd_cbo, dt_validade_inicial, dt_validade_final)
VALUES('0407030255', '225220', To_Date('01.01.2021 00:00:00', 'dd.mm.yyyy hh24:mi:ss'), NULL)
      /
    INSERT INTO  dbamv.procedimento_cbo_vigencia  (cd_procedimento, cd_cbo, dt_validade_inicial, dt_validade_final)
      VALUES('0407030255', '225310', To_Date('01.01.2021 00:00:00', 'dd.mm.yyyy hh24:mi:ss'), NULL)
      /
      INSERT INTO dbamv.procedimento_sus_cbo (cd_cbos, cd_procedimento, sn_ativo)
         VALUES('2231F9', '0407030255', 'S')
      /
      INSERT INTO dbamv.procedimento_sus_cbo (cd_cbos, cd_procedimento, sn_ativo)
         VALUES('225220', '0409010596', 'S')
      /
      INSERT INTO dbamv.procedimento_sus_cbo (cd_cbos, cd_procedimento, sn_ativo)
         VALUES('225310', '0409010596', 'S')
      /