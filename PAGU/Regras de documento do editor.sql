SELECT editor_layout_regra.*
      ,editor_regra.ds_regra
  FROM editor_documento
  JOIN editor_versao_documento
    ON editor_documento.cd_documento = editor_versao_documento.cd_documento
  JOIN EDITOR_LAYOUT
    ON editor_versao_documento.cd_versao_documento = editor_layout.cd_versao_documento
  JOIN editor_layout_regra
    ON editor_layout_regra.cd_layout = editor_layout.cd_layout
  JOIN editor_regra
    ON editor_regra.cd_regra = editor_layout_regra.cd_regra
  WHERE editor_versao_documento.cd_documento = 454
    AND editor_versao_documento.vl_versao = '4'
    AND DS_LAYOUT = 'Tela'
ORDER BY 3





                                                    --SELECT * FROM editor_regra


                           --editor_versao_documento



