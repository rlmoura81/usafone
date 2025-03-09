inherited FormRelMarca: TFormRelMarca
  Caption = 'USACUCAR - UsaFone - Marca'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsMarca
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Caption = 'Marcas de Aparelhos'
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
        Left = 80
        Top = 16
        Width = 56
        Height = 16
        Caption = 'C'#211'DIGO'
      end
      object rllDescricao: TRLLabel
        Left = 360
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
        Left = 104
        Top = 8
        Width = 72
        Height = 16
        DataField = 'CD_MARCA'
        DataSource = dsMarca
      end
      object rldbDescricao: TRLDBText
        Left = 360
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_MARCA'
        DataSource = dsMarca
      end
    end
  end
  object RLExpressionParser: TRLExpressionParser
    Left = 96
    Top = 464
  end
  object rlpdPDF: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 200
    Top = 464
  end
  object dsMarca: TDataSource
    DataSet = dm.ADOQmarca
    Left = 96
    Top = 400
  end
end
