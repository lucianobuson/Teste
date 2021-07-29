unit frmAncestralCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmAncestral, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  Tfrm_AncestralCadastro = class(Tfrm_Ancestral)
    btnGravar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_AncestralCadastro: Tfrm_AncestralCadastro;

implementation

{$R *.dfm}

end.

