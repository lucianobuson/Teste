unit frmClientesGrade;

interface

uses
    frmClientesCadastro,
    clsClientesController,
    clsClientesObj,
    frmAncestralGrade,
    Winapi.Windows, Winapi.Messages,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
    System.Contnrs,
    System.SysUtils,
    System.Variants,
    System.Classes;

type
    Tfrm_clientesgrade = class(Tfrm_AncestralGrade)
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
    frm_clientesgrade: Tfrm_clientesgrade;

implementation

{$R *.dfm}

procedure Tfrm_clientesgrade.btnAlterarClick(Sender: TObject);
begin
    inherited;
    ChamaCadastro(Sender);
end;

procedure Tfrm_clientesgrade.btnAtualizarClick(Sender: TObject);
begin
    inherited;
    limparGrade;
    PopularGrade;
end;

procedure Tfrm_clientesgrade.btnExcluirClick(Sender: TObject);
begin
    inherited;
    TClientesController.excluir(grdPrincipal.Cells[0, grdPrincipal.Row]);
    limparGrade;
    PopularGrade;
end;

procedure Tfrm_clientesgrade.btnIncluirClick(Sender: TObject);
begin
    inherited;
    ChamaCadastro(Sender);
end;

procedure Tfrm_clientesgrade.FormShow(Sender: TObject);
begin
    inherited;
    PopularGrade;
end;

//////////////////
//// METODOS  ////
//////////////////

procedure Tfrm_clientesgrade.ChamaCadastro(Sender: TObject);
var
    id: string;
begin
    id := '';
    if TButton(Sender).Name = 'btnAlterar' then
        id := grdPrincipal.Cells[0, grdPrincipal.Row];

    try
        frm_clientesCadastro := Tfrm_clientesCadastro.Create(Self, id);
        frm_clientesCadastro.ShowModal;
    finally
        FreeAndNil(frm_clientesCadastro);
        limparGrade;
        PopularGrade;
    end;
end;

procedure Tfrm_clientesgrade.PopularGrade;
var
    tempLista: TObjectList;
    i1: integer;
begin
    grdPrincipal.ColCount := 4;
    grdPrincipal.Cells[0, 0] := 'Id';
    grdPrincipal.Cells[1, 0] := 'Nome';
    grdPrincipal.Cells[2, 0] := 'Cidade';
    grdPrincipal.Cells[3, 0] := 'Uf';
    grdPrincipal.ColWidths[0] := 60;
    grdPrincipal.ColWidths[1] := 200;
    grdPrincipal.ColWidths[2] := 200;
    grdPrincipal.ColWidths[3] := 60;

    try
        tempLista := TClientesController.RetornaLista;
        for i1 := 0 to tempLista.Count -1 do
        begin
            grdPrincipal.RowCount := grdPrincipal.RowCount + 1;
            grdPrincipal.Cells[0, grdPrincipal.RowCount-1] := TClientesObj(tempLista[i1]).Id.ToString;
            grdPrincipal.Cells[1, grdPrincipal.RowCount-1] := TClientesObj(tempLista[i1]).Nome;
            grdPrincipal.Cells[2, grdPrincipal.RowCount-1] := TClientesObj(tempLista[i1]).Cidade;
            grdPrincipal.Cells[3, grdPrincipal.RowCount-1] := TClientesObj(tempLista[i1]).UF;

            Next;
        end;

        if grdPrincipal.RowCount > 1 then
            grdPrincipal.FixedRows := 1;
    finally
        FreeAndNil(tempLista);
    end;
end;

end.

