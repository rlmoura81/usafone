inherited FormUsuario: TFormUsuario
  Caption = 'USACUCAR - Usafone - Usu'#225'rio'
  ClientHeight = 554
  Menu = mmUsuario
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited StatusBar1: TStatusBar
    Top = 535
  end
  object dbgUsuario: TDBGrid
    Left = 8
    Top = 8
    Width = 770
    Height = 400
    DataSource = dm.dsUsuario
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnCellClick = dbgUsuarioCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CD_MATRICULA'
        Width = 111
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_NOME'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_CARGO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_USINA'
        Width = 90
        Visible = True
      end>
  end
  object pnlCampos: TPanel
    Left = 8
    Top = 416
    Width = 770
    Height = 65
    BevelInner = bvLowered
    TabOrder = 1
    object lblUnidade: TLabel
      Left = 11
      Top = 13
      Width = 51
      Height = 16
      Caption = 'Unidade:'
    end
    object edtMatricula: TLabeledEdit
      Left = 160
      Top = 32
      Width = 73
      Height = 24
      EditLabel.Width = 57
      EditLabel.Height = 16
      EditLabel.Caption = 'Matricula:'
      TabOrder = 1
      OnExit = edtMatriculaExit
      OnKeyPress = edtMatriculaKeyPress
    end
    object edtNome: TLabeledEdit
      Left = 240
      Top = 32
      Width = 265
      Height = 24
      CharCase = ecUpperCase
      EditLabel.Width = 38
      EditLabel.Height = 16
      EditLabel.Caption = 'Nome:'
      TabOrder = 2
      OnKeyPress = edtNomeKeyPress
    end
    object edtCargo: TLabeledEdit
      Left = 512
      Top = 32
      Width = 250
      Height = 24
      CharCase = ecUpperCase
      EditLabel.Width = 85
      EditLabel.Height = 16
      EditLabel.Caption = 'Cargo/Fun'#231#227'o:'
      TabOrder = 3
      OnKeyPress = edtCargoKeyPress
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
  end
  object pnlControl: TPanel
    Left = 8
    Top = 488
    Width = 770
    Height = 41
    BevelInner = bvLowered
    TabOrder = 2
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
    object edtLocalizarUsuario: TEdit
      Left = 256
      Top = 8
      Width = 249
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 3
      OnKeyPress = edtLocalizarUsuarioKeyPress
    end
    object btnLocalizar: TBitBtn
      Left = 512
      Top = 8
      Width = 81
      Height = 25
      Caption = '&Localizar'
      TabOrder = 4
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
  object mmUsuario: TMainMenu
    Left = 744
    Top = 488
    object Voltar1: TMenuItem
      Caption = '&Voltar'
      OnClick = Voltar1Click
    end
    object Novo1: TMenuItem
      Caption = '&Novo'
      OnClick = Novo1Click
    end
  end
end
