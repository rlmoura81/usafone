inherited FormEstoque: TFormEstoque
  Left = 313
  Top = 110
  Caption = 'USACUCAR - Usafone - Estoque'
  ClientHeight = 554
  Menu = mmEstoque
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited StatusBar1: TStatusBar
    Top = 535
  end
  object pnlCampos: TPanel
    Left = 8
    Top = 360
    Width = 770
    Height = 57
    BevelInner = bvLowered
    TabOrder = 1
    object lblDtNF: TLabel
      Left = 651
      Top = 6
      Width = 48
      Height = 16
      Caption = 'Data NF'
    end
    object edtCodigo: TLabeledEdit
      Left = 8
      Top = 24
      Width = 65
      Height = 24
      Color = cl3DLight
      EditLabel.Width = 40
      EditLabel.Height = 16
      EditLabel.Caption = 'C'#243'digo'
      ReadOnly = True
      TabOrder = 0
    end
    object edtOperadora: TLabeledEdit
      Left = 80
      Top = 24
      Width = 121
      Height = 24
      Color = cl3DLight
      EditLabel.Width = 60
      EditLabel.Height = 16
      EditLabel.Caption = 'Operadora'
      ReadOnly = True
      TabOrder = 1
    end
    object edtMarca: TLabeledEdit
      Left = 208
      Top = 24
      Width = 121
      Height = 24
      Color = cl3DLight
      EditLabel.Width = 36
      EditLabel.Height = 16
      EditLabel.Caption = 'Marca'
      ReadOnly = True
      TabOrder = 2
    end
    object edtModelo: TLabeledEdit
      Left = 336
      Top = 24
      Width = 121
      Height = 24
      Color = cl3DLight
      EditLabel.Width = 42
      EditLabel.Height = 16
      EditLabel.Caption = 'Modelo'
      ReadOnly = True
      TabOrder = 3
    end
    object edtQtde: TLabeledEdit
      Left = 464
      Top = 24
      Width = 73
      Height = 24
      Color = cl3DLight
      EditLabel.Width = 66
      EditLabel.Height = 16
      EditLabel.Caption = 'Quantidade'
      ReadOnly = True
      TabOrder = 4
    end
    object edtNumNF: TLabeledEdit
      Left = 544
      Top = 24
      Width = 97
      Height = 24
      Color = cl3DLight
      EditLabel.Width = 66
      EditLabel.Height = 16
      EditLabel.Caption = 'Nota Fiscal'
      ReadOnly = True
      TabOrder = 5
    end
    object edtData: TMaskEdit
      Left = 648
      Top = 24
      Width = 105
      Height = 24
      Color = cl3DLight
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 6
      Text = '  /  /    '
    end
  end
  object dbgEstoque: TDBGrid
    Left = 8
    Top = 8
    Width = 770
    Height = 337
    DataSource = dm.dsAparelho
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnCellClick = dbgEstoqueCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DS_MARCA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_MODELO'
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_OPERADORA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDE'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOTA_FISCAL'
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DT_DATA'
        Width = 82
        Visible = True
      end>
  end
  object pnlControlGeral: TPanel
    Left = 8
    Top = 488
    Width = 770
    Height = 41
    BevelInner = bvLowered
    TabOrder = 3
    object btnGravar: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
    end
    object btnCancelar: TBitBtn
      Left = 88
      Top = 8
      Width = 81
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        555557777F777555F55500000000555055557777777755F75555005500055055
        555577F5777F57555555005550055555555577FF577F5FF55555500550050055
        5555577FF77577FF555555005050110555555577F757777FF555555505099910
        555555FF75777777FF555005550999910555577F5F77777775F5500505509990
        3055577F75F77777575F55005055090B030555775755777575755555555550B0
        B03055555F555757575755550555550B0B335555755555757555555555555550
        BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
        50BB555555555555575F555555555555550B5555555555555575}
      NumGlyphs = 2
    end
    object btnRelatorio: TBitBtn
      Left = 176
      Top = 8
      Width = 81
      Height = 25
      Caption = '&Relatorio'
      TabOrder = 2
      OnClick = btnRelatorioClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
  end
  object pnlControl: TPanel
    Left = 8
    Top = 424
    Width = 770
    Height = 57
    BevelInner = bvLowered
    TabOrder = 4
    object lblDtRetirada: TLabel
      Left = 107
      Top = 6
      Width = 96
      Height = 16
      Caption = 'Data da retirada:'
    end
    object lblUsuarioRetirada: TLabel
      Left = 235
      Top = 6
      Width = 74
      Height = 16
      Caption = 'Retirado por:'
    end
    object edtQtdeRetirada: TLabeledEdit
      Left = 8
      Top = 24
      Width = 89
      Height = 24
      EditLabel.Width = 80
      EditLabel.Height = 16
      EditLabel.Caption = 'Qtde a retirar:'
      TabOrder = 0
      OnExit = edtQtdeRetiradaExit
      OnKeyPress = edtQtdeRetiradaKeyPress
    end
    object edtDataRetirada: TMaskEdit
      Left = 104
      Top = 24
      Width = 120
      Height = 24
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnKeyPress = edtDataRetiradaKeyPress
    end
    object dbcbUsuario: TDBLookupComboBox
      Left = 232
      Top = 24
      Width = 145
      Height = 24
      KeyField = 'CD_MATRICULA'
      ListField = 'DS_NOME'
      ListSource = dm.dsAcesso
      TabOrder = 2
      OnKeyPress = dbcbUsuarioKeyPress
    end
    object btnRegistrar: TBitBtn
      Left = 384
      Top = 24
      Width = 89
      Height = 25
      Caption = '&Registrar'
      TabOrder = 3
      OnClick = btnRegistrarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
        055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
        305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
        30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
        3055577777555557F7F555000555555999555577755555577755}
      NumGlyphs = 2
    end
  end
  object mmEstoque: TMainMenu
    Left = 744
    Top = 496
    object Voltar1: TMenuItem
      Caption = '&Voltar'
      OnClick = Voltar1Click
    end
  end
  object dsAparelhos: TDataSource
    DataSet = dm.ADOQaparelho
    Left = 672
    Top = 496
  end
end
