inherited frm_clientesCadastro: Tfrm_clientesCadastro
  Caption = 'Clientes'
  ClientHeight = 141
  ClientWidth = 337
  OnShow = FormShow
  ExplicitWidth = 353
  ExplicitHeight = 180
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
    Left = 9
    Top = 56
    Width = 33
    Height = 13
    Caption = 'Cidade'
  end
  object Label4: TLabel [3]
    Left = 280
    Top = 56
    Width = 13
    Height = 13
    Caption = 'UF'
  end
  inherited pnlBotoes: TPanel
    Top = 107
    Width = 337
    TabOrder = 4
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
  object edtCidade: TEdit
    Left = 8
    Top = 74
    Width = 266
    Height = 21
    TabOrder = 2
  end
  object edtUF: TEdit
    Left = 280
    Top = 74
    Width = 41
    Height = 21
    MaxLength = 2
    TabOrder = 3
  end
end
