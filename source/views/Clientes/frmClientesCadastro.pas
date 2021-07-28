unit frmClientesCadastro;

interface

uses
    clsClientesObj,
    clsClientesController,
    frmAncestralCadastro,
    Winapi.Windows, Winapi.Messages,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.ExtCtrls, Vcl.StdCtrls,
    System.Contnrs,
    System.SysUtils,
    System.Variants,
    System.Classes;

type
  Tfrm_clientesCadastro = class(Tfrm_AncestralCadastro)
    Label1: TLabel;
    Label2: TLabel;
    edtId: TEdit;
    edtNome: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    Id_transf: string;
  public
    { Public declarations }
    constructor Create(Aowner: TComponent; pId: string); reintroduce;
  end;

var
  frm_clientesCadastro: Tfrm_clientesCadastro;

implementation

{$R *.dfm}

{ Tfrm_clientesCadastro }

procedure Tfrm_clientesCadastro.btnGravarClick(Sender: TObject);
var
    MensagemErro: string;
begin
    inherited;
    MensagemErro := '';
    case TClientesController.Validador(nome, edtNome.Text) of false: MensagemErro := MensagemErro + 'Nome inválido.'; end;
    case string.isnullorempty(MensagemErro) of
        false:
        begin
            ShowMessage(MensagemErro);
            exit;
        end;
    end;

    ClientesObj := TClientesObj.Create;
    ClientesObj.Id := StrToIntDef(Id_transf.Trim, 0);
    ClientesObj.Nome := edtNome.Text;
    TClientesController.gravar(ClientesObj);

    FreeAndNil(ClientesObj);
    Close;
end;

constructor Tfrm_clientesCadastro.Create(Aowner: TComponent; pId: string);
begin
    inherited Create(AOwner);
    Id_transf := pId;
end;

procedure Tfrm_clientesCadastro.FormShow(Sender: TObject);
var
    tempObjeto: TClientesObj;
begin
    inherited;
    case string.IsNullOrEmpty(Id_transf) of
        false:
            try
                tempObjeto := TClientesController.RetornaRegistro(Id_transf);
                edtId.Text := tempObjeto.Id.ToString;
                edtNome.Text := tempObjeto.Nome;
            finally
                FreeAndNil(tempObjeto);
            end;
    end;
end;

end.
