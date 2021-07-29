unit frmPedidosCadastro;

interface

uses
    clsProdutosController,
    clsProdutosObj,
    clsClientesController,
    clsClientesObj,

    clsPedidosController,
    clsPedidosObj,

    clsItensController,
    clsItensObj,
    frmAncestralCadastro,
    Winapi.Windows, Winapi.Messages,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.Mask,
    System.Contnrs,
    System.SysUtils, System.Variants, System.Classes;

type
    Tfrm_PedidosCadastro = class(Tfrm_AncestralCadastro)
        grdPrincipal: TStringGrid;
        Label1: TLabel;
        Label2: TLabel;
        edtIdCliente: TEdit;
        edtNomeCliente: TEdit;
        Label3: TLabel;
        Label4: TLabel;
        edtTotalPedido: TEdit;
        pnlItem: TPanel;
        btnGravarItem: TButton;
        btnIncluir: TButton;
        btnAlterar: TButton;
        btnExcluir: TButton;
        Label5: TLabel;
        Label6: TLabel;
        edtIdProduto: TEdit;
        edtNomeProduto: TEdit;
        Label7: TLabel;
        edtQtde: TEdit;
        Label8: TLabel;
        edtDesconto: TEdit;
        Label9: TLabel;
        edtTotalItem: TEdit;
        edtDataPedido: TMaskEdit;
        Label10: TLabel;
        edtPreco: TEdit;
        edtID: TEdit;
        procedure btnGravarClick(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure edtDataPedidoKeyPress(Sender: TObject; var Key: Char);
        procedure edtQtdeKeyPress(Sender: TObject; var Key: Char);
        procedure edtDescontoKeyPress(Sender: TObject; var Key: Char);
        procedure edtIdClienteExit(Sender: TObject);
        procedure edtDataPedidoExit(Sender: TObject);
        procedure edtIdProdutoExit(Sender: TObject);
        procedure edtQtdeExit(Sender: TObject);
        procedure edtDescontoExit(Sender: TObject);
        procedure btnGravarItemClick(Sender: TObject);
        procedure btnIncluirClick(Sender: TObject);
        procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    private
        { Private declarations }
        Id_transf: string;
        procedure ExibePedido;
        procedure LimparGrade;
        procedure PopularGrade;
        procedure LimparItens;
    public
        { Public declarations }
        constructor Create(Aowner: TComponent; pId: string); reintroduce;
    end;

var
    frm_PedidosCadastro: Tfrm_PedidosCadastro;

implementation

{$R *.dfm}

constructor Tfrm_PedidosCadastro.Create(Aowner: TComponent; pId: string);
begin
    inherited Create(AOwner);
    Id_transf := pId;
end;

procedure Tfrm_PedidosCadastro.btnGravarClick(Sender: TObject);
var
    MensagemErro: string;
    tempObj: TPedidosObj;
begin
    inherited;
    MensagemErro := '';
    case TPedidosController.Validador(idcliente, edtIdCliente.Text) of false: MensagemErro := MensagemErro + 'Código do cliente inválido.'; end;
    case TPedidosController.Validador(datapedido, edtDataPedido.Text) of false: MensagemErro := MensagemErro + #13#10 + 'Data do pedido inválida.'; end;
    case string.isnullorempty(MensagemErro) of
        false:
        begin
            ShowMessage(MensagemErro);
            exit;
        end;
    end;

    try
        tempObj := TPedidosObj.Create;
        tempObj.Id := StrToIntDef(Id_transf.Trim, 0);
        tempObj.Id_cliente := StrToInt(edtIdCliente.Text);
        tempObj.Data_pedido := StrToDate(edtDataPedido.Text);
        tempObj.Total := StrToFloatDef(edtTotalPedido.Text, 0);
        Id_transf := TPedidosController.Gravar(tempObj).ToString;
        Self.Caption := 'Pedido: ' + Id_transf;
        case Id_transf.ToInteger of
            -1:
            begin
                ShowMessage('Pedido não cadastrado/alterado.');
                edtIdCliente.SetFocus;
            end;
            else
            begin
                pnlItem.Enabled := true;
                edtIdProduto.SetFocus
            end;
        end;
    finally
        FreeAndNil(tempObj);
    end;
end;

procedure Tfrm_PedidosCadastro.edtIdClienteExit(Sender: TObject);
var
    tempObj: TClientesObj;
begin
    inherited;
    try
        tempObj := TClientesObj.Create;
        tempObj := TClientesController.RetornaRegistro(edtIdCliente.Text);
        if tempObj.InstanceSize = 0 then
        begin
            ShowMessage('Cliente não cadastrado.');
            edtNomeCliente.Clear;
            edtIdCliente.SetFocus;
        end
        else
            edtNomeCliente.Text := tempObj.nome;
    finally
        FreeAndNil(tempObj);
    end;
end;

procedure Tfrm_PedidosCadastro.edtDataPedidoExit(Sender: TObject);
begin
    inherited;
    case TPedidosController.Validador(datapedido, edtDataPedido.Text) of
        false:
        begin
            ShowMessage('Data inválida.');
            edtDataPedido.SetFocus;
        end;
    end;
end;

procedure Tfrm_PedidosCadastro.edtDataPedidoKeyPress(Sender: TObject; var Key: Char);
begin
    inherited;
    if not (key in ['0'..'9', '/', #8]) then key := #0;
end;

procedure Tfrm_PedidosCadastro.FormShow(Sender: TObject);
begin
    inherited;
    ExibePedido;
    PopularGrade;
    pnlItem.Enabled := not string.IsNullOrEmpty(Id_transf);
end;

procedure Tfrm_PedidosCadastro.ExibePedido;
var
    tempObj: TPedidosObj;
begin
    inherited;
    Self.Caption := 'Pedido: ' + Id_transf;

    case string.IsNullOrEmpty(Id_transf) of
        false:
            try
                tempObj := TPedidosObj.Create;
                tempObj := TPedidosController.RetornaRegistro(Id_transf);
                edtIdCliente.Text := tempObj.id_cliente.ToString;
                edtNomeCliente.Text := tempObj.nome;
                edtDataPedido.Text := FormatDateTime('dd/mm/yyyy', tempObj.data_pedido);
                edtTotalPedido.Text := FormatFloat('0.00', tempObj.total);
            finally
                FreeAndNil(tempObj);
            end;
    end;
end;

///////////////////////
///    ITENS     /////
///////////////////////

procedure Tfrm_PedidosCadastro.btnGravarItemClick(Sender: TObject);
var
    tempNumero: integer;
    MensagemErro: string;
    tempObj: TItensObj;
begin
    inherited;
    MensagemErro := '';
    case TItensController.Validador(idproduto, edtIdProduto.Text) of false: MensagemErro := MensagemErro + 'Produto inválido.'; end;
    case TItensController.Validador(quantidade, edtQtde.Text) of false: MensagemErro := MensagemErro + #13#10 + 'Quantidade inválida.'; end;
    case TItensController.Validador(preco, edtPreco.Text) of false: MensagemErro := MensagemErro + #13#10 + 'Preço inválido.'; end;
    case TItensController.Validador(desconto, edtDesconto.Text) of false: MensagemErro := MensagemErro + #13#10 + 'Desconto inválido.'; end;
    case string.isnullorempty(MensagemErro) of
        false:
        begin
            ShowMessage(MensagemErro);
            exit;
        end;
    end;

    try
        tempObj := TItensObj.Create;
        tempObj.Id := StrToIntDef(edtID.Text, 0);
        tempObj.Id_pedido := StrToInt(Id_transf);
        tempObj.Id_produto := StrToInt(edtIdProduto.Text);
        tempObj.Quantidade := StrToFloat(edtQtde.Text);
        tempObj.Preco := StrToFloat(edtPreco.Text);
        tempObj.Desconto := StrToFloat(edtDesconto.Text);
        tempObj.Total := StrToFloatDef(edtTotalItem.Text, 0);
        tempNumero := TItensController.Gravar(tempObj);
        case tempNumero of
            -1: ShowMessage('Item não cadastrado/alterado.');
            else
            begin
                LimparGrade;
                PopularGrade;
                ExibePedido;
                LimparItens;
            end;
        end;
    finally
        FreeAndNil(tempObj);
    end;
end;

procedure Tfrm_PedidosCadastro.btnAlterarClick(Sender: TObject);
begin
    inherited;
    edtID.Text := grdPrincipal.Cells[0, grdPrincipal.Row];
    edtIdProduto.Text := grdPrincipal.Cells[2, grdPrincipal.Row];
    edtNomeProduto.Text := grdPrincipal.Cells[3, grdPrincipal.Row];
    edtQtde.Text := grdPrincipal.Cells[4, grdPrincipal.Row];
    edtPreco.Text := grdPrincipal.Cells[5, grdPrincipal.Row];
    edtDesconto.Text := grdPrincipal.Cells[6, grdPrincipal.Row];
    edtTotalItem.Text := grdPrincipal.Cells[7, grdPrincipal.Row];

    edtIdProduto.SetFocus;
end;

procedure Tfrm_PedidosCadastro.btnExcluirClick(Sender: TObject);
begin
    inherited;
    case TItensController.Excluir(grdPrincipal.Cells[0, grdPrincipal.Row], Id_transf) of
        true:
        begin
            LimparGrade;
            PopularGrade;
            ExibePedido;
            LimparItens;
        end;
    end;
end;

procedure Tfrm_PedidosCadastro.btnIncluirClick(Sender: TObject);
begin
    inherited;
    LimparItens;
end;

procedure Tfrm_PedidosCadastro.edtIdProdutoExit(Sender: TObject);
var
    tempObj: TprodutosObj;
begin
    inherited;
    case string.IsNullOrEmpty(edtIdProduto.Text) of true: exit; end;

    try
        tempObj := TProdutosObj.Create;
        tempObj := TProdutosController.RetornaRegistro(edtIdProduto.Text);
        if tempObj.Id = 0 then
        begin
            ShowMessage('Produto não cadastrado.');
            edtNomeProduto.Clear;
            edtIdProduto.SetFocus;
        end
        else
        begin
            edtNomeProduto.Text := tempObj.nome;
            edtPreco.Text := tempObj.PrecoSt;
        end;
    finally
        FreeAndNil(tempObj);
    end;
end;

procedure Tfrm_PedidosCadastro.edtDescontoExit(Sender: TObject);
var
    tempValor: Real;
begin
    inherited;
    case string.IsNullOrEmpty(edtQtde.Text) of true: exit; end;

    tempValor := StrToFloat(edtPreco.Text);
    case string.IsNullOrEmpty(edtDesconto.Text) of
        false: tempValor := tempValor - (StrToFloat(edtPreco.Text) * (StrToFloat(edtDesconto.Text) / 100));
    end;

    edtTotalItem.Text := FormatFloat('0.00', (tempValor * StrToFloat(edtQtde.Text)));
end;

procedure Tfrm_PedidosCadastro.edtDescontoKeyPress(Sender: TObject; var Key: Char);
begin
    inherited;
    if not (key in ['0'..'9', ',', #8]) then key := #0;
end;

procedure Tfrm_PedidosCadastro.edtQtdeExit(Sender: TObject);
var
    tempValor: Real;
begin
    inherited;
    case string.IsNullOrEmpty(edtQtde.Text) of true: exit; end;

    tempValor := StrToFloat(edtPreco.Text);
    case string.IsNullOrEmpty(edtDesconto.Text) of
        false: tempValor := tempValor - (StrToFloat(edtPreco.Text) * (StrToFloat(edtDesconto.Text) / 100));
    end;

    edtTotalItem.Text := FormatFloat('0.00', (tempValor * StrToFloat(edtQtde.Text)));
end;

procedure Tfrm_PedidosCadastro.edtQtdeKeyPress(Sender: TObject; var Key: Char);
begin
    inherited;
    if not (key in ['0'..'9', ',', #8]) then key := #0;
end;

procedure Tfrm_PedidosCadastro.LimparGrade;
begin
    grdPrincipal.FixedRows := 0;
    grdPrincipal.RowCount := 1;
end;

procedure Tfrm_PedidosCadastro.PopularGrade;
var
    tempLista: TObjectList;
    i1: integer;
begin
    grdPrincipal.ColCount := 8;
    grdPrincipal.Cells[0, 0] := 'Id';
    grdPrincipal.Cells[1, 0] := 'Id_pedido';
    grdPrincipal.Cells[2, 0] := 'Produto';
    grdPrincipal.Cells[3, 0] := 'Nome';
    grdPrincipal.Cells[4, 0] := 'Qtde';
    grdPrincipal.Cells[5, 0] := 'Preço';
    grdPrincipal.Cells[6, 0] := 'Desc.';
    grdPrincipal.Cells[7, 0] := 'Total';
    grdPrincipal.ColWidths[0] := 0;
    grdPrincipal.ColWidths[1] := 0;
    grdPrincipal.ColWidths[2] := 60;
    grdPrincipal.ColWidths[3] := 200;
    grdPrincipal.ColWidths[4] := 90;
    grdPrincipal.ColWidths[5] := 90;
    grdPrincipal.ColWidths[6] := 90;
    grdPrincipal.ColWidths[7] := 100;

    try
        tempLista := TItensController.RetornaLista(Id_transf);
        for i1 := 0 to tempLista.Count -1 do
        begin
            grdPrincipal.RowCount := grdPrincipal.RowCount + 1;
            grdPrincipal.Cells[0, grdPrincipal.RowCount-1] := TItensObj(tempLista[i1]).Id.ToString;
            grdPrincipal.Cells[1, grdPrincipal.RowCount-1] := TItensObj(tempLista[i1]).id_pedido.ToString;
            grdPrincipal.Cells[2, grdPrincipal.RowCount-1] := TItensObj(tempLista[i1]).id_produto.ToString;
            grdPrincipal.Cells[3, grdPrincipal.RowCount-1] := TItensObj(tempLista[i1]).produto;
            grdPrincipal.Cells[4, grdPrincipal.RowCount-1] := TItensObj(tempLista[i1]).quantidadeSt;
            grdPrincipal.Cells[5, grdPrincipal.RowCount-1] := TItensObj(tempLista[i1]).precoSt;
            grdPrincipal.Cells[6, grdPrincipal.RowCount-1] := TItensObj(tempLista[i1]).descontoSt;
            grdPrincipal.Cells[7, grdPrincipal.RowCount-1] := TItensObj(tempLista[i1]).totalSt;
        end;

        if grdPrincipal.RowCount > 1 then
            grdPrincipal.FixedRows := 1;
    finally
        FreeAndNil(tempLista);
    end;
end;

procedure Tfrm_PedidosCadastro.LimparItens;
var
    i1: integer;
begin
    inherited;
    for I1 := 0 to pnlItem.ControlCount - 1 do
        if pnlItem.Controls[i1].ClassType = TEdit then
            TEdit(pnlItem.Controls[i1]).Clear;

    edtIdProduto.SetFocus;
end;

end.

