inherited FormRelAparelhos: TFormRelAparelhos
  Caption = 'USACUCAR - UsaFone - Relatorio de Aparelhos'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsAparelho
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Caption = 'Aparelhos Celulares'
      end
    end
    inherited rlbCabecalho: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      Font.Style = [fsBold]
      ParentFont = False
      object rllMarca: TRLLabel
        Left = 184
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
      object rllOperadora: TRLLabel
        Left = 24
        Top = 16
        Width = 80
        Height = 16
        Caption = 'OPERADORA'
      end
      object rllQtde: TRLLabel
        Left = 608
        Top = 16
        Width = 88
        Height = 16
        Caption = 'QUANTIDADE'
      end
    end
    inherited rlbRegistro: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.Color = clGray
      object rldbMarca: TRLDBText
        Left = 184
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_MARCA'
        DataSource = dsAparelho
      end
      object rldbModelo: TRLDBText
        Left = 448
        Top = 8
        Width = 80
        Height = 16
        DataField = 'DS_MODELO'
        DataSource = dsAparelho
      end
      object rldbOperadora: TRLDBText
        Left = 24
        Top = 8
        Width = 104
        Height = 16
        DataField = 'DS_OPERADORA'
        DataSource = dsAparelho
      end
      object rldbQtde: TRLDBText
        Left = 632
        Top = 8
        Width = 40
        Height = 16
        DataField = 'QTDE'
        DataSource = dsAparelho
      end
    end
  end
  object RLExpressionParser: TRLExpressionParser
    Left = 176
    Top = 408
  end
  object rlPDF: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 272
    Top = 408
  end
  object dsAparelho: TDataSource
    DataSet = dm.ADOQaparelho
    Left = 88
    Top = 408
  end
end
