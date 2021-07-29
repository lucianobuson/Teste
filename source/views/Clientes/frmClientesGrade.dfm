inherited frm_clientesgrade: Tfrm_clientesgrade
  Caption = 'Clientes'
  ClientWidth = 558
  OnShow = FormShow
  ExplicitWidth = 574
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Width = 558
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
    Width = 558
  end
end
