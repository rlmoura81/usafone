inherited FormRelUsuario: TFormRelUsuario
  Caption = 'USACUCAR - UsaFone - Usu'#225'rios'
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsUsuario
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 72
        Caption = 'Usu'#225'rios'
      end
    end
    inherited rlbCabecalho: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object rllMatricula: TRLLabel
        Left = 8
        Top = 8
        Width = 80
        Height = 16
        Caption = 'MATRICULA'
      end
      object rllNome: TRLLabel
        Left = 112
        Top = 8
        Width = 40
        Height = 16
        Caption = 'NOME'
      end
      object rllCargo: TRLLabel
        Left = 376
        Top = 8
        Width = 48
        Height = 16
        Caption = 'CARGO'
      end
      object rllUnidade: TRLLabel
        Left = 600
        Top = 8
        Width = 64
        Height = 16
        Caption = 'UNIDADE'
      end
    end
    inherited rlbRegistro: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.Color = clGray
      object rldbMatricula: TRLDBText
        Left = 8
        Top = 8
        Width = 104
        Height = 16
        DataField = 'CD_MATRICULA'
        DataSource = dsUsuario
      end
      object rldbNome: TRLDBText
        Left = 112
        Top = 8
        Width = 64
        Height = 16
        DataField = 'DS_NOME'
        DataSource = dsUsuario
      end
      object rldbCargo: TRLDBText
        Left = 376
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_CARGO'
        DataSource = dsUsuario
      end
      object rldbUnidade: TRLDBText
        Left = 600
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_USINA'
        DataSource = dsUsuario
      end
    end
  end
  object dsUsuario: TDataSource
    DataSet = dm.ADOQusuario
    Left = 80
    Top = 456
  end
end
