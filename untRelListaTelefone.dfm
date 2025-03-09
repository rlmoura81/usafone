inherited FormRelListaTelefone: TFormRelListaTelefone
  Left = 288
  Top = 196
  Caption = 'USACUCAR - UsaFone - Lista de Telefones'
  PixelsPerInch = 96
  TextHeight = 16
  inherited rlrRelatorio: TRLReport
    DataSource = dsListaFone
    inherited rlbTitulo: TRLBand
      inherited rllTituloRelatorio: TRLLabel
        Width = 152
        Caption = 'Lista de Telefones'
      end
    end
    inherited rlbCabecalho: TRLBand
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object rldbFuncionario: TRLDBText
        Left = 40
        Top = 12
        Width = 168
        Height = 16
        DataField = 'DS_NOME'
        DataSource = dsFuncionario
        Text = 'FUNCION'#193'RIO: '
      end
      object rldbUnidade: TRLDBText
        Left = 456
        Top = 11
        Width = 144
        Height = 16
        DataField = 'DS_USINA'
        DataSource = dsUsina
        Text = 'UNIDADE: '
      end
    end
    inherited rlbRegistro: TRLBand
      Top = 162
      Height = 30
      Borders.Sides = sdCustom
      Borders.DrawBottom = True
      Borders.Color = clGray
      object rldbNome: TRLDBText
        Left = 56
        Top = 8
        Width = 64
        Height = 16
        DataField = 'DS_NOME'
        DataSource = dsListaFone
      end
      object rldbNumero: TRLDBText
        Left = 456
        Top = 8
        Width = 80
        Height = 16
        DataField = 'CD_NUMERO'
        DataSource = dsListaFone
      end
      object rldbNum: TRLDBText
        Left = 8
        Top = 8
        Width = 32
        Height = 16
        DataField = 'COL'
        DataSource = dsListaFone
      end
    end
    inherited rlbRodape: TRLBand
      Top = 192
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 137
      Width = 718
      Height = 25
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object rllDescricao: TRLLabel
        Left = 56
        Top = 8
        Width = 80
        Height = 16
        Caption = 'DESCRI'#199#195'O'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllNumero: TRLLabel
        Left = 456
        Top = 8
        Width = 56
        Height = 16
        Caption = 'N'#218'MERO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlNum: TRLLabel
        Left = 8
        Top = 8
        Width = 24
        Height = 16
        Caption = 'N'#186
      end
    end
  end
  object RLExpressionParser: TRLExpressionParser
    Left = 152
    Top = 408
  end
  object rlpPDF: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 248
    Top = 408
  end
  object dsListaFone: TDataSource
    DataSet = dm.ADOQlistafone
    Left = 64
    Top = 408
  end
  object dsFuncionario: TDataSource
    DataSet = dm.ADOQusuario
    Left = 64
    Top = 352
  end
  object dsUsina: TDataSource
    DataSet = dm.ADOQusina
    Left = 64
    Top = 296
  end
end
