inherited frm_clientesCadastro: Tfrm_clientesCadastro
  Caption = 'Clientes'
  ClientHeight = 101
  ClientWidth = 337
  OnShow = FormShow
  ExplicitWidth = 353
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
  inherited pnlBotoes: TPanel
    Top = 67
    Width = 337
    TabOrder = 2
    ExplicitTop = 67
    ExplicitWidth = 337
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
end
