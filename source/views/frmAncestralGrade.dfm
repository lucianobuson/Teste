inherited frm_AncestralGrade: Tfrm_AncestralGrade
  ClientHeight = 270
  ExplicitHeight = 309
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 236
    ExplicitTop = 236
    object btnAtualizar: TButton
      Left = 252
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Atualizar'
      TabOrder = 3
    end
    object btnIncluir: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
    end
    object btnAlterar: TButton
      Left = 90
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
    end
    object btnExcluir: TButton
      Left = 171
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
    end
  end
  object grdPrincipal: TStringGrid
    Left = 0
    Top = 0
    Width = 418
    Height = 236
    Align = alClient
    BorderStyle = bsNone
    ColCount = 1
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 1
    ColWidths = (
      64)
    RowHeights = (
      18)
  end
end
