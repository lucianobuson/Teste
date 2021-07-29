unit frmPedidosGrade;

interface

uses
    frmPedidosCadastro,
    clsPedidosController,
    clsPedidosObj,
    Winapi.Windows, Winapi.Messages,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmAncestralGrade, Vcl.Grids,
    Vcl.StdCtrls, Vcl.ExtCtrls,
    System.Contnrs,
    System.SysUtils, System.Variants, System.Classes;

type
    Tfrm_PedidosGrade = class(Tfrm_AncestralGrade)
        procedure btnIncluirClick(Sender: TObject);
        procedure btnAlterarClick(Sender: TObject);
        procedure btnExcluirClick(Sender: TObject);
        procedure btnAtualizarClick(Sender: TObject);
        procedure FormShow(Sender: TObject);
    private
        { Private declarations }
        procedure PopularGrade;
        procedure ChamaCadastro(Sender: TObject);
    public
        { Public declarations }
    end;

var
  frm_PedidosGrade: Tfrm_PedidosGrade;

implementation

{$R *.dfm}

procedure Tfrm_PedidosGrade.btnAlterarClick(Sender: TObject);
begin
    inherited;
    ChamaCadastro(Sender);
end;

procedure Tfrm_PedidosGrade.btnAtualizarClick(Sender: TObject);
begin
    inherited;
    limparGrade;
    PopularGrade;
end;

procedure Tfrm_PedidosGrade.btnExcluirClick(Sender: TObject);
begin
    inherited;
    TPedidosController.excluir(grdPrincipal.Cells[0, grdPrincipal.Row]);
    limparGrade;
    PopularGrade;
end;

procedure Tfrm_PedidosGrade.btnIncluirClick(Sender: TObject);
begin
    inherited;
    ChamaCadastro(Sender);
end;

procedure Tfrm_PedidosGrade.FormShow(Sender: TObject);
begin
    inherited;
    PopularGrade;
end;

//////////////////
//// METODOS  ////
//////////////////

procedure Tfrm_PedidosGrade.ChamaCadastro(Sender: TObject);
var
    id: string;
begin
    id := '';
    if TButton(Sender).Name = 'btnAlterar' then
        id := grdPrincipal.Cells[0, grdPrincipal.Row];

    try
        frm_PedidosCadastro := Tfrm_PedidosCadastro.Create(Self, id);
        frm_PedidosCadastro.ShowModal;
    finally
        FreeAndNil(frm_PedidosCadastro);
        limparGrade;
        PopularGrade;
    end;
end;

procedure Tfrm_PedidosGrade.PopularGrade;
var
    tempLista: TObjectList;
    i1: integer;
begin
    grdPrincipal.ColCount := 5;
    grdPrincipal.Cells[0, 0] := 'Id';
    grdPrincipal.Cells[1, 0] := 'Cliente';
    grdPrincipal.Cells[2, 0] := 'Nome';
    grdPrincipal.Cells[3, 0] := 'Data';
    grdPrincipal.Cells[4, 0] := 'Total';
    grdPrincipal.ColWidths[0] := 60;
    grdPrincipal.ColWidths[1] := 60;
    grdPrincipal.ColWidths[2] := 200;
    grdPrincipal.ColWidths[3] := 90;
    grdPrincipal.ColWidths[4] := 90;

    try
        tempLista := TPedidosController.RetornaLista;
        for i1 := 0 to tempLista.Count -1 do
        begin
            grdPrincipal.RowCount := grdPrincipal.RowCount + 1;
            grdPrincipal.Cells[0, grdPrincipal.RowCount-1] := TPedidosObj(tempLista[i1]).Id.ToString;
            grdPrincipal.Cells[1, grdPrincipal.RowCount-1] := TPedidosObj(tempLista[i1]).Id_cliente.ToString;
            grdPrincipal.Cells[2, grdPrincipal.RowCount-1] := TPedidosObj(tempLista[i1]).Nome;
            grdPrincipal.Cells[3, grdPrincipal.RowCount-1] := FormatDateTime('dd/mm/yyyy', TPedidosObj(tempLista[i1]).Data_pedido);
            grdPrincipal.Cells[4, grdPrincipal.RowCount-1] := FormatFloat('0.00', TPedidosObj(tempLista[i1]).Total);

            Next;
        end;

        if grdPrincipal.RowCount > 1 then
            grdPrincipal.FixedRows := 1;
    finally
        FreeAndNil(tempLista);
    end;
end;

end.

