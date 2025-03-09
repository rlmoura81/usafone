inherited FormAgenda: TFormAgenda
  Left = 278
  Top = 210
  Caption = 'USACUCAR - Usafone - Agenda'
  ClientHeight = 554
  Menu = mmAgenda
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited StatusBar1: TStatusBar
    Top = 535
  end
  object pnlCamposFuncionario: TPanel
    Left = 8
    Top = 8
    Width = 770
    Height = 65
    BevelInner = bvLowered
    TabOrder = 1
    object lblFuncionario: TLabel
      Left = 162
      Top = 13
      Width = 71
      Height = 16
      Caption = 'Funcion'#225'rio:'
    end
    object lblUnidade: TLabel
      Left = 11
      Top = 13
      Width = 51
      Height = 16
      Caption = 'Unidade:'
    end
    object lblNumero: TLabel
      Left = 626
      Top = 14
      Width = 49
      Height = 16
      Caption = 'N'#250'mero:'
    end
    object lblOperadoraChip: TLabel
      Left = 547
      Top = 13
      Width = 64
      Height = 16
      Caption = 'Operadora:'
    end
    object dbcbFuncionario: TDBLookupComboBox
      Left = 160
      Top = 32
      Width = 377
      Height = 24
      KeyField = 'CD_MATRICULA'
      ListField = 'DS_NOME'
      ListSource = dm.dsUsuario
      TabOrder = 1
      OnClick = dbcbFuncionarioClick
      OnKeyPress = dbcbFuncionarioKeyPress
    end
    object dbcbUnidade: TDBLookupComboBox
      Left = 8
      Top = 32
      Width = 145
      Height = 24
      KeyField = 'CD_USINA'
      ListField = 'DS_USINA'
      ListSource = dm.dsUsina
      TabOrder = 0
      OnClick = dbcbUnidadeClick
      OnKeyPress = dbcbUnidadeKeyPress
    end
    object dbcbNumero: TDBLookupComboBox
      Left = 624
      Top = 32
      Width = 105
      Height = 24
      KeyField = 'CD_NUMERO'
      ListField = 'CD_NUMERO'
      ListSource = dm.dsChip
      TabOrder = 3
      OnClick = dbcbNumeroClick
      OnKeyPress = dbcbNumeroKeyPress
    end
    object dbcbOperadoraChip: TDBLookupComboBox
      Left = 544
      Top = 32
      Width = 73
      Height = 24
      KeyField = 'CD_OPERADORA'
      ListField = 'DS_OPERADORA'
      ListSource = dm.dsOperadora
      TabOrder = 2
      OnClick = dbcbOperadoraChipClick
      OnKeyPress = dbcbOperadoraChipKeyPress
    end
  end
  object dbgAgenda: TDBGrid
    Left = 8
    Top = 136
    Width = 769
    Height = 345
    DataSource = dm.dsAgenda
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnCellClick = dbgAgendaCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DS_NOME'
        Width = 236
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CD_NUMERO'
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CD_PIN2'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_OPERADORA'
        Width = 132
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_MARCA'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_MODELO'
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CD_USINA'
        Width = 77
        Visible = True
      end>
  end
  object pnlControl: TPanel
    Left = 8
    Top = 488
    Width = 769
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
    object btnExcluir: TBitBtn
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Excluir'
      TabOrder = 1
      OnClick = btnExcluirClick
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
      Left = 168
      Top = 8
      Width = 81
      Height = 25
      Caption = '&Relat'#243'rio'
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
    object btnVerlista: TBitBtn
      Left = 256
      Top = 8
      Width = 89
      Height = 25
      Caption = 'Ver Lista'
      TabOrder = 3
      OnClick = btnVerlistaClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
        00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
        00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
        F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
        F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
        FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
        0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
        00337777FFFF77FF7733EEEE0000000003337777777777777333}
      NumGlyphs = 2
    end
    object edtLocalizarUsuario: TEdit
      Left = 352
      Top = 8
      Width = 321
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 4
      OnKeyPress = edtLocalizarUsuarioKeyPress
    end
    object btnLocalizar: TBitBtn
      Left = 680
      Top = 8
      Width = 83
      Height = 25
      Caption = '&Localizar'
      TabOrder = 5
      OnClick = btnLocalizarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
  end
  object pnlCamposAparelho: TPanel
    Left = 8
    Top = 75
    Width = 345
    Height = 55
    BevelInner = bvLowered
    TabOrder = 4
    object lblAparelho: TLabel
      Left = 236
      Top = 6
      Width = 55
      Height = 16
      Caption = 'Aparelho:'
    end
    object lblOperadoraAparelho: TLabel
      Left = 11
      Top = 6
      Width = 64
      Height = 16
      Caption = 'Operadora:'
    end
    object lblMarca: TLabel
      Left = 87
      Top = 6
      Width = 40
      Height = 16
      Caption = 'Marca:'
    end
    object dbcbAparelho: TDBLookupComboBox
      Left = 233
      Top = 26
      Width = 105
      Height = 24
      KeyField = 'CD_APARELHO'
      ListField = 'DS_MODELO'
      ListSource = dm.dsAparelho
      TabOrder = 0
      OnKeyPress = dbcbAparelhoKeyPress
    end
    object dbcbMarca: TDBLookupComboBox
      Left = 85
      Top = 26
      Width = 145
      Height = 24
      KeyField = 'CD_MARCA'
      ListField = 'DS_MARCA'
      ListSource = dm.dsMarca
      TabOrder = 1
      OnClick = dbcbMarcaClick
      OnKeyPress = dbcbMarcaKeyPress
    end
    object dbcbOperadoraAparelho: TDBLookupComboBox
      Left = 8
      Top = 26
      Width = 73
      Height = 24
      KeyField = 'CD_OPERADORA'
      ListField = 'DS_OPERADORA'
      ListSource = dm.dsOperadora
      TabOrder = 2
      OnClick = dbcbOperadoraAparelhoClick
      OnKeyPress = dbcbOperadoraAparelhoKeyPress
    end
  end
  object Panel1: TPanel
    Left = 360
    Top = 75
    Width = 418
    Height = 55
    BevelInner = bvLowered
    TabOrder = 5
    object Label1: TLabel
      Left = 96
      Top = 8
      Width = 101
      Height = 16
      Caption = 'Funcion'#225'rio novo:'
    end
    object btnTransferir: TBitBtn
      Left = 8
      Top = 24
      Width = 81
      Height = 25
      Caption = 'Tranferir'
      TabOrder = 0
      OnClick = btnTransferirClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
        00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
        70E337F3333F333337F3E0F33303333370E337F3337FF33337F3E0F333003333
        70E337F33377FF3337F3E0F33300033370E337F333777FF337F3E0F333000033
        70E337F33377773337F3E0F33300033370E337F33377733337F3E0F333003333
        70E337F33377333337F3E0F33303333370E337F33373333337F3E0F333333333
        70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
        00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
      NumGlyphs = 2
    end
    object dbcbFuncionarioTransferencia: TDBLookupComboBox
      Left = 96
      Top = 24
      Width = 313
      Height = 24
      KeyField = 'CD_MATRICULA'
      ListField = 'DS_NOME'
      ListSource = dm.dsUsuario
      TabOrder = 1
    end
  end
  object mmAgenda: TMainMenu
    Left = 728
    Top = 440
    object Voltar1: TMenuItem
      Caption = '&Voltar'
      OnClick = Voltar1Click
    end
  end
end
