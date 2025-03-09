object dm: Tdm
  OldCreateOrder = False
  Left = 749
  Top = 97
  Height = 870
  Width = 437
  object ADOusafone: TADOConnection
    Connected = True
    ConnectionString = 'FILE NAME=G:\SOL\EXECUT\usafone.UDL'
    LoginPrompt = False
    Provider = 'OraOLEDB.Oracle.1'
    Left = 40
    Top = 16
  end
  object ADOQmarca: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from marca'
      '   order by cd_marca')
    Left = 40
    Top = 72
  end
  object dsMarca: TDataSource
    DataSet = ADOQmarca
    Left = 128
    Top = 72
  end
  object ADOQSQL: TADOQuery
    Connection = ADOusafone
    Parameters = <>
    Left = 128
    Top = 16
  end
  object ADOQmodelo: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT modelo.cd_marca, modelo.cd_modelo, marca.ds_marca, modelo' +
        '.ds_modelo'
      '   FROM modelo, marca'
      '      WHERE modelo.cd_marca = marca.cd_marca'
      '      ORDER BY marca.ds_marca, modelo.ds_modelo'
      '')
    Left = 40
    Top = 128
  end
  object dsModelo: TDataSource
    DataSet = ADOQmodelo
    Left = 128
    Top = 128
  end
  object ADOQcidade: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM cidade'
      '   ORDER BY cd_cidade')
    Left = 40
    Top = 184
  end
  object dsCidade: TDataSource
    DataSet = ADOQcidade
    Left = 128
    Top = 184
  end
  object ADOQoperadora: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM operadora'
      '   ORDER BY cd_operadora')
    Left = 40
    Top = 240
  end
  object dsOperadora: TDataSource
    DataSet = ADOQoperadora
    Left = 128
    Top = 240
  end
  object ADOQusina: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT  usina.cd_usina, usina.ds_usina, cidade.cd_cidade, cidade' +
        '.ds_cidade '
      '   FROM usina, cidade'
      '   WHERE usina.cd_cidade = cidade.cd_cidade'
      '   ORDER BY usina.cd_usina')
    Left = 40
    Top = 304
  end
  object dsUsina: TDataSource
    DataSet = ADOQusina
    Left = 128
    Top = 304
  end
  object ADOQusuario: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, ' +
        'usuario.cd_usina, usina.ds_usina'
      '   from usuario, usina'
      '   where usuario.cd_usina = usina.cd_usina'
      '   order by ds_usina, cd_matricula, ds_nome')
    Left = 40
    Top = 360
  end
  object dsUsuario: TDataSource
    DataSet = ADOQusuario
    Left = 128
    Top = 360
  end
  object ADOQaparelho: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT aparelho.cd_aparelho, aparelho.cd_modelo, aparelho.cd_ope' +
        'radora, aparelho.cd_marca, marca.cd_marca, marca.ds_marca, model' +
        'o.ds_modelo, operadora.ds_operadora, aparelho.qtde, aparelho.dt_' +
        'data'
      '   FROM aparelho, marca, modelo, operadora'
      '   WHERE aparelho.cd_modelo = modelo.cd_modelo and'
      '                  modelo.cd_marca = marca.cd_marca and'
      '                  aparelho.cd_operadora = operadora.cd_operadora'
      '   ORDER BY marca.ds_marca, modelo.ds_modelo')
    Left = 40
    Top = 416
  end
  object dsAparelho: TDataSource
    DataSet = ADOQaparelho
    Left = 128
    Top = 416
  end
  object ADOQchip: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select chip.cd_usina, usina.ds_usina, chip.cd_numero, chip.cd_im' +
        'ei, chip.cd_pin2, chip.cd_operadora, operadora.ds_operadora, chi' +
        'p.st_chip'
      'from chip, usina, operadora'
      'where chip.cd_usina = usina.cd_usina and'
      'chip.cd_operadora = operadora.cd_operadora'
      'order by chip.cd_usina, chip.cd_numero')
    Left = 40
    Top = 472
  end
  object dsChip: TDataSource
    DataSet = ADOQchip
    Left = 128
    Top = 472
  end
  object ADOQlistafone: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select rownum col, a.* from (select listafone.ds_nome, listafone' +
        '.cd_numero'
      'from listafone, usuario'
      'where listafone.cd_matricula = usuario.cd_matricula'
      'order by listafone.ds_nome) a')
    Left = 40
    Top = 520
  end
  object dsListafone: TDataSource
    DataSet = ADOQlistafone
    Left = 128
    Top = 520
  end
  object ADOQagenda: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select usina.cd_usina, usuario.cd_matricula, usuario.ds_nome, ag' +
        'enda.cd_numero, chip.cd_pin2, operadora.ds_operadora, marca.cd_m' +
        'arca, marca.ds_marca, agenda.cd_aparelho, modelo.ds_modelo, apar' +
        'elho.cd_marca'
      
        '   from usina, agenda, usuario, modelo, aparelho, operadora, chi' +
        'p, marca'
      '   where agenda.cd_usina = usina.cd_usina and'
      '      agenda.cd_matricula = usuario.cd_matricula and'
      '      agenda.cd_aparelho = aparelho.cd_aparelho and'
      '      aparelho.cd_modelo = modelo.cd_modelo and'
      '      aparelho.cd_marca = marca.cd_marca and'
      '      aparelho.cd_operadora = operadora.cd_operadora and'
      '      agenda.cd_numero = chip.cd_numero'
      '   order by usuario.ds_nome')
    Left = 40
    Top = 568
  end
  object dsAgenda: TDataSource
    DataSet = ADOQagenda
    Left = 128
    Top = 568
  end
  object ADOQacesso: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select usina.ds_usina, acesso.cd_usina, usuario.ds_nome, usuario' +
        '.cd_matricula, acesso.ds_login, acesso.cd_acesso'
      '   from usuario, acesso, usina'
      '   where usina.cd_usina = acesso.cd_usina and'
      '      usina.cd_usina = usuario.cd_usina and'
      '      acesso.cd_matricula = usuario.cd_matricula and'
      '      acesso.cd_matricula = acesso.cd_matricula'
      '   order by usina.ds_usina, usuario.ds_nome')
    Left = 40
    Top = 624
  end
  object dsAcesso: TDataSource
    DataSet = ADOQacesso
    Left = 128
    Top = 624
  end
  object ADOQestoque: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select usuario.ds_nome, marca.ds_marca, modelo.ds_modelo, estoqu' +
        'e.qtde, estoque.ds_data'
      'from usuario, estoque, marca, modelo, aparelho'
      'where marca.cd_marca = aparelho.cd_marca and'
      'modelo.cd_modelo = aparelho.cd_modelo and'
      'aparelho.cd_aparelho = estoque.cd_aparelho and'
      'usuario.cd_matricula = estoque.cd_matricula'
      'order by estoque.ds_data desc, usuario.ds_nome')
    Left = 40
    Top = 680
  end
  object dsEstoque: TDataSource
    DataSet = ADOQestoque
    Left = 128
    Top = 680
  end
  object dsGasto: TDataSource
    DataSet = ADOQgasto
    Left = 128
    Top = 736
  end
  object ADOQgasto: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select usuario.cd_matricula, usuario.ds_nome, gasto.cd_numero, g' +
        'asto.dt_referencia, gasto.vl_mes'
      'from gasto, usuario, agenda'
      'where usuario.cd_matricula = agenda.cd_matricula and'
      'gasto.cd_numero = agenda.cd_numero')
    Left = 40
    Top = 736
  end
  object ADOQblackberry: TADOQuery
    Active = True
    Connection = ADOusafone
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select rownum col, a.* from'
      
        '(select usina.cd_usina, usuario.cd_matricula, usuario.ds_nome, u' +
        'suario.ds_cargo, agenda.cd_numero, usina.ds_usina, modelo.ds_mod' +
        'elo, blackberry.cd_imei, blackberry.cd_pin'
      'from usuario, agenda, usina, modelo, blackberry, aparelho, marca'
      'where usuario.cd_matricula = agenda.cd_matricula and'
      'usuario.cd_usina = agenda.cd_usina and'
      'usina.cd_usina = agenda.cd_usina and'
      'agenda.cd_matricula = blackberry.cd_matricula and'
      'agenda.cd_usina = blackberry.cd_usina and'
      'aparelho.cd_aparelho = agenda.cd_aparelho and'
      'aparelho.cd_modelo = modelo.cd_modelo and'
      'aparelho.cd_marca = marca.cd_marca and'
      'marca.cd_marca = 7'
      'order by usuario.ds_nome) a')
    Left = 40
    Top = 792
  end
  object dsBlackberry: TDataSource
    DataSet = ADOQblackberry
    Left = 128
    Top = 792
  end
end
