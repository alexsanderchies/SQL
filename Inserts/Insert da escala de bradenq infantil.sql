--INSERE AVALIAÇÃO
INSERT INTO dbamv.pagu_formula (cd_formula, ds_formula, tp_formula, cd_acao, nr_periocidade_avaliacao, nr_inicio_avaliacao, sn_avaliacao_alta, sn_ativar_regras, cd_unidade_formula)
  VALUES(62, 'BRADEN Q ( 1 MES ATE 5 ANOS)', 'E', NULL, NULL, NULL, 'N', 'N', NULL);

--INSERE PERGUNTAS 
INSERT INTO DBAMV.pagu_pergunta (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(990, 'BRADENQ', 'MOBILIDADE: CAPACIDADE DE MUDAR E CONTROLAR A POSIC?O DO CORPO', 'P', NULL, 'S', 'N', 'N', NULL, 'Q', NULL);
INSERT INTO DBAMV.pagu_pergunta (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(991, 'BRADENQ', 'ATIVIDADE: GRAU DE ATIVIDADE FISICA', 'P', NULL, 'S', 'N', 'N', NULL, 'Q', NULL);
INSERT INTO DBAMV.pagu_pergunta (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(992, 'BRADENQ', 'PERCEPC?O SENSORIAL: CAPACIDADE DE RESPONDER DE MANEIRA APROPRIADA AO DESCONFORTO RELACIONADO A PRESS?O', 'P', NULL, 'S', 'N', 'N', NULL, 'Q', NULL);
INSERT INTO DBAMV.pagu_pergunta (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(993, 'BRADENQ', 'UMIDADE: GRAU DE EXPOSIC?O DA PELE A UMIDADE', 'P', NULL, 'S', 'N', 'N', NULL, 'Q', NULL);
INSERT INTO DBAMV.pagu_pergunta (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(994, 'BRADENQ', 'FRICC?O E CISALHAMENTO FRICC?O : A PELE SE MOVE CONTRA AS ESTRUTURAS DO SUPORTE', 'P', NULL, 'S', 'N', 'N', NULL, 'Q', NULL);
INSERT INTO DBAMV.pagu_pergunta (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(995, 'BRADENQ', 'NUTRIC?O PADR?O HABITUAL DE CONSUMO ALIMENTAR', 'P', NULL, 'S', 'N', 'N', NULL, 'Q', NULL);
INSERT INTO DBAMV.pagu_pergunta (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(996, 'BRADENQ', 'PERFUS?O TECIDUAL E OXIGENAC?O', 'P', NULL, 'S', 'N', 'N', NULL, 'Q', NULL);
--INSERE RESPOSTAS PARA AS PERGUNTAS

INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(990, 1, 'Completamente Imovel: N?o faz mudancas nem mesmo pequena na posic?o do corpo.', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(990, 2, 'Muito Limitado: Faz pequenas mudancas ocasionais na posic?o do corpo ou extremidades.', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(990, 3, 'Levemente Limitado: Faz mudancas frequentes emboras pequenas na posic?o do corpo ou extremidades.', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(990, 8, 'Nenhuma Limitac?o: Faz mudancas importantes e frequentes na posic?o do corpo. ', 4, 4, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(990, 5, 'Completamente Imovel: N?o faz mudancas nem mesmo pequena na posic?o do corpo.', 1, 1, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(990, 6, 'Muito Limitado: Faz pequenas mudancas ocasionais na posic?o do corpo ou extremidades.', 2, 2, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(990, 7, 'Levemente Limitado: Faz mudancas frequentes emboras pequenas na posic?o do corpo ou extremidades.', 3, 3, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(990, 4, 'Nenhuma Limitac?o: Faz mudancas importantes e frequentes na posic?o do corpo. ', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(991, 1, 'Acamado: Permanece no leito o tempo todo', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(991, 2, 'Restrito a cadeira: A capacidade de deambular esta gravemente limitada ou inexistente', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(991, 3, 'Deambulac?o ocasional: Deambula ocasionalmente durante o dia, porem por distancias bem curtas, com ou sem ajuda.', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(991, 8, 'Criancas jovens demais para deambular ou deambulam frequentemente.', 4, 4, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(991, 5, 'Acamado: Permanece no leito o tempo todo', 1, 1, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(991, 6, 'Restrito a cadeira: A capacidade de deambular esta gravemente limitada ou inexistente', 2, 2, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(991, 7, 'Deambulac?o ocasional: Deambula ocasionalmente durante o dia, porem por distancias bem curtas, com ou sem ajuda.', 3, 3, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(991, 4, 'Criancas jovens demais para deambular ou deambulam frequentemente.', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(992, 1, 'Completamente Limitada: N?o responde ao estimulo doloroso.', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(992, 2, 'Muito limitada: Responde apenas aos estimulos dolorosos.', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(992, 3, 'Levemente limitada: Responde aos comandos verbais, mas sempre consegue comunicar desconforto.', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(992, 8, 'Nenhuma alterac?o: Responde aos comandos Verbais', 4, 4, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(992, 5, 'Completamente Limitada: N?o responde ao estimulo doloroso.', 1, 1, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(992, 6, 'Muito limitada: Responde apenas aos estimulos dolorosos.', 2, 2, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(992, 7, 'Levemente limitada: Responde aos comandos verbais, mas sempre consegue comunicar desconforto.', 3, 3, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(992, 4, 'Nenhuma alterac?o: Responde aos comandos Verbais', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(993, 1, 'Constantemente umida: A pele fica constantemente por suor, urina, etc', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(993, 2, 'Frequentemente Umida: A pele esta frequentemente, mas nem sempre, umida.', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(993, 3, 'Ocasionalmente Umida: A pele esta ocasionalmente umida.', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(993, 8, 'Raramente umida: A pele geralmente esta seca, as trocas de rotina', 4, 4, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(993, 5, 'Constantemente umida: A pele fica constantemente por suor, urina, etc', 1, 1, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(993, 6, 'Frequentemente Umida: A pele esta frequentemente, mas nem sempre, umida.', 2, 2, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(993, 7, 'Ocasionalmente Umida: A pele esta ocasionalmente umida.', 3, 3, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(993, 4, 'Raramente umida: A pele geralmente esta seca, as trocas de rotina', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(994, 1, 'Problema Importante: A espasticidade, a contratura, o prourido ou a agitac?o levam a crianca debater-se no leito e ha fricc?o constante.', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(994, 2, 'Problema Necessita de ajuda moderada a maxima para se mover.', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(994, 3, 'Problema Potencial: Movimenta-se com dificuldade ou necessita de minima assistencia.', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(994, 8, 'Nenhum problema aparente: Capaz de levantar-se completamente durante uma mudanca de posic?o', 4, 4, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(994, 5, 'Problema Importante: A espasticidade, a contratura, o prourido ou a agitac?o levam a crianca debater-se no leito e ha fricc?o constante.', 1, 1, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(994, 6, 'Problema Necessita de ajuda moderada a maxima para se mover.', 2, 2, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(994, 7, 'Problema Potencial: Movimenta-se com dificuldade ou necessita de minima assistencia.', 3, 3, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(994, 4, 'Nenhum problema aparente: Capaz de levantar-se completamente durante uma mudanca de posic?o', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(995, 1, 'Muito pobre: Em jejum e/ao mantido com ingesta hidrica ou Hidratac?o IV por mais de 5 dias ou albumina <2,5mg/dl ou nunca come um refeic?o completa', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(995, 2, 'Inadequada: Dieta liquida por sonda ou NPP que fornece calorias e minerais insuficientes para a idade ou albumina <3mg/dl ou raramente come uma refeic?o completa', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(995, 3, 'Adequada: Dieta por sonda ou NPP que fornece calorias e minerais insuficientes para idade <3mg/dl ou raramente come uma refeic?o completa', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(995, 8, 'Excelente: Dieta geral que fornece calorias suficientes para idade.', 4, 4, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(995, 5, 'Muito pobre: Em jejum e/ao mantido com ingesta hidrica ou Hidratac?o IV por mais de 5 dias ou albumina <2,5mg/dl ou nunca come um refeic?o completa', 1, 1, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(995, 6, 'Inadequada: Dieta liquida por sonda ou NPP que fornece calorias e minerais insuficientes para a idade ou albumina <3mg/dl ou raramente come uma refeic?o completa', 2, 2, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(995, 7, 'Adequada: Dieta por sonda ou NPP que fornece calorias e minerais insuficientes para idade <3mg/dl ou raramente come uma refeic?o completa', 3, 3, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(995, 4, 'Excelente: Dieta geral que fornece calorias suficientes para idade.', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(996, 1, 'Extremamente comprometida: Hipotenso ou o paciente n?o tolera mudancas de posic?o', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(996, 2, 'Comprometida: Normotenso.', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(996, 3, 'Adequada: Normotenso', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(996, 8, 'Excelente: Normotenso', 4, 4, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(996, 5, 'Extremamente comprometida: Hipotenso ou o paciente n?o tolera mudancas de posic?o', 1, 1, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(996, 6, 'Comprometida: Normotenso.', 2, 2, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(996, 7, 'Adequada: Normotenso', 3, 3, NULL, NULL, 62, NULL, NULL);
INSERT INTO pagu_resposta (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(996, 4, 'Excelente: Normotenso', 4, 4, NULL, NULL, NULL, NULL, NULL);
--INSERE FORMULA
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 1, 1, 'P', 990, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 2, 2, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 3, 3, 'P', 991, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 4, 4, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 5, 5, 'P', 992, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 6, 6, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 7, 7, 'P', 993, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 8, 8, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 9, 9, 'P', 994, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 10, 10, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 11, 11, 'P', 995, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 12, 12, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.pagu_itformula (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(62, 13, 13, 'P', 996, NULL, NULL, NULL);
-- INSERE INTERPRETAÇÃO
INSERT INTO pagu_formula_interpretacao(cd_pagu_formula_interpretacao, cd_formula, vl_inicial, vl_final, ds_interpretacao, ds_intervencao, ds_sigla_interpretacao, ds_sigla_intervencao)
  VALUES(seq_pagu_formula_interpretacao.NEXTVAL, 62, 0, 21, 'ALTO RISCO', NULL, 'BRADENQ', NULL);
INSERT INTO pagu_formula_interpretacao(cd_pagu_formula_interpretacao, cd_formula, vl_inicial, vl_final, ds_interpretacao, ds_intervencao, ds_sigla_interpretacao, ds_sigla_intervencao)
  VALUES(seq_pagu_formula_interpretacao.NEXTVAL, 62, 22, 100000, 'BAIXO RISCO', NULL, 'BRADENQ', NULL);


