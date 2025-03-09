inherited FormSenha: TFormSenha
  Left = 482
  Top = 305
  Caption = 'USACUCAR - Usafone - Senha'
  ClientHeight = 122
  ClientWidth = 301
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited StatusBar1: TStatusBar
    Top = 103
    Width = 301
  end
  object pnlControl: TPanel
    Left = 0
    Top = 56
    Width = 297
    Height = 41
    BevelInner = bvLowered
    TabOrder = 1
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
  end
  object edtSenha: TLabeledEdit
    Left = 8
    Top = 24
    Width = 289
    Height = 24
    CharCase = ecUpperCase
    EditLabel.Width = 73
    EditLabel.Height = 16
    EditLabel.Caption = 'Nova Senha:'
    PasswordChar = '*'
    TabOrder = 2
  end
end
