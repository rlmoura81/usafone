inherited FormRelGasto: TFormRelGasto
  Left = 338
  Top = 379
  Caption = 'FormRelGasto'
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    Borders.Sides = sdCustom
    DataSource = dm.dsGasto
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 120
        Caption = 'Gastos mensais'
      end
    end
    inherited rlbCabecalho: TRLBand
      Height = 40
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.FixedBottom = True
      object rldbUsina: TRLDBText
        Left = 88
        Top = 0
        Width = 72
        Height = 16
        DataField = 'DS_USINA'
        DataSource = dm.dsUsina
      end
      object rlUnidade: TRLLabel
        Left = 16
        Top = 0
        Width = 72
        Height = 16
        Caption = 'Unidade:'
      end
      object rlNumero: TRLLabel
        Left = 16
        Top = 24
        Width = 64
        Height = 16
        Caption = 'Numero:'
      end
      object rlVlmes: TRLLabel
        Left = 232
        Top = 24
        Width = 72
        Height = 16
        Caption = 'Consumo:'
      end
      object rlFuncionario: TRLLabel
        Left = 416
        Top = 24
        Width = 104
        Height = 16
        Caption = 'Funcion'#225'rio:'
      end
      object rldbDataRef: TRLDBText
        Left = 504
        Top = 0
        Width = 112
        Height = 16
        DataField = 'DT_REFERENCIA'
        DataSource = dm.dsGasto
      end
      object rlDatavenc: TRLLabel
        Left = 416
        Top = 0
        Width = 88
        Height = 16
        Caption = 'Data ref.:'
      end
    end
    inherited rlbRegistro: TRLBand
      Top = 145
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      object rldbNumero: TRLDBText
        Left = 16
        Top = 8
        Width = 80
        Height = 16
        DataField = 'CD_NUMERO'
        DataSource = dm.dsGasto
      end
      object rldbValor: TRLDBText
        Left = 232
        Top = 8
        Width = 80
        Height = 16
        DataField = 'VL_MES'
        DataSource = dm.dsGasto
        Text = 'R$ '
      end
      object rldbNome: TRLDBText
        Left = 416
        Top = 8
        Width = 64
        Height = 16
        DataField = 'DS_NOME'
        DataSource = dm.dsGasto
      end
    end
    inherited rlbRodape: TRLBand
      Top = 177
    end
  end
  object dsGasto: TDataSource
    DataSet = dm.ADOQgasto
    Left = 112
    Top = 432
  end
  object RLExpressionParser1: TRLExpressionParser
    Left = 288
    Top = 432
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 336
    Top = 432
  end
  object dsUsina: TDataSource
    DataSet = dm.ADOQusina
    Left = 112
    Top = 472
  end
end
