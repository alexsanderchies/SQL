SELECT editor_layout.cd_layout 
      ,editor_layout.ds_layout
      ,editor_versao_documento.cd_documento
      ,editor_versao_documento.vl_versao
      ,editor_documento.ds_documento    
      ,editor_layout.cd_layout_cabecalho      
      ,editor_layout.cd_layout_rodape
  FROM dbamv.editor_layout
  JOIN dbamv.editor_versao_documento
    ON editor_layout.cd_versao_documento = editor_versao_documento.cd_versao_documento
  JOIN dbamv.editor_documento
    ON editor_versao_documento.cd_documento = editor_documento.cd_documento 

ORDER BY 3,1
