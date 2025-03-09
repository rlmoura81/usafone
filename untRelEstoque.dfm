inherited FormRelEstoque: TFormRelEstoque
  Caption = 'USACUCAR - Usafone - Relatorio de movimenta'#231#227'o do estoque'
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsEstoque
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 296
        Caption = 'Movimenta'#231#227'o do estoque de aparelhos'
      end
    end
    inherited rlbCabecalho: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object rllUsuario: TRLLabel
        Left = 16
        Top = 16
        Width = 64
        Height = 16
        Caption = 'USU'#193'RIO'
      end
      object rllMarca: TRLLabel
        Left = 224
        Top = 16
        Width = 48
        Height = 16
        Caption = 'MARCA'
      end
      object rllModelo: TRLLabel
        Left = 360
        Top = 16
        Width = 56
        Height = 16
        Caption = 'MODELO'
      end
      object rllQtde: TRLLabel
        Left = 496
        Top = 16
        Width = 40
        Height = 16
        Caption = 'QTDE'
      end
      object rllData: TRLLabel
        Left = 616
        Top = 16
        Width = 40
        Height = 16
        Caption = 'DATA'
      end
    end
    inherited rlbRegistro: TRLBand
      Height = 24
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.Color = clGray
      object rldbUsuario: TRLDBText
        Left = 16
        Top = 8
        Width = 64
        Height = 16
        DataField = 'DS_NOME'
        DataSource = dm.dsEstoque
      end
      object rldbMarca: TRLDBText
        Left = 224
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_MARCA'
        DataSource = dm.dsEstoque
      end
      object rldbModelo: TRLDBText
        Left = 360
        Top = 8
        Width = 80
        Height = 16
        DataField = 'DS_MODELO'
        DataSource = dm.dsEstoque
      end
      object rldbQtde: TRLDBText
        Left = 512
        Top = 8
        Width = 40
        Height = 16
        DataField = 'QTDE'
        DataSource = dm.dsEstoque
      end
      object rldbData: TRLDBText
        Left = 608
        Top = 8
        Width = 64
        Height = 16
        DataField = 'DS_DATA'
        DataSource = dm.dsEstoque
      end
    end
    inherited rlbRodape: TRLBand
      Top = 161
    end
  end
  object dsEstoque: TDataSource
    DataSet = dm.ADOQestoque
    Left = 152
    Top = 496
  end
  object RLExpressionParser: TRLExpressionParser
    Left = 264
    Top = 496
  end
  object rlPDF: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 352
    Top = 496
  end
end
