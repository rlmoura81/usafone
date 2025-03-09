inherited FormRelAgenda: TFormRelAgenda
  Left = 431
  Top = 227
  Caption = 'FormRelAgenda'
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsAgenda
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 64
        Caption = 'Agendas'
      end
    end
    inherited rlbCabecalho: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object rllUnidade: TRLLabel
        Left = 16
        Top = 16
        Width = 64
        Height = 16
        Caption = 'UNIDADE'
      end
      object rllFuncionario: TRLLabel
        Left = 128
        Top = 16
        Width = 96
        Height = 16
        Caption = 'FUNCION'#193'RIO'
      end
      object rllOperadora: TRLLabel
        Left = 392
        Top = 16
        Width = 80
        Height = 16
        Caption = 'OPERADORA'
      end
      object rllNumero: TRLLabel
        Left = 488
        Top = 16
        Width = 56
        Height = 16
        Caption = 'N'#218'MERO'
      end
      object rllAparelho: TRLLabel
        Left = 608
        Top = 16
        Width = 72
        Height = 16
        Caption = 'APARELHO'
      end
    end
    inherited rlbRegistro: TRLBand
      Height = 25
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.Color = clGray
      object rldbFuncionario: TRLDBText
        Left = 128
        Top = 8
        Width = 64
        Height = 16
        DataField = 'DS_NOME'
        DataSource = dsAgenda
      end
      object rldbOperdora: TRLDBText
        Left = 416
        Top = 8
        Width = 104
        Height = 16
        DataField = 'DS_OPERADORA'
        DataSource = dsAgenda
      end
      object rldbNumero: TRLDBText
        Left = 488
        Top = 8
        Width = 80
        Height = 16
        DataField = 'CD_NUMERO'
        DataSource = dsAgenda
      end
      object rldbModelo: TRLDBText
        Left = 608
        Top = 8
        Width = 80
        Height = 16
        DataField = 'DS_MODELO'
        DataSource = dsAgenda
      end
      object rldbUsina: TRLDBText
        Left = 16
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_USINA'
        DataSource = dsUsina
      end
    end
    inherited rlbRodape: TRLBand
      Top = 162
    end
  end
  object dsAgenda: TDataSource
    DataSet = dm.ADOQagenda
    Left = 88
    Top = 440
  end
  object RLExpressionParser: TRLExpressionParser
    Left = 176
    Top = 440
  end
  object rlpdPDF: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 272
    Top = 440
  end
  object dsUsina: TDataSource
    DataSet = dm.ADOQusina
    Left = 88
    Top = 392
  end
end
