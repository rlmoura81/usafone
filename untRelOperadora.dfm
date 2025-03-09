inherited FormRelOperadora: TFormRelOperadora
  Caption = 'USAFONE - UsaFone - Operadora'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsOperadora
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 192
        Caption = 'Operadoras de Telefonia'
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
      object rllDescircao: TRLLabel
        Left = 304
        Top = 16
        Width = 80
        Height = 16
        Caption = 'DESCRI'#199#195'O'
      end
    end
    inherited rlbRegistro: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.Color = clGray
      object rldbCodigo: TRLDBText
        Left = 64
        Top = 9
        Width = 104
        Height = 16
        DataField = 'CD_OPERADORA'
        DataSource = dsOperadora
      end
      object rldbDescricao: TRLDBText
        Left = 304
        Top = 8
        Width = 104
        Height = 16
        DataField = 'DS_OPERADORA'
        DataSource = dsOperadora
      end
    end
  end
  object dsOperadora: TDataSource
    DataSet = dm.ADOQoperadora
    Left = 112
    Top = 456
  end
  object RLExpressionParser: TRLExpressionParser
    Left = 216
    Top = 456
  end
  object rlpdPDF: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 312
    Top = 456
  end
end
