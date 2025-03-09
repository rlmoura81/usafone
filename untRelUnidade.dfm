inherited FormRelUnidade: TFormRelUnidade
  Caption = 'USACUCAR - UsaFone - Unidade'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsUnidade
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 144
        Caption = 'Unidades (Usinas)'
      end
    end
    inherited rlbCabecalho: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object rllCodigo: TRLLabel
        Left = 40
        Top = 8
        Width = 56
        Height = 16
        Caption = 'C'#211'DIGO'
      end
      object rllUnidade: TRLLabel
        Left = 232
        Top = 8
        Width = 64
        Height = 16
        Caption = 'UNIDADE'
      end
      object rllCidade: TRLLabel
        Left = 456
        Top = 8
        Width = 56
        Height = 16
        Caption = 'CIDADE'
      end
    end
    inherited rlbRegistro: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.Color = clGray
      object rldbCodigo: TRLDBText
        Left = 40
        Top = 8
        Width = 72
        Height = 16
        DataField = 'CD_USINA'
        DataSource = dsUnidade
      end
      object rldbUnidade: TRLDBText
        Left = 232
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_USINA'
        DataSource = dsUnidade
      end
      object rldbCidade: TRLDBText
        Left = 456
        Top = 8
        Width = 80
        Height = 16
        DataField = 'DS_CIDADE'
        DataSource = dsUnidade
      end
    end
  end
  object dsUnidade: TDataSource
    DataSet = dm.ADOQusina
    Left = 80
    Top = 456
  end
end
