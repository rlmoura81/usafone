inherited FormRelChip: TFormRelChip
  Caption = 'USACUCAR - UsaFone - Relatorio de CHIPs'
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsCHIP
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 216
        Caption = 'CHIP (N'#250'meros de telefone)'
      end
    end
    inherited rlbCabecalho: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object rllUnidade: TRLLabel
        Left = 24
        Top = 16
        Width = 64
        Height = 16
        Caption = 'UNIDADE'
      end
      object rllNumero: TRLLabel
        Left = 144
        Top = 16
        Width = 56
        Height = 16
        Caption = 'N'#218'MERO'
      end
      object rllIMEI: TRLLabel
        Left = 320
        Top = 16
        Width = 40
        Height = 16
        Caption = 'IMEI'
      end
      object rllPin2: TRLLabel
        Left = 488
        Top = 16
        Width = 40
        Height = 16
        Caption = 'PIN2'
      end
      object RLLOperadora: TRLLabel
        Left = 576
        Top = 16
        Width = 80
        Height = 16
        Caption = 'OPERADORA'
      end
      object RLLabel1: TRLLabel
        Left = 680
        Top = 15
        Width = 24
        Height = 16
        Caption = 'ST'
      end
    end
    inherited rlbRegistro: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.Color = clGray
      object rldbUsina: TRLDBText
        Left = 24
        Top = 16
        Width = 72
        Height = 16
        DataField = 'DS_USINA'
        DataSource = dsCHIP
      end
      object rldbNumero: TRLDBText
        Left = 136
        Top = 16
        Width = 80
        Height = 16
        DataField = 'CD_NUMERO'
        DataSource = dsCHIP
      end
      object rldbIMEI: TRLDBText
        Left = 264
        Top = 16
        Width = 64
        Height = 16
        DataField = 'CD_IMEI'
        DataSource = dsCHIP
      end
      object rldbPin2: TRLDBText
        Left = 488
        Top = 16
        Width = 64
        Height = 16
        DataField = 'CD_PIN2'
        DataSource = dsCHIP
      end
      object rldbOperadora: TRLDBText
        Left = 576
        Top = 16
        Width = 104
        Height = 16
        DataField = 'DS_OPERADORA'
        DataSource = dsCHIP
      end
      object rldbST: TRLDBText
        Left = 680
        Top = 16
        Width = 64
        Height = 16
        DataField = 'ST_CHIP'
        DataSource = dm.dsChip
      end
    end
  end
  object dsCHIP: TDataSource
    DataSet = dm.ADOQchip
    Left = 112
    Top = 408
  end
  object RLExpressionParser: TRLExpressionParser
    Left = 208
    Top = 408
  end
  object rlpdPDF: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 304
    Top = 408
  end
end
