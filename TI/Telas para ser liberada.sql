SELECT * FROM dbasgu.menu WHERE Upper(MENU.NM_MENU) LIKE Upper('%Conta Ext%')

SELECT menu_2.nm_menu || ' > ' || menu_1.nm_menu || ' > ' || menu.nm_menu 
      ,menu.cd_modulo
  FROM dbasgu.menu 
  JOIN dbasgu.menu menu_1
    ON menu.cd_menu_pai = menu_1.cd_menu
  JOIN dbasgu.menu menu_2
    ON menu_1.cd_menu_pai = menu_2.cd_menu
  WHERE Upper(MENU.NM_MENU) LIKE Upper('%Não agendado%')