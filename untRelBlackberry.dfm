inherited FormRelBlackberry: TFormRelBlackberry
  Left = 333
  Top = 302
  Caption = 'USACUCAR - Blackberry'
  ClientHeight = 518
  ClientWidth = 790
  PixelsPerInch = 96
  TextHeight = 16
  inherited StatusBar1: TStatusBar
    Top = 499
    Width = 790
  end
  inherited rlrRelatorio: TRLReport
    Width = 1123
    Height = 794
    DataSource = dm.dsBlackberry
    PageSetup.Orientation = poLandscape
    inherited rlbTitulo: TRLBand
      Width = 1047
      inherited rlsData: TRLSystemInfo
        Left = 896
        Width = 136
      end
      inherited rllTituloRelatorio: TRLLabel
        Width = 96
        Caption = 'Black Berry'
      end
    end
    inherited rlbCabecalho: TRLBand
      Width = 1047
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.FixedBottom = True
      object rlFuncionario: TRLLabel
        Left = 48
        Top = 8
        Width = 104
        Height = 16
        Caption = 'Funcion'#225'rio:'
      end
      object rlCargo: TRLLabel
        Left = 344
        Top = 8
        Width = 56
        Height = 16
        Caption = 'Cargo:'
      end
      object rlNumero: TRLLabel
        Left = 632
        Top = 8
        Width = 64
        Height = 16
        Caption = 'N'#250'mero:'
      end
      object rlPin: TRLLabel
        Left = 744
        Top = 8
        Width = 40
        Height = 16
        Caption = 'PIN:'
      end
      object rlImei: TRLLabel
        Left = 832
        Top = 8
        Width = 48
        Height = 16
        Caption = 'IMEI:'
      end
      object rlModelo: TRLLabel
        Left = 968
        Top = 8
        Width = 64
        Height = 16
        Caption = 'Modelo:'
      end
      object rlUnidade: TRLLabel
        Left = 512
        Top = 8
        Width = 72
        Height = 16
        Caption = 'Unidade:'
      end
      object rlNum: TRLLabel
        Left = 8
        Top = 8
        Width = 32
        Height = 16
        Caption = 'N'#186':'
      end
    end
    inherited rlbRegistro: TRLBand
      Width = 1047
      Height = 24
      object rldbFuncionario: TRLDBText
        Left = 48
        Top = 8
        Width = 64
        Height = 16
        DataField = 'DS_NOME'
        DataSource = dm.dsBlackberry
      end
      object rldbCargo: TRLDBText
        Left = 344
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_CARGO'
        DataSource = dm.dsBlackberry
      end
      object rldbNumero: TRLDBText
        Left = 632
        Top = 8
        Width = 80
        Height = 16
        DataField = 'CD_NUMERO'
        DataSource = dm.dsBlackberry
      end
      object rldbPin: TRLDBText
        Left = 744
        Top = 8
        Width = 56
        Height = 16
        DataField = 'CD_PIN'
        DataSource = dm.dsBlackberry
      end
      object rldbImei: TRLDBText
        Left = 832
        Top = 8
        Width = 64
        Height = 16
        DataField = 'CD_IMEI'
        DataSource = dm.dsBlackberry
      end
      object rldbModelo: TRLDBText
        Left = 968
        Top = 8
        Width = 80
        Height = 16
        DataField = 'DS_MODELO'
        DataSource = dm.dsBlackberry
      end
      object rldbUnidade: TRLDBText
        Left = 512
        Top = 8
        Width = 72
        Height = 16
        DataField = 'DS_USINA'
        DataSource = dm.dsBlackberry
      end
      object rldbNum: TRLDBText
        Left = 8
        Top = 8
        Width = 32
        Height = 16
        DataField = 'COL'
        DataSource = dm.dsBlackberry
      end
    end
    inherited rlbRodape: TRLBand
      Top = 161
      Width = 1047
      inherited rllRodape: TRLLabel
        Left = 8
      end
      inherited rlsPag: TRLSystemInfo
        Left = 910
      end
    end
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 416
    Top = 344
  end
  object RLExpressionParser1: TRLExpressionParser
    Left = 464
    Top = 344
  end
end
