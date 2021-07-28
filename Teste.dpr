program Teste;

uses
  Vcl.Forms,
  dtmDados in 'source\models\dtmDados.pas' {dtm_Dados: TDataModule},
  frmMenu in 'source\views\frmMenu.pas' {frm_Menu},
  frmAncestral in 'source\views\frmAncestral.pas' {frm_Ancestral},
  frmAncestralGrade in 'source\views\frmAncestralGrade.pas' {frm_AncestralGrade},
  frmClientesGrade in 'source\views\Clientes\frmClientesGrade.pas' {frm_clientesgrade},
  frmProdutosGrade in 'source\views\Produtos\frmProdutosGrade.pas' {frm_ProdutosGrade},
  frmPedidosGrade in 'source\views\Pedidos\frmPedidosGrade.pas' {frm_PedidosGrade},
  frmAncestralCadastro in 'source\views\frmAncestralCadastro.pas' {frm_AncestralCadastro},
  frmClientesCadastro in 'source\views\Clientes\frmClientesCadastro.pas' {frm_clientesCadastro},
  frmProdutosCadastro in 'source\views\Produtos\frmProdutosCadastro.pas' {frm_ProdutosCadastro},
  frmPedidosCadastro in 'source\views\Pedidos\frmPedidosCadastro.pas' {frm_PedidosCadastro},
  clsClientesObj in 'source\controllers\Clientes\clsClientesObj.pas',
  clsProdutosObj in 'source\controllers\Produtos\clsProdutosObj.pas',
  clsPedidosObj in 'source\controllers\Pedidos\clsPedidosObj.pas',
  clsItensOBJ in 'source\controllers\Pedidos\clsItensOBJ.pas',
  clsModel in 'source\models\clsModel.pas',
  clsclientesModel in 'source\models\Clientes\clsclientesModel.pas',
  clsProdutosModel in 'source\models\Produtos\clsProdutosModel.pas',
  clsPedidosModel in 'source\models\Pedidos\clsPedidosModel.pas',
  clsItensModel in 'source\models\Pedidos\clsItensModel.pas',
  clsClientesController in 'source\controllers\Clientes\clsClientesController.pas',
  clsProdutosController in 'source\controllers\Produtos\clsProdutosController.pas',
  clsPedidosController in 'source\controllers\Pedidos\clsPedidosController.pas',
  clsItensController in 'source\controllers\Pedidos\clsItensController.pas',
  clsClientesModelNOVO in 'source\models\Clientes\clsClientesModelNOVO.pas',
  clsModel2 in 'source\models\clsModel2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Menu, frm_Menu);
  Application.CreateForm(Tdtm_Dados, dtm_Dados);
  Application.Run;
end.
