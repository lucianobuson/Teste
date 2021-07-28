inherited frm_PedidosCadastro: Tfrm_PedidosCadastro
  Caption = 'Pedido'
  ClientHeight = 466
  ClientWidth = 528
  OnShow = FormShow
  ExplicitWidth = 544
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 6
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object Label2: TLabel [1]
    Left = 55
    Top = 6
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label3: TLabel [2]
    Left = 326
    Top = 6
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object Label4: TLabel [3]
    Left = 406
    Top = 6
    Width = 24
    Height = 13
    Caption = 'Total'
  end
  inherited pnlBotoes: TPanel
    Top = 48
    Width = 528
    Height = 30
    TabOrder = 4
    ExplicitTop = 48
    ExplicitWidth = 528
    ExplicitHeight = 30
    inherited btnGravar: TButton
      Top = 2
      OnClick = btnGravarClick
      ExplicitTop = 2
    end
  end
  object grdPrincipal: TStringGrid
    Left = 0
    Top = 78
    Width = 528
    Height = 306
    Align = alBottom
    BorderStyle = bsNone
    ColCount = 1
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 5
    ColWidths = (
      64)
    RowHeights = (
      18)
  end
  object edtIdCliente: TEdit
    Left = 8
    Top = 24
    Width = 41
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnExit = edtIdClienteExit
  end
  object edtNomeCliente: TEdit
    Left = 54
    Top = 24
    Width = 266
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object edtTotalPedido: TEdit
    Left = 406
    Top = 24
    Width = 74
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object pnlItem: TPanel
    Left = 0
    Top = 384
    Width = 528
    Height = 82
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object Label5: TLabel
      Left = 8
      Top = 6
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label6: TLabel
      Left = 55
      Top = 6
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label7: TLabel
      Left = 326
      Top = 6
      Width = 24
      Height = 13
      Caption = 'Qtde'
    end
    object Label8: TLabel
      Left = 422
      Top = 6
      Width = 41
      Height = 13
      Caption = '% Desc.'
    end
    object Label9: TLabel
      Left = 470
      Top = 6
      Width = 47
      Height = 13
      Caption = 'Total item'
    end
    object Label10: TLabel
      Left = 374
      Top = 6
      Width = 27
      Height = 13
      Caption = 'Pre'#231'o'
    end
    object btnGravarItem: TButton
      Left = 252
      Top = 52
      Width = 75
      Height = 25
      Caption = 'Gravar'
      TabOrder = 9
      OnClick = btnGravarItemClick
    end
    object btnIncluir: TButton
      Left = 8
      Top = 52
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 6
      OnClick = btnIncluirClick
    end
    object btnAlterar: TButton
      Left = 90
      Top = 52
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 7
      OnClick = btnAlterarClick
    end
    object btnExcluir: TButton
      Left = 171
      Top = 52
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 8
      OnClick = btnExcluirClick
    end
    object edtIdProduto: TEdit
      Left = 8
      Top = 24
      Width = 41
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      OnExit = edtIdProdutoExit
    end
    object edtNomeProduto: TEdit
      Left = 54
      Top = 24
      Width = 266
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object edtQtde: TEdit
      Left = 326
      Top = 24
      Width = 42
      Height = 21
      TabOrder = 2
      OnExit = edtQtdeExit
      OnKeyPress = edtQtdeKeyPress
    end
    object edtDesconto: TEdit
      Left = 422
      Top = 24
      Width = 42
      Height = 21
      TabOrder = 4
      OnExit = edtDescontoExit
      OnKeyPress = edtDescontoKeyPress
    end
    object edtTotalItem: TEdit
      Left = 470
      Top = 24
      Width = 50
      Height = 21
      Enabled = False
      TabOrder = 5
    end
    object edtPreco: TEdit
      Left = 374
      Top = 24
      Width = 42
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object edtID: TEdit
      Left = 470
      Top = 52
      Width = 41
      Height = 21
      NumbersOnly = True
      TabOrder = 10
      Visible = False
    end
  end
  object edtDataPedido: TMaskEdit
    Left = 326
    Top = 24
    Width = 73
    Height = 21
    EditMask = '!00/00/0000;1; '
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
    OnExit = edtDataPedidoExit
  end
end
