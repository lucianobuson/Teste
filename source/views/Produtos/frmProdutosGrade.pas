unit frmProdutosGrade;

interface

uses
    frmProdutosCadastro,
    clsProdutosObj,
    clsProdutosController,
    frmAncestralGrade,
    Winapi.Windows, Winapi.Messages,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    Vcl.ExtCtrls,
    System.Contnrs,
    System.SysUtils,
    System.Variants,
    System.Classes;

type
    Tfrm_ProdutosGrade = class(Tfrm_AncestralGrade)
        procedure FormShow(Sender: TObject);
        procedure btnAtualizarClick(Sender: TObject);
        procedure btnExcluirClick(Sender: TObject);
        procedure btnAlterarClick(Sender: TObject);
        procedure btnIncluirClick(Sender: TObject);
    private
        { Private declarations }
        procedure PopularGrade;
        procedure ChamaCadastro(Sender: TObject);
    public
        { Public declarations }
    end;

var
    frm_ProdutosGrade: Tfrm_ProdutosGrade;

implementation

{$R *.dfm}

{ Tfrm_ProdutosGrade }

procedure Tfrm_ProdutosGrade.btnAlterarClick(Sender: TObject);
begin
    ChamaCadastro(Sender);
end;

procedure Tfrm_ProdutosGrade.btnAtualizarClick(Sender: TObject);
begin
    limparGrade;
    PopularGrade;
end;

procedure Tfrm_ProdutosGrade.btnExcluirClick(Sender: TObject);
begin
    TProdutosController.excluir(grdPrincipal.Cells[0, grdPrincipal.Row]);
    limparGrade;
    PopularGrade;
end;

procedure Tfrm_ProdutosGrade.btnIncluirClick(Sender: TObject);
begin
    ChamaCadastro(Sender);
end;

procedure Tfrm_ProdutosGrade.FormShow(Sender: TObject);
begin
    PopularGrade;
end;

//////////////////
//// METODOS  ////
//////////////////

procedure Tfrm_ProdutosGrade.ChamaCadastro(Sender: TObject);
var
    id: string;
begin
    id := '';
    if TButton(Sender).Name = 'btnAlterar' then
        id := grdPrincipal.Cells[0, grdPrincipal.Row];

    try
        frm_ProdutosCadastro:= Tfrm_ProdutosCadastro.Create(Self, id);
        frm_ProdutosCadastro.ShowModal;
    finally
        FreeAndNil(frm_ProdutosCadastro);
        limparGrade;
        PopularGrade;
    end;
end;

procedure Tfrm_ProdutosGrade.PopularGrade;
var
    tempLista: TObjectList;
    i1: integer;
begin
    grdPrincipal.ColCount := 3;
    grdPrincipal.Cells[0, 0] := 'Id';
    grdPrincipal.Cells[1, 0] := 'Nome';
    grdPrincipal.Cells[2, 0] := 'Preço';
    grdPrincipal.ColWidths[0] := 60;
    grdPrincipal.ColWidths[1] := 200;
    grdPrincipal.ColWidths[2] := 90;

    try
        tempLista := TProdutosController.RetornaLista;
        for i1 := 0 to tempLista.Count -1 do
        begin
            grdPrincipal.RowCount := grdPrincipal.RowCount + 1;
            grdPrincipal.Cells[0, grdPrincipal.RowCount-1] := TProdutosObj(tempLista[i1]).Id.ToString;
            grdPrincipal.Cells[1, grdPrincipal.RowCount-1] := TProdutosObj(tempLista[i1]).Nome;
            grdPrincipal.Cells[2, grdPrincipal.RowCount-1] := TProdutosObj(tempLista[i1]).PrecoSt;

            Next;
        end;

        if grdPrincipal.RowCount > 1 then
            grdPrincipal.FixedRows := 1;
    finally
        FreeAndNil(tempLista);
    end;
end;

end.

