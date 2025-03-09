inherited FormRelModelo: TFormRelModelo
  Caption = 'USACUCAR - UsaFone - Modelo'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsModelo
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 168
        Caption = 'Modelos de Aparelhos'
      end
    end
    inherited rlbCabecalho: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      Font.Style = [fsBold]
      ParentFont = False
      object rllCodigo: TRLLabel
        Left = 40
        Top = 16
        Width = 56
        Height = 16
        Caption = 'C'#211'DIGO'
      end
      object rllMarca: TRLLabel
        Left = 232
        Top = 16
        Width = 48
        Height = 16
        Caption = 'MARCA'
      end
      object rllModelo: TRLLabel
        Left = 448
        Top = 16
        Width = 56
        Height = 16
        Caption = 'MODELO'
      end
    end
    inherited rlbRegistro: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.Color = clGray
      object rldbCodigo: TRLDBText
        Left = 40
        Top = 8
        Width = 80
        Height = 16
        DataField = 'CD_MODELO'
        DataSource = dsModelo
      end
      object rldbMarca: TRLDBText
        Left = 232
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_MARCA'
        DataSource = dsModelo
      end
      object rldbModelo: TRLDBText
        Left = 448
        Top = 8
        Width = 80
        Height = 16
        DataField = 'DS_MODELO'
        DataSource = dsModelo
      end
    end
  end
  object dsModelo: TDataSource
    DataSet = dm.ADOQmodelo
    Left = 80
    Top = 448
  end
  object RLExpressionParser: TRLExpressionParser
    Left = 168
    Top = 448
  end
  object rlpdPDF: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 256
    Top = 448
  end
end
