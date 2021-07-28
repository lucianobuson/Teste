inherited frm_ProdutosGrade: Tfrm_ProdutosGrade
  Caption = 'Produtos'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
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
