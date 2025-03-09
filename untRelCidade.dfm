inherited FormRelCidade: TFormRelCidade
  Caption = 'USACUCAR - Usafone - Relatorio de Cidades'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsCidade
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 64
        Caption = 'Cidades'
      end
    end
    inherited rlbCabecalho: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      object rllCodigo: TRLLabel
        Left = 16
        Top = 8
        Width = 56
        Height = 16
        Caption = 'C'#211'DIGO'
      end
      object rllCidade: TRLLabel
        Left = 170
        Top = 8
        Width = 56
        Height = 16
        Caption = 'CIDADE'
      end
      object rllEstado: TRLLabel
        Left = 496
        Top = 8
        Width = 56
        Height = 16
        Caption = 'ESTADO'
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
        DataField = 'CD_CIDADE'
        DataSource = dsCidade
      end
      object rldbCidade: TRLDBText
        Left = 168
        Top = 8
        Width = 80
        Height = 16
        DataField = 'DS_CIDADE'
        DataSource = dsCidade
      end
      object rldbEstado: TRLDBText
        Left = 512
        Top = 8
        Width = 80
        Height = 16
        DataField = 'DS_ESTADO'
        DataSource = dsCidade
      end
    end
  end
  object RLExpressionParser: TRLExpressionParser
    Left = 168
    Top = 456
  end
  object rlpdPDF: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 264
    Top = 456
  end
  object dsCidade: TDataSource
    DataSet = dm.ADOQcidade
    Left = 72
    Top = 456
  end
end
