unit frmProdutosCadastro;

interface

uses
    clsProdutosObj,
    clsProdutosController,
    frmAncestralCadastro,
    Winapi.Windows, Winapi.Messages,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, Vcl.ExtCtrls,
    System.Contnrs,
    System.SysUtils, System.Variants, System.Classes;

type
  Tfrm_ProdutosCadastro = class(Tfrm_AncestralCadastro)
    Label1: TLabel;
    Label2: TLabel;
    edtId: TEdit;
    edtNome: TEdit;
    Label3: TLabel;
    edtPreco: TEdit;
    procedure edtPrecoKeyPress(Sender: TObject; var Key: Char);
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
  frm_ProdutosCadastro: Tfrm_ProdutosCadastro;

implementation

{$R *.dfm}

procedure Tfrm_ProdutosCadastro.btnGravarClick(Sender: TObject);
var
    MensagemErro: string;
begin
    inherited;
    MensagemErro := '';
    case TProdutosController.Validador(nome, edtNome.Text) of false: MensagemErro := MensagemErro + 'Nome inválido.'; end;
    case TProdutosController.Validador(preco, edtPreco.Text) of false: MensagemErro := MensagemErro + #13#10 + 'Preço inválido.'; end;
    case string.isnullorempty(MensagemErro) of
        false:
        begin
            ShowMessage(MensagemErro);
            exit;
        end;
    end;

    ProdutosObj := TProdutosObj.Create;
    ProdutosObj.Id := StrToIntDef(Id_transf.Trim, 0);
    ProdutosObj.Nome := edtNome.Text;
    ProdutosObj.Preco := StrToFloatDef(edtPreco.Text, 0);
    case TProdutosController.Gravar(ProdutosObj) of
        -1:
        begin
            FreeAndNil(ProdutosObj);
            ShowMessage('Produto não cadastrado.');
        end
        else
        begin
            FreeAndNil(ProdutosObj);
            Close;
        end;
    end;
end;

constructor Tfrm_ProdutosCadastro.Create(Aowner: TComponent; pId: string);
begin
    inherited Create(AOwner);
    Id_transf := pId;
end;

procedure Tfrm_ProdutosCadastro.edtPrecoKeyPress(Sender: TObject; var Key: Char);
begin
    inherited;
    if not (key in ['0'..'9', ',', #8]) then key := #0;
end;

procedure Tfrm_ProdutosCadastro.FormShow(Sender: TObject);
var
    tempObjeto: TProdutosObj;
begin
    inherited;
    case string.IsNullOrEmpty(Id_transf) of
        false:
            try
                tempObjeto := TProdutosController.RetornaRegistro(Id_transf);
                edtId.Text := tempObjeto.Id.ToString;
                edtNome.Text := tempObjeto.Nome;
                edtPreco.Text := tempObjeto.PrecoSt;
            finally
                FreeAndNil(tempObjeto);
            end;
    end;
end;

end.
