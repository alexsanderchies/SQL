--GERAR PRESCRIÇÃO:
--TIPO DE REGRA: AO FINALIZAR DOCUMENTO
--RESPOSTA: ITEM 1 = TRUE
--AÇÃO: 
CALL
DBAMV.PRC_COPIA_PRESC_PADRAO_DOC(5, &<PAR_CD_ATENDIMENTO>, '&<PAR_CD_USUARIO>',447)
/*  onde 5 substitua pelo código da prescrição padrão gerada
	onde 447 substitua pelo código de objeto da prescrição médica)
*/
PROMPT CREATE OR REPLACE PROCEDURE prc_copia_presc_padrao_doc
CREATE OR REPLACE PROCEDURE prc_copia_presc_padrao_doc( piPre_Pad INTEGER,
											PCD_ATENDIMENTO IN NUMBER,
											pUser VARCHAR2,
											pCd_Objeto IN NUMBER) IS


  -- ********************************************************************************
  -- *** Efetiva o processo de copia utilizando uma prescrição padrão             ***
  -- *** Esta rotina foi desenvolvida para criar uma prescrição através de um     ***
  -- *** documento eletrônico do PEP                                              ***
  -- ********************************************************************************

  --
  -- ********************************************************************************
  -- *** Efetiva o processo de copia                                              ***
  -- ********************************************************************************
  vformula      dbamv.pagu_formula.cd_formula%type;
  vqt_itpre_med dbamv.itpre_med.qt_itpre_med%TYPE := null;
  vqt_infusao   dbamv.itpre_med.qt_infusao%TYPE := null;
  vResultadoFormula NUMBER(10,4) := null;
  vCdPreMed NUMBER;
--  vPre_Med      dbamv.pkg_pagu_itPreMed.TypRec_PreMed;
  --
  vItPre_Med    NUMBER(10);
  vQt_ItPre     NUMBER(10);
  vQt_Horario   NUMBER;
  vDh_Pre_Med   DATE;   -- *** Recebe a data inicial para aplica??o do Medicamento ***
  nCdGrupoPre   Number;
  --
  -- PDA 525062 (INICIO) ->> Tabelas criadas para poder copiar ou n?o os componentes
  --
  Type TypRec_Copia_Comp Is Record(
    Cd_tip_presc    Dbamv.CItPre_Pad.Cd_tip_presc%TYPE
  , qt_componente   Dbamv.CItPre_Pad.qt_componente%TYPE
  , tp_componente   Dbamv.CItPre_Pad.tp_componente%TYPE
  , cd_unidade      Dbamv.CItPre_Pad.cd_unidade%TYPE
  , cd_uni_pro      Dbamv.CItPre_Pad.cd_uni_pro%TYPE
  , cd_uni_presc    Dbamv.CItPre_Pad.cd_uni_presc%TYPE
  , Cd_Produto      Dbamv.CItPre_Pad.Cd_Produto%TYPE
  , sn_fatura       Dbamv.CItPre_Pad.sn_fatura%TYPE
  , ds_citpre_pad   Dbamv.CItPre_Pad.ds_citpre_pad%TYPE
  , Sn_Copia        CHAR(1)
  , Cd_Itpre_Copia  Dbamv.CItPre_Pad.Cd_tip_presc%TYPE
  , Cd_ItPre_Med    Dbamv.Itpre_Med.Cd_ItPre_Med%TYPE
    );
  --
  Type TypTab_Copia_Comp Is Table Of TypRec_Copia_Comp Index By Binary_Integer;
  --
  Type TypRec_Copia_Comp_Aux Is Record(
     cd_itpre_copia Dbamv.CItPre_Pad.Cd_tip_presc%TYPE
   , cd_tip_presc   Dbamv.CItPre_Pad.Cd_tip_presc%TYPE
   , sn_marcado     CHAR(1));

  Type TypTab_Copia_Comp_Aux Is Table Of TypRec_Copia_Comp_Aux Index By Binary_Integer;

  tCItpre_pad     TypTab_Copia_Comp;
  tCItpre_pad_aux TypTab_Copia_Comp_Aux;
  vItemPresc	  VARCHAR2(100);
  item            NUMBER;
  indice          NUMBER := 0;
  indice_1        NUMBER := 0;
  itpre_med_ant   NUMBER;
  tip_presc_ant   NUMBER;
  --
  -- PDA 525062 (FIM)
  --
  -- PDA 170573 (Inicio)
  nPresc DBAMV.pkg_pagu_itpremed.TypTabPrepad;
  ntotal NUMBER;
  --
  -- PDA 232051(inicio) -- ggms vari?vel para recuperar o setor instalado da m?quina.
  vCdSetor NUMBER;
  vCdSetorTev   NUMBER;
  vCdUnidIntTev NUMBER;


        --GGMS TEV
       CURSOR cPremed (pCdPreMed Number) IS
        SELECT cd_atendimento
              ,cd_pre_med
              ,cd_setor
              ,cd_unid_int
              ,Dt_Referencia
              ,hr_Pre_Med Dh_Pre_Med
              ,dt_Validade   Dh_Validade
        FROM dbamv.pre_med
        WHERE cd_pre_med = pCdPreMed;

      --
      vPre_Med    cPremed%ROWTYPE;
  --
  -- PDA185112 - retirado parametro de codigo da prescri??o
  CURSOR C_Presc_Padrao(/* pItpre_pad NUMBER,*/ pPre_Pad NUMBER, pSetor NUMBER, pCdMultiEmpresa NUMBER ) Is -- Pda 426383
    SELECT DISTINCT
           itpre_pad.cd_pre_pad
         , itpre_pad.cd_itpre_pad
         , itpre_pad.cd_tip_esq
         , itpre_pad.cd_tip_presc
         , itpre_pad.cd_tip_fre
         , itpre_pad.qt_itpre_pad
         , itpre_pad.tp_situacao
         , itpre_pad.cd_set_exa
         , itpre_pad.ds_itpre_pad
         , itpre_pad.tp_local_exame
         , itpre_pad.cd_for_apl
         , itpre_pad.cd_produto
         , itpre_pad.cd_uni_pro
         , itpre_pad.cd_uni_presc -- pda 171304
         , itpre_pad.cd_unidade
         , itpre_pad.qt_infusao
         , itpre_pad.cd_uni_pro_inf
         , itpre_pad.cd_uni_presc_inf -- pda 171304
         , itpre_pad.hr_duracao -- pda 171302
         , tip_esq.sn_produto
         , tip_esq.sn_qtd
         , tip_esq.sn_exa_rx
         , tip_esq.sn_tipo
         , tip_esq.sn_exa_lab
         , tip_esq.sn_freq
         , tip_esq.sn_for_apl
         , tip_esq.sn_copia
         , tip_esq.sn_set_exa
         , tip_esq.sn_horario
         , tip_esq.sn_dias_aplicacao
         , tip_esq.sn_componente
         , tip_esq.sn_solicita_prestador
         , tip_esq.sn_kit
         , tip_presc.cd_prestador
         , tip_presc.cd_exa_lab -- pda 290696
		 , dbamv.pkg_tip_presc.Retorna_padronizado_valor(Tip_Presc.cd_tip_presc, pSetor) as sn_padronizado
         , tip_presc.ds_tip_presc descricaoItem
         , tip_presc.cd_produto produtoItem
         , tip_fre.tp_escopo -- pda 291222
         , itpre_pad.cd_material -- pda 429586
         , itpre_pad.qt_dose_padrao
         , itpre_pad.nr_ordem_impressao
         , Nvl(tip_fre.tp_controle,'N') Tp_Controle --PDA 999999
      FROM dbamv.itpre_pad itpre_pad,
           dbamv.tip_esq tip_esq,
           dbamv.tip_presc,
           dbamv.tip_presc_setor ,
           dbamv.tip_fre -- pda 291222
     WHERE Itpre_pad.cd_pre_pad   = pPre_Pad
       --AND Itpre_pad.cd_itpre_pad = pItpre_pad   -- PDA 140517 - Para pegar apenas os itens copiados
       AND Tip_Fre.Cd_Tip_Fre (+) = ItPre_Pad.Cd_Tip_Fre -- PDA 291222
       AND Tip_esq.Cd_tip_esq     = Itpre_pad.cd_tip_esq
       AND Tip_Presc.Cd_Tip_Presc = ItPre_Pad.Cd_Tip_Presc --PDA 232051-Filtar a permiss?o dos setores
       AND tip_presc_setor.cd_tip_presc(+) = tip_presc.cd_tip_presc
	   AND itpre_pad.sn_ativo = 'S'
       AND (tip_presc_setor.cd_setor = pSetor OR tip_presc_setor.cd_setor IS NULL)
       AND Nvl(Tip_Presc_Setor.Cd_Multi_Empresa, pCdMultiEmpresa) = pCdMultiEmpresa       ; -- Pda 426383
  --
    CURSOR C_ESQ (pItpre_pad number) IS
      SELECT SN_NR_DIA
        FROM DBAMV.TIP_ESQ TIP_ESQ
            ,DBAMV.ITPRE_PAD PRE_PAD
       WHERE TIP_ESQ.CD_TIP_ESQ  =  PRE_PAD.CD_TIP_ESQ
         AND  CD_ITPRE_PAD  =  pItpre_pad;
  -- PDA 525062 (INICIO) ->> Cursor para retornar os componentes ativos do item da PRE_PAD
  --

  CURSOR C_Componentes( pItPreMed NUMBER ) IS
  SELECT CItPre_Pad.Cd_tip_presc
       , CItPre_Pad.qt_componente
       , CItPre_Pad.tp_componente
       , CItPre_Pad.cd_unidade
       , CItPre_Pad.cd_uni_pro
       , CItPre_Pad.cd_uni_presc
       , Nvl(CItPre_Pad.cd_produto, Tip_Presc.Cd_Produto) Cd_Produto
       , CItPre_Pad.sn_fatura
       , CItPre_Pad.ds_citpre_pad
    FROM Dbamv.CItPre_Pad
       , Dbamv.Tip_Presc
   WHERE CItPre_Pad.Cd_ItPre_Pad = pItPreMed
     AND CItPre_Pad.Cd_Tip_Presc = Tip_Presc.Cd_Tip_Presc
     AND tip_presc.sn_ativo      = 'S'
  Order by CItPre_Pad.Cd_Tip_Presc; -- OP 13476
  --
  -- PDA 525062 (FIM)
  --
  dDhPreMed   DATE;
  vSnSolicita VARCHAR2(1);
  --
  tItpre_pad      dbamv.pkg_pagu_itpremed.TypTab_Copia;  -- PDA 140517
  tpre_pad        dbamv.pkg_pagu_itpremed.TypTabPrepad;
  nCdMultiEmpresa NUMBER := dbamv.pkg_mv2000.Le_Empresa; -- Pda 426383
  vSn_nr_dia VARCHAR2(1);  -- MRVS
  vNr_Dia    NUMBER;  -- MRVS
  --

-- Cursor que define em qual campo da itpre_med o resultado deve ser gravado: qt_itpre_med ou qt_infusão:
-- Obs.: este cursor deve retornar nenhuma ou uma linha, se retornar mais de uma temos um problema de configuração
-- o cursor abaixo (cPadraoFormulaCount) checa quantos registros temos para a query
CURSOR cPadraoFormula(cdFormula NUMBER) is
  SELECT Upper(padrao_formula.cd_coluna_grava) AS cd_coluna_grava
    FROM dbamv.padrao_formula
        ,dbamv.padrao_formula_pergunta
   WHERE padrao_formula.cd_padrao_formula = padrao_formula_pergunta.cd_padrao_formula
     AND padrao_formula.cd_formula = cdFormula
     AND Upper(padrao_formula.cd_tabela_grava) = 'ITPRE_MED'
     AND Upper(padrao_formula.cd_coluna_grava) IN ('QT_ITPRE_MED','QT_INFUSAO')
     AND Upper(padrao_formula_pergunta.cd_tabela_busca) = 'ITPRE_MED'
     AND Upper(padrao_formula_pergunta.cd_coluna_busca) = 'QT_DOSE_PADRAO';

CURSOR cHorarioSetor(pCdSetor NUMBER) IS
      SELECT HR_PRESC_MED
      FROM Dbamv.Config_Pagu_Setor
      WHERE cd_setor = pCdSetor;

   vDtSetorHorario date;



-- Este cursor é igual ao acima (cPadraoFormula), só que faz um count ao invés de retornar os dados
CURSOR cPadraoFormulaCount(cdFormula NUMBER) is
  SELECT Count(*) AS qtConfiguracoes
    FROM dbamv.padrao_formula
        ,dbamv.padrao_formula_pergunta
   WHERE padrao_formula.cd_padrao_formula = padrao_formula_pergunta.cd_padrao_formula
     AND padrao_formula.cd_formula = cdFormula
     AND Upper(padrao_formula.cd_tabela_grava) = 'ITPRE_MED'
     AND Upper(padrao_formula.cd_coluna_grava) IN ('QT_ITPRE_MED','QT_INFUSAO')
     AND Upper(padrao_formula_pergunta.cd_tabela_busca) = 'ITPRE_MED'
     AND Upper(padrao_formula_pergunta.cd_coluna_busca) = 'QT_DOSE_PADRAO';

-- Cursor para pegar o Tipo de objeto pagu
CURSOR C_TP_PAGU_OBJETO(P_CD_OBJETO NUMBER) IS
  SELECT TP_OBJETO
    FROM DBAMV.PAGU_OBJETO
   WHERE CD_OBJETO = P_CD_OBJETO;

rPadraoFormula cPadraoFormula%ROWTYPE;
vQtConfiguracoesPadraoFormula INTEGER;
v_tp_pagu_objeto C_TP_PAGU_OBJETO%ROWTYPE;

	cursor cEmpresa is
		select cd_multi_empresa
			from dbamv.atendime
			where cd_atendimento = PCD_ATENDIMENTO;

	vCdEmpresa Number;


  FUNCTION FNC_RETORNA_GRUPO(pCdPrescricao Number, pCdTipPresc Number) RETURN NUMBER IS

  CURSOR cGrupoPresc IS
    SELECT pw_grupo_prescricao_itpre_med.cd_grupo_prescricao_itpre_med
      FROM dbamv.pw_grupo_prescricao_itpre_med
       ,  dbamv.pw_grupo_prescricao_tipo_esqm
       ,  dbamv.Tip_Presc
    WHERE Tip_Presc.cd_tip_esq                              = pw_grupo_prescricao_tipo_esqm.cd_tip_esq
      AND pw_grupo_prescricao_itpre_med.cd_grupo_prescricao = pw_grupo_prescricao_tipo_esqm.cd_grupo_prescricao
      AND pw_grupo_prescricao_itpre_med.cd_pre_med          = pCdPrescricao
      AND Tip_Presc.Cd_Tip_Presc                            = pCdTipPresc;


  vGrupoPrescricao Number;

  BEGIN
  Open cGrupoPresc;
   Fetch cGrupoPresc Into vGrupoPrescricao;
  Close cGrupoPresc;

  Return vGrupoPrescricao;

  END;
  --


BEGIN

   OPEN cEmpresa;
   FETCH cEmpresa INTO vCdEmpresa;
   CLOSE cEmpresa;

  dbamv.pkg_mv2000.atribui_empresa(vCdEmpresa);
  nCdMultiEmpresa :=  vCdEmpresa;

   dbamv.pkg_mv_variaveis.prc_set_usuario(pUser);

   dbamv.prc_retor_unid_setor_paciente( PCD_ATENDIMENTO, SYSDATE, vCdUnidIntTev, vCdSetor);

  OPEN  cHorarioSetor(vCdSetor);
  FETCH cHorarioSetor INTO vDtSetorHorario;
  CLOSE cHorarioSetor;

       IF  vDtSetorHorario is NOT NULL THEN

         vDtSetorHorario:= dbamv.fnc_mv_recupera_data_hora( sysdate, vDtSetorHorario ) ;

       ELSE

         vDtSetorHorario:= SYSDATE;

       END if;

    OPEN C_TP_PAGU_OBJETO(pCd_Objeto);
   FETCH C_TP_PAGU_OBJETO INTO v_tp_pagu_objeto;
   CLOSE C_TP_PAGU_OBJETO;

   vCdPreMed:= DBAMV.fnc_pagu_criar_prescricao(PCD_ATENDIMENTO,'MVPEP_PRESCRICAO' ,vDtSetorHorario ,vCdSetorTev , v_tp_pagu_objeto.TP_OBJETO ,vCdSetor ,pCd_Objeto ,vCdUnidIntTev);


     --GGMS TEV
     OPEN cPremed (vCdPreMed) ;
     FETCH cPremed INTO vPre_Med;
     CLOSE cPremed;

  --
  --PDA 232051(inicio) --ggms vari?vel para recuperar o setor instalado da m?quina.
  vCdSetor := vPre_Med.cd_setor;
  --

  -- *** Se n?o existir ele cria ***
  IF piPre_Pad <> 0 THEN
     --
     tpre_pad := dbamv.pkg_pagu_itpremed.le_prescricao_padrao;
     --vPre_Med := Pkg_Pagu_ItPreMed.Fn_PreMed;  -->> Atribui os valores da prescri??o que foi criado

     --
	 -- GGDS 24/11/2011 - PDA: 473762 - Caso (SN_VERIFICA_SETOR_INSTALADO = N) no global, ser? ignorado a configura??o do setor instalado.
	 IF (Nvl(dbamv.pkg_mv2000.le_configuracao('PAGU', 'SN_VERIFICA_SETOR_INSTALADO'), 'S') = 'N' ) THEN
		vCdSetor := dbamv.pkg_pagu.Fn_Atendimento(vPre_Med.Cd_Atendimento).Cd_Setor;
	 END IF;
	 --
     -- PDA 140517 (Inicio) - ser?o inseridos os itens que estiverem na tabela de registros
     tItpre_pad := pkg_pagu_itpremed.Itpresc_Copia_Query;
     --

                  FOR c1 IN c_presc_padrao(piPre_Pad, vCdSetor, nCdMultiEmpresa)
                  LOOP
                      --
                    IF Nvl(c1.Sn_Horario,'N') = 'S' THEN
                       dbamv.Prc_Pagu_Dh_Aplica_Item( C1.Cd_Tip_Presc
                                                    , vPre_Med.Cd_Atendimento
                                                    , vPre_Med.Dt_Referencia
                                                    , vPre_Med.Dh_Pre_Med
                                                    , vPre_Med.Dh_Validade
                                                    , dDhPreMed
                                                    , vSnSolicita  );
                    ELSE
                       dDhPreMed := vPre_Med.Dh_Pre_Med;
                       vSnSolicita := 'S';
                    END IF;
                    --
                    -- PDA 140517 - If adicionado para Inserir apenas o item n?o componente e gerar o sequencial apenas para ele.
                    IF c1.cd_tip_presc IS not  NULL THEN --ggms tev

                       --
                       SELECT dbamv.Seq_ItPre_Med.NEXTVAL
                         INTO vItPre_Med
                         FROM Sys.Dual;
                       --
                       -- PDA 170573(Inicio)
                        nPresc := dbamv.pkg_pagu_itpremed.le_prescricao_padrao;
                        ntotal := nPresc.last;
                       -- PDA 170573(Fim)
                       -- PDA 290696 Adicionado esse c?digo pois n?o estava verificando a configura??o de setor padr?o no momento
                       --            de c?pia de prescri??o padr?o.
                       IF pkg_pagu_ItPreMed.Fn_Tip_Presc( c1.Cd_Tip_Presc ).Sn_Set_Exa = 'S' THEN
                         --
                         -- setor default
                         c1.Cd_Set_Exa := Nvl( dbamv.busca_set_exa( Pkg_Pagu.Fn_Atendimento( vPre_Med.Cd_Atendimento ).cd_unid_int
                                                                  , Pkg_Pagu.Fn_Atendimento( vPre_Med.Cd_Atendimento ).cd_setor
                                                                  , c1.Cd_Tip_Presc
                                                                  , Pkg_Pagu_ItPreMed.Fn_PreMed().Dh_Pre_Med
                                                                  , c1.Cd_Tip_Esq
                                                                  , Null
                                                                  , c1.Cd_Exa_Lab )
                                             , c1.Cd_Set_Exa );
                       END IF;
                       --
                       -- PDA 291222 Inicio
                       IF c1.Tp_Escopo = 'D' THEN
                         c1.Cd_Tip_Fre := NULL;
                       END IF;
                       -- PDA 291222 Fim
                       --
					   nCdGrupoPre := FNC_RETORNA_GRUPO(vPre_Med.Cd_Pre_Med, C1.Cd_Tip_Presc);
					   --
                       --PDA 174688 - quantidade do item dependera da formula previamente cadastrada para aquele item padr?o
                       vResultadoFormula := dbamv.PKG_AVALIACAO.FNC_FORMULA_ITPRE_PAD( c1.cd_itpre_pad
                                                                                      , vPre_Med.Cd_Atendimento
                                                                                      , vformula
                                                                                      , c1.qt_dose_padrao );

                       -- As 2 variáveis abaixo são respectivamente, os valores que gravaremos na itpre_med,
                       -- inicializamos elas com os valores da itpre_pad, se alguma fórmula foi utilizada,
                       -- um destes valores será alterado no if abaixo
                       vqt_itpre_med := c1.qt_itpre_pad;
                       vqt_infusao := c1.qt_infusao;

                        -- Se vformula for != de nulo então foi usada uma fórmula para calcular a quantidade ou velocidade de infusão
                        IF vformula IS NOT NULL THEN
                          -- Os 2 cursores abaixo são iguais exceto pelo fato de o 1o retorna a quantidade de dados
                          -- e o segundo retorna os dados
                          OPEN cPadraoFormulaCount(vformula);
                          FETCH cPadraoFormulaCount INTO vQtConfiguracoesPadraoFormula;
                          CLOSE cPadraoFormulaCount;

                          OPEN cPadraoFormula(vformula);
                          FETCH cPadraoFormula INTO rPadraoFormula;
                          CLOSE cPadraoFormula;

                          IF vQtConfiguracoesPadraoFormula = 0 THEN
                            -- Se o cursor não retornou nada então não é a fórmula da dose padrão, gravamos o resultado em qt_itpre_med
                            vqt_itpre_med := vResultadoFormula;
                          ELSIF vQtConfiguracoesPadraoFormula = 1 THEN
                            -- Se o cursor retornou 1 registro, então a fórmula utiliza dose padrão e a configuração indica onde gravar o
                            -- resultado que será na quantidade ou vel. infusão do item:
                            if (rPadraoFormula.cd_coluna_grava = 'QT_ITPRE_MED') then
                              vqt_itpre_med := vResultadoFormula;
                            elsif (rPadraoFormula.cd_coluna_grava = 'QT_INFUSAO') then
                              vqt_infusao := vResultadoFormula;
                            end if;
                          ELSE
                            -- Se o cursor retornou mais de uma linha, então temos um erro de configuraçao.
                            DECLARE
                              cdFormula dbamv.pagu_formula.cd_formula%type;
                              dsFormula dbamv.pagu_formula.ds_formula%type;
                            BEGIN
                              -- Select apenas para pergar código e nome da fórmula para mostrar no erro:
                              SELECT cd_formula, ds_formula
                                INTO cdFormula, dsFormula
                                FROM dbamv.pagu_formula
                               WHERE cd_formula = vformula;

							--MULTI-IDIOMA: Utilização do pkg_rmi_traducao.extrair_msg para mensagens (MSG_2)
														  Raise_Application_Error(-20001, dbamv.pkg_rmi_traducao.extrair_proc_msg('MSG_2',
							 'PRC_PAGU_COPIA_PRESC_PADRAO',
							 'Não é possível determinar onde gravar o resultado da fórmula. A fórmula %s (%s) está configurada para gravar em mais de um campo do item de prescriçao. Verifique as configurações no Cadastro de Fórmulas Padrão.', arg_list(dsFormula, cdFormula)));
                            END;
                          END IF;
                        END IF; -- fim do IF vformula IS NOT NULL THEN
                       --
                       INSERT INTO dbamv.ItPre_Med( Cd_ItPre_Med
                                                  , Cd_Tip_Esq
                                                  , Cd_Pre_Med
                                                  , Cd_Tip_Presc
                                                  , Cd_For_Apl
                                                  , Cd_Tip_Fre
                                                  , Qt_ItPre_Med
                                                  , Tp_Situacao
                                                  , Cd_Set_Exa
                                                  , Cd_Prestador
                                                  , Dh_Inicial
                                                  , Dh_Final
                                                  , Sn_Copia
                                                  , Sn_Cancelado
                                                  , Cd_Unidade
                                                  , qt_infusao        -- PDA 101371
                                                  , cd_uni_pro_inf    -- PDA 101371
                                                  , Cd_Uni_Pro
                                                  , cd_uni_presc_inf  -- PDA 171304
                                                  , Cd_Uni_Presc      -- PDA 171304
                                                  , Cd_Produto
                                                  , Ds_ItPre_Med
                                                  , Dh_Cancelado
                                                  , Cd_Prest_Canc
                                                  , DS_NPADRONIZADO
                                                  , CD_NPADRONIZADO
                                                  , Cd_ItPre_Pad
                                                  , Sn_Solicita
                                                  , Cd_Formula
                                                  , hr_duracao        -- PDA 171302
                                                  , Cd_Material
                                                  , nr_dia      -- PDA 429586
                                                  , qt_dose_padrao
                                                  , nr_ordem
                                                  , Cd_Grupo_Prescricao_ItPre_Med
                                                  , Sn_Urgente) --PDA 999999
                                           VALUES ( vItPre_Med
                                                  , C1.Cd_Tip_Esq
                                                  , vPre_Med.Cd_Pre_Med
                                                  , C1.Cd_Tip_Presc
                                                  , C1.Cd_For_Apl
                                                  , C1.Cd_Tip_Fre     -- PDA 177220 (Inicio)
                                                  , vqt_itpre_med     -- PDA 177220 (Fim)
                                                  , C1.Tp_Situacao
                                                  , C1.Cd_Set_Exa
                                                  , Decode( C1.Sn_Solicita_Prestador, 'S', C1.Cd_Prestador , Null )
                                                  , Decode( C1.Sn_Horario, 'S', Decode(C1.Tp_Controle, 'U', SYSDATE,'A', SYSDATE, dDhPreMed), Null )--PDA 563784

                                                  , Decode( C1.Sn_Horario, 'S', vPre_Med.Dh_Validade, Null )
                                                  , 'S'
                                                  , 'N'
                                                  , C1.Cd_Unidade
                                                  , vqt_infusao         -- PDA 101371 -- PDA 549245
                                                  , C1.cd_uni_pro_inf     -- PDA 101371
                                                  , C1.Cd_Uni_Pro
                                                  , C1.cd_uni_presc_inf   -- PDA 171304
                                                  , C1.Cd_Uni_Presc       -- PDA 171304
                                                  , C1.Cd_Produto
                                                  , C1.Ds_ItPre_Pad
                                                  , Null
                                                  , Null
                                                  , Decode(C1.SN_PADRONIZADO,'N', C1.descricaoItem, NULL)
                                                  , Decode(C1.SN_PADRONIZADO,'N', Decode(c1.produtoItem, NULL, NULL, c1.produtoItem),NULL)
                                                  , C1.Cd_ItPre_Pad
                                                  , vSnSolicita
                                                  , vformula
                                                  , c1.hr_duracao         -- PDA 171302
                                                  , C1.Cd_Material
                                                  , vNr_Dia        -- PDA 429586
                                                  , c1.qt_dose_padrao
                                                  , c1.nr_ordem_impressao
                                                  , nCdGrupoPre
                                                  , Decode(C1.Tp_Controle, 'U', 'S', Null) --PDA 999999
                                                  );
                       --


                       IF (c1.Sn_Horario = 'S' AND vSnSolicita = 'S') OR (c1.Sn_Freq = 'S' AND vSnSolicita = 'S') THEN
                          vQt_Horario := Fnc_Pagu_Grava_Horario( vItPre_Med );
                       END IF;
                       -- PDA 132551 (Fim)
                       --
                       -- PDA 170573(Inicio)
                       IF nPresc.exists(1) THEN
                          FOR r1 IN 1..ntotal
                          LOOP
                            -- PDA 174693(Inicio)
                            -- cria horarios para esta prescricao
                            dbamv.pkg_pagu_tratamento.cria_horarios_itpremed(nPresc(r1).cdprepad,vItPre_Med, vPre_Med.Cd_Atendimento);
                            --
                          END LOOP;
                       END IF;
                       -- PDA 170573(Fim)
                       -- PDA 525062 ->> Preenche a tabela com os componentes do item corrente
                    -- GGDS 548030 - comentei esta linha pois não estava gerando os componentes quando presc. padrão (protocolo ooncologia)
                    -- tCItpre_pad.Delete; -- Pda 501612
                       FOR Comp IN C_Componentes(c1.cd_itpre_pad)
                       LOOP
                            indice := indice + 1;
                            tCItpre_pad(indice).Cd_tip_presc   := Comp.Cd_tip_presc;
                            tCItpre_pad(indice).qt_componente  := Comp.qt_componente;
                            tCItpre_pad(indice).tp_componente  := Comp.tp_componente;
                            tCItpre_pad(indice).cd_unidade     := Comp.cd_unidade;
                            tCItpre_pad(indice).cd_uni_pro     := Comp.cd_uni_pro;
                            tCItpre_pad(indice).cd_uni_presc   := Comp.cd_uni_presc;
                            tCItpre_pad(indice).Cd_Produto     := Comp.Cd_Produto;
                            tCItpre_pad(indice).sn_fatura      := Comp.sn_fatura;
                            tCItpre_pad(indice).ds_citpre_pad  := Comp.ds_citpre_pad;
                   --         tCItpre_pad(indice).Cd_Itpre_Copia := c.cd_itpre_pad;
                    --        tCItpre_pad(indice).Sn_Copia       := c.Sn_Marcado;
                            tCItpre_pad(indice).Cd_ItPre_Med   := vItPre_Med;
                       END LOOP;
                    END IF;
                  END LOOP; -- *** Final do Loop para o cursor com os itens padroes ***

		  /*IF tCItpre_pad_aux.first IS NOT NULL THEN
            FOR i IN tCItpre_pad_aux.first..tCItpre_pad_aux.last
            LOOP
              IF tCItpre_pad.first IS NOT NULL THEN
                FOR j IN tCItpre_pad.first..tCItpre_pad.last
                LOOP
                    IF tCItpre_pad(j).cd_itpre_copia = tCItpre_pad_aux(i).cd_itpre_copia AND tCItpre_pad(j).cd_tip_Presc = tCItpre_pad_aux(i).cd_tip_Presc
                     AND tCItpre_pad(j).Sn_Copia <> 'N' Then

                      tCItpre_pad(j).Sn_Copia := 'N';

                    END IF;
                END LOOP;
              END IF;
            END LOOP;


          END IF;
          */

                 Dbms_Output.Put_Line('tev 1x : ');


		  -- PDA 525062 ->> Insere apenas os componentes que realmente necessitem ser inserido
          IF tCItpre_pad.first IS NOT NULL THEN
               Dbms_Output.Put_Line('tev 2x : ');

            FOR f IN tCItpre_pad.first..tCItpre_pad.last        LOOP
               Dbms_Output.Put_Line('tev 2.1x : '||tCItpre_pad(f).Sn_Copia||' - '||tCItpre_pad(f).Cd_tip_presc||' <> '||tip_presc_ant );


        /*        IF (tCItpre_pad(f).Sn_Copia = 'S' AND (tCItpre_pad(f).Cd_tip_presc <> tip_presc_ant)
                                                  OR  (tCItpre_pad(f).Cd_tip_presc = tip_presc_ant) ) --PDA 571881
			  OR  (tCItpre_pad(f).Sn_Copia = 'S' AND itpre_med_ant IS NULL AND tip_presc_ant IS NULL) THEN   */

                  itpre_med_ant := tCItpre_pad(f).Cd_ItPre_Med;
                  tip_presc_ant := tCItpre_pad(f).Cd_Tip_Presc;

                     Dbms_Output.Put_Line('tev 3x : ');

					--
                  INSERT INTO dbamv.cItPre_Med( Cd_itpre_med
                                              , Cd_tip_presc
                                              , qt_componente
                                              , tp_componente
                                              , cd_unidade
                                              , cd_uni_pro
                                              , cd_uni_presc --PDA 171304
                                              , cd_produto
                                              , sn_fatura
                                              , ds_citpre_med )
                                        VALUES( tCItpre_pad(f).Cd_ItPre_Med
                                              , tCItpre_pad(f).Cd_tip_presc
                                              , tCItpre_pad(f).qt_componente
                                              , tCItpre_pad(f).tp_componente
                                              , tCItpre_pad(f).cd_unidade
                                              , tCItpre_pad(f).cd_uni_pro
                                              , tCItpre_pad(f).cd_uni_presc   -- PDA 171304
                                              , tCItpre_pad(f).Cd_Produto
                                              , tCItpre_pad(f).sn_fatura
                                              , tCItpre_pad(f).ds_citpre_pad
                                      );

             --   END IF;

            END LOOP;

	      	tCItpre_pad.DELETE; -- GGDS 548030

          END IF;
		  -- PDA 525062(FIM)

  END IF;


END;
/

GRANT EXECUTE ON prc_copia_presc_padrao_doc TO dbaps;
GRANT EXECUTE ON prc_copia_presc_padrao_doc TO dbasgu;
GRANT EXECUTE ON prc_copia_presc_padrao_doc TO mv2000;
GRANT EXECUTE ON prc_copia_presc_padrao_doc TO mvintegra;
