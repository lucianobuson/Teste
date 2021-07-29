unit frmAncestralGrade;

interface

uses
//  dtmDados,
  frmAncestral,
  Winapi.Windows, Winapi.Messages, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
//  Data.DB,
//  Datasnap.Provider,
  System.SysUtils, System.Variants, System.Classes, Vcl.StdCtrls;

type
    Tfrm_AncestralGrade = class(Tfrm_Ancestral)
        grdPrincipal: TStringGrid;
        btnAtualizar: TButton;
        btnIncluir: TButton;
        btnAlterar: TButton;
        btnExcluir: TButton;
    private
        { Private declarations }
    public
        { Public declarations }
    protected
        procedure limparGrade;
    end;

var
  frm_AncestralGrade: Tfrm_AncestralGrade;

implementation

{$R *.dfm}

{ Tfrm_AncestralGrade }

procedure Tfrm_AncestralGrade.limparGrade;
begin
    grdPrincipal.FixedRows := 0;
    grdPrincipal.RowCount := 1;
end;

end.

