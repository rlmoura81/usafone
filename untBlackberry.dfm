inherited FormBlackberry: TFormBlackberry
  Left = 363
  Top = 359
  Caption = 'USACUCAR - Usafone - Black Berry'
  ClientHeight = 554
  Menu = mmBlackberry
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object lblBBreg: TLabel [0]
    Left = 8
    Top = 224
    Width = 134
    Height = 16
    Caption = 'Blackberry registrados:'
  end
  object lblfunBB: TLabel [1]
    Left = 8
    Top = 0
    Width = 173
    Height = 16
    Caption = 'Funcion'#225'rios com Blackberry:'
  end
  object lblTotal: TLabel [2]
    Left = 704
    Top = 224
    Width = 36
    Height = 16
    Caption = 'Total: '
  end
  inherited StatusBar1: TStatusBar
    Top = 535
  end
  object pnlCampos: TPanel
    Left = 8
    Top = 112
    Width = 769
    Height = 57
    BevelInner = bvLowered
    TabOrder = 1
    object lblCargo: TLabel
      Left = 288
      Top = 8
      Width = 85
      Height = 16
      Caption = 'Cargo/Fun'#231#227'o:'
    end
    object lblUnidade: TLabel
      Left = 440
      Top = 8
      Width = 51
      Height = 16
      Caption = 'Unidade:'
    end
    object lblNumero: TLabel
      Left = 568
      Top = 8
      Width = 49
      Height = 16
      Caption = 'N'#250'mero:'
    end
    object lblModelo: TLabel
      Left = 696
      Top = 8
      Width = 46
      Height = 16
      Caption = 'Modelo:'
    end
    object lblFuncionario: TLabel
      Left = 8
      Top = 8
      Width = 71
      Height = 16
      Caption = 'Funcion'#225'rio:'
    end
    object edtCargo: TEdit
      Left = 288
      Top = 24
      Width = 145
      Height = 24
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 1
    end
    object edtNumero: TEdit
      Left = 568
      Top = 24
      Width = 121
      Height = 24
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 3
    end
    object edtModelo: TEdit
      Left = 696
      Top = 24
      Width = 65
      Height = 24
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 4
    end
    object edtUnidade: TEdit
      Left = 440
      Top = 24
      Width = 121
      Height = 24
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 2
    end
    object edtFuncionario: TEdit
      Left = 8
      Top = 24
      Width = 273
      Height = 24
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 0
    end
  end
  object dbgBlackberry: TDBGrid
    Left = 8
    Top = 240
    Width = 769
    Height = 241
    DataSource = dm.dsBlackberry
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnCellClick = dbgBlackberryCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DS_NOME'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_CARGO'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_USINA'
        Width = 133
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CD_NUMERO'
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CD_PIN'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CD_IMEI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_MODELO'
        Width = 94
        Visible = True
      end>
  end
  object pnlBotoes: TPanel
    Left = 8
    Top = 488
    Width = 769
    Height = 41
    BevelInner = bvLowered
    TabOrder = 4
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
    object BitBtn1: TBitBtn
      Left = 176
      Top = 8
      Width = 81
      Height = 25
      Caption = '&Relat'#243'rio'
      TabOrder = 2
      OnClick = BitBtn1Click
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
  object pnlBotoesControl: TPanel
    Left = 8
    Top = 176
    Width = 769
    Height = 41
    BevelInner = bvLowered
    TabOrder = 2
    object lblIMEI: TLabel
      Left = 8
      Top = 12
      Width = 30
      Height = 16
      Caption = 'IMEI:'
    end
    object lblPIN: TLabel
      Left = 288
      Top = 11
      Width = 25
      Height = 16
      Caption = 'PIN:'
    end
    object edtImei: TEdit
      Left = 48
      Top = 8
      Width = 233
      Height = 24
      MaxLength = 15
      TabOrder = 0
      OnExit = edtImeiExit
      OnKeyPress = edtImeiKeyPress
    end
    object edtPin: TEdit
      Left = 320
      Top = 8
      Width = 113
      Height = 24
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 1
      OnChange = edtPinChange
      OnExit = edtPinExit
      OnKeyPress = edtPinKeyPress
    end
    object btnRegistrar: TBitBtn
      Left = 440
      Top = 8
      Width = 89
      Height = 25
      Caption = '&Registrar'
      TabOrder = 2
      OnClick = btnRegistrarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btnAlterar: TBitBtn
      Left = 536
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Alterar'
      TabOrder = 3
      OnClick = btnAlterarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555775777777
        57705557757777775FF7555555555555000755555555555F777F555555555550
        87075555555555F7577F5555555555088805555555555F755F75555555555033
        805555555555F755F75555555555033B05555555555F755F75555555555033B0
        5555555555F755F75555555555033B05555555555F755F75555555555033B055
        55555555F755F75555555555033B05555555555F755F75555555555033B05555
        555555F75FF75555555555030B05555555555F7F7F75555555555000B0555555
        5555F777F7555555555501900555555555557777755555555555099055555555
        5555777755555555555550055555555555555775555555555555}
      NumGlyphs = 2
    end
    object btnExcluir: TBitBtn
      Left = 616
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Excluir'
      TabOrder = 4
      OnClick = btnExcluirClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
  end
  object dbgAgenda: TDBGrid
    Left = 8
    Top = 16
    Width = 769
    Height = 89
    DataSource = dm.dsAgenda
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
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
        Width = 581
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CD_MATRICULA'
        Width = 133
        Visible = True
      end>
  end
  object mmBlackberry: TMainMenu
    Left = 744
    Top = 496
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
