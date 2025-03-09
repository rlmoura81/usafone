inherited FormAparelhos: TFormAparelhos
  Caption = 'USACUCAR - Usafone - Aparelhos'
  ClientHeight = 554
  Menu = mmAparelhos
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited StatusBar1: TStatusBar
    Top = 535
  end
  object pnlCampos: TPanel
    Left = 8
    Top = 8
    Width = 770
    Height = 57
    BevelInner = bvLowered
    TabOrder = 1
    object lblMarca: TLabel
      Left = 194
      Top = 6
      Width = 40
      Height = 16
      Caption = 'Marca:'
    end
    object lblModelo: TLabel
      Left = 371
      Top = 6
      Width = 46
      Height = 16
      Caption = 'Modelo:'
    end
    object lblQuantidade: TLabel
      Left = 591
      Top = 6
      Width = 70
      Height = 16
      Caption = 'Quantidade:'
    end
    object lblDataNF: TLabel
      Left = 679
      Top = 6
      Width = 52
      Height = 16
      Caption = 'Data NF:'
    end
    object lblOperadora: TLabel
      Left = 82
      Top = 6
      Width = 60
      Height = 16
      Caption = 'Operadora'
    end
    object edtCodigo: TLabeledEdit
      Left = 8
      Top = 24
      Width = 65
      Height = 24
      Color = clBtnFace
      EditLabel.Width = 44
      EditLabel.Height = 16
      EditLabel.Caption = 'C'#243'digo:'
      ReadOnly = True
      TabOrder = 0
    end
    object dbcbMarca: TDBLookupComboBox
      Left = 192
      Top = 24
      Width = 169
      Height = 24
      KeyField = 'CD_MARCA'
      ListField = 'DS_MARCA'
      ListSource = dm.dsMarca
      TabOrder = 2
      OnClick = dbcbMarcaClick
      OnExit = dbcbMarcaExit
      OnKeyPress = dbcbMarcaKeyPress
    end
    object dbcbModelo: TDBLookupComboBox
      Left = 368
      Top = 24
      Width = 217
      Height = 24
      KeyField = 'CD_MODELO'
      ListField = 'DS_MODELO'
      ListSource = dm.dsModelo
      TabOrder = 3
      OnKeyPress = dbcbModeloKeyPress
    end
    object edtQuantidade: TEdit
      Left = 592
      Top = 24
      Width = 81
      Height = 24
      TabOrder = 4
      OnExit = edtQuantidadeExit
      OnKeyPress = edtQuantidadeKeyPress
    end
    object mkEditDataNF: TMaskEdit
      Left = 681
      Top = 24
      Width = 74
      Height = 24
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
    end
    object dbcbOperadora: TDBLookupComboBox
      Left = 80
      Top = 24
      Width = 105
      Height = 24
      KeyField = 'CD_OPERADORA'
      ListField = 'DS_OPERADORA'
      ListSource = dm.dsOperadora
      TabOrder = 1
      OnClick = dbcbOperadoraClick
      OnKeyPress = dbcbOperadoraKeyPress
    end
  end
  object pnlControl: TPanel
    Left = 8
    Top = 72
    Width = 770
    Height = 41
    BevelInner = bvLowered
    TabOrder = 2
    object btnInserir: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Inserir'
      TabOrder = 0
      OnClick = btnInserirClick
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
    object btnExcluirAparelho: TBitBtn
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Excluir'
      TabOrder = 2
      OnClick = btnExcluirAparelhoClick
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
    object btnAlterar: TBitBtn
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Alterar'
      TabOrder = 1
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
  end
  object dbgAparelhos: TDBGrid
    Left = 8
    Top = 120
    Width = 770
    Height = 360
    DataSource = dm.dsAparelho
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnCellClick = dbgAparelhosCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DS_MARCA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DS_MODELO'
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
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DT_DATA'
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
    object btnExcluir: TBitBtn
      Left = 88
      Top = 8
      Width = 81
      Height = 25
      Caption = '&Cancelar'
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
      Left = 176
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
  end
  object mmAparelhos: TMainMenu
    Left = 736
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
