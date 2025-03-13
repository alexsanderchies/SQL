-- 1 INSERT DAS PERGUNTAS
INSERT INTO DBAMV.PAGU_PERGUNTA (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(684, '684', 'PERCEPÇÃO SENSORIAL', 'P', NULL, 'S', 'S', 'S', NULL, 'Q', NULL);
INSERT INTO DBAMV.PAGU_PERGUNTA (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(685, '685', 'UMIDADE', 'P', NULL, 'S', 'S', 'S', NULL, 'Q', NULL);
INSERT INTO DBAMV.PAGU_PERGUNTA (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(686, '686', 'ATIVIDADE', 'P', NULL, 'S', 'S', 'S', NULL, 'Q', NULL);
INSERT INTO DBAMV.PAGU_PERGUNTA (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(687, '687', 'MOBILIDADE', 'P', NULL, 'S', 'S', 'S', NULL, 'Q', NULL);
INSERT INTO DBAMV.PAGU_PERGUNTA (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(688, '688', 'NUTRIÇÃO', 'P', NULL, 'S', 'S', 'S', NULL, 'Q', NULL);
INSERT INTO DBAMV.PAGU_PERGUNTA (cd_pergunta, nm_identificador, ds_pergunta, tp_pergunta, ds_valor_inicial, sn_avaliacao, sn_justificativa, sn_sintese, ds_explicacao, tp_valor_inicial, cd_sinal_vital)
  VALUES(689, '689', 'FRICÇÃO E CISALHAMENTO', 'P', NULL, 'S', 'S', 'S', NULL, 'Q', NULL);
-- 2 INSERT DAS RESPOSTAS 
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(684, 2, 'Muito limitado', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(684, 1, 'Totalmente limitado', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(684, 3, 'Levemente limitado', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(684, 4, 'Nenhuma limitação', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(685, 1, 'Completamente molhado', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(685, 2, 'Muito molhado', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(685, 3, 'Ocasionalmente molhado', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(685, 4, 'Raramente molhado', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(686, 1, 'Acamado', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(686, 3, 'Anda ocasionalmente', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(686, 2, 'Confinado a cadeira', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(687, 1, 'Totalmente imovel', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(687, 2, 'Bastante limitado', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(687, 3, 'Levemente limitado', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(687, 4, 'Não apresenta limitações', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(688, 2, 'Provavelmente inadequada', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(688, 1, 'Muito pobre', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(688, 3, 'Adequada', 3, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(688, 4, 'Excelente', 4, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(689, 2, 'Problema em potencial', 2, 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(689, 1, 'Problema', 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_RESPOSTA (cd_pergunta, cd_resposta, ds_resposta, nr_ordem, vl_resposta, fx_inicial, fx_final, cd_formula, cd_itformula, cd_formula_itformula)
  VALUES(689, 3, 'Nenhum problema', 3, 3, NULL, NULL, NULL, NULL, NULL);
-- 3 INSERT DA AVALIAÇÃO
INSERT INTO DBAMV.PAGU_FORMULA (cd_formula, ds_formula, tp_formula, cd_acao, nr_periocidade_avaliacao, nr_inicio_avaliacao, sn_avaliacao_alta, sn_ativar_regras, cd_unidade_formula)
  VALUES(32, 'BRADEN ', 'E', NULL, NULL, NULL, 'N', 'N', NULL);
-- 4 INSERT DA FORMULA DA AVALIAÇÃO
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 1, 1, 'P', 684, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 2, 2, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 3, 3, 'P', 685, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 4, 4, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 5, 5, 'P', 686, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 6, 6, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 7, 7, 'P', 687, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 8, 8, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 9, 9, 'P', 688, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 10, 10, '+', NULL, NULL, NULL, NULL);
INSERT INTO DBAMV.PAGU_ITFORMULA (cd_formula, cd_itformula, nr_ordem, tp_itformula, cd_pergunta, ds_query_busca, vl_fixo, cd_formula_aux)
  VALUES(32, 11, 11, 'P', 689, NULL, NULL, NULL);
-- INSERE INTERPRETAÇÃO
INSERT INTO PAGU_FORMULA_INTERPRETACAO (cd_pagu_formula_interpretacao, cd_formula, vl_inicial, vl_final, ds_interpretacao, ds_intervencao, ds_sigla_interpretacao, ds_sigla_intervencao)
  VALUES(seq_pagu_formula_interpretacao.NEXTVAL, 32, 1, 9, 'SEVERO', NULL, 'SV', NULL);
INSERT INTO &table (cd_pagu_formula_interpretacao, cd_formula, vl_inicial, vl_final, ds_interpretacao, ds_intervencao, ds_sigla_interpretacao, ds_sigla_intervencao)
  VALUES(seq_pagu_formula_interpretacao.NEXTVAL, 32, 10, 12, 'ALTO', NULL, 'ALT', NULL);
INSERT INTO &table (cd_pagu_formula_interpretacao, cd_formula, vl_inicial, vl_final, ds_interpretacao, ds_intervencao, ds_sigla_interpretacao, ds_sigla_intervencao)
  VALUES(seq_pagu_formula_interpretacao.NEXTVAL, 32, 13, 14, 'MODERADO', NULL, 'MOD', NULL);
INSERT INTO &table (cd_pagu_formula_interpretacao, cd_formula, vl_inicial, vl_final, ds_interpretacao, ds_intervencao, ds_sigla_interpretacao, ds_sigla_intervencao)
  VALUES(seq_pagu_formula_interpretacao.NEXTVAL, 32, 15, 18, 'LEVE', NULL, 'LV', NULL);
INSERT INTO &table (cd_pagu_formula_interpretacao, cd_formula, vl_inicial, vl_final, ds_interpretacao, ds_intervencao, ds_sigla_interpretacao, ds_sigla_intervencao)
  VALUES(seq_pagu_formula_interpretacao.NEXTVAL, 32, 19, 36, 'SEM RISCO', NULL, 'SR', NULL);
COMMIT;
