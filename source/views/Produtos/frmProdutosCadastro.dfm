inherited frm_ProdutosCadastro: Tfrm_ProdutosCadastro
  Caption = 'Produto'
  ClientHeight = 101
  OnShow = FormShow
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 8
    Width = 10
    Height = 13
    Caption = 'Id'
  end
  object Label2: TLabel [1]
    Left = 56
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label3: TLabel [2]
    Left = 327
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Pre'#231'o'
  end
  inherited pnlBotoes: TPanel
    Top = 67
    TabOrder = 3
    ExplicitTop = 67
    inherited btnGravar: TButton
      OnClick = btnGravarClick
    end
  end
  object edtId: TEdit
    Left = 8
    Top = 26
    Width = 41
    Height = 21
    Enabled = False
    NumbersOnly = True
    TabOrder = 0
  end
  object edtNome: TEdit
    Left = 55
    Top = 26
    Width = 266
    Height = 21
    TabOrder = 1
  end
  object edtPreco: TEdit
    Left = 327
    Top = 26
    Width = 74
    Height = 21
    TabOrder = 2
    OnKeyPress = edtPrecoKeyPress
  end
end
