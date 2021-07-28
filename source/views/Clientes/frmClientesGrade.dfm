inherited frm_clientesgrade: Tfrm_clientesgrade
  Caption = 'Clientes'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    ExplicitTop = 236
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
end
