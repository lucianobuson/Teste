inherited frm_PedidosGrade: Tfrm_PedidosGrade
  Caption = 'Pedidos'
  ClientWidth = 440
  OnShow = FormShow
  ExplicitWidth = 456
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Width = 440
    ExplicitWidth = 440
    inherited btnAtualizar: TButton
      OnClick = btnAtualizarClick
    end
    inherited btnIncluir: TButton
      OnClick = btnIncluirClick
    end
    inherited btnAlterar: TButton
      OnClick = btnAlterarClick
    end
    inherited btnExcluir: TButton
      OnClick = btnExcluirClick
    end
  end
  inherited grdPrincipal: TStringGrid
    Width = 440
    ExplicitWidth = 440
  end
end
