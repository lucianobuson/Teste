unit frmMenu;

interface

uses
    frmPedidosGrade,
    frmProdutosGrade,
    frmClientesGrade,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  Tfrm_Menu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Pedidos1: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    Sair1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Pedidos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Menu: Tfrm_Menu;

implementation

{$R *.dfm}

procedure Tfrm_Menu.Clientes1Click(Sender: TObject);
begin
    try
        if not Assigned(frm_clientesgrade) then
            frm_ClientesGrade := Tfrm_clientesgrade.Create(self);
        frm_ClientesGrade.ShowModal;
    finally
        FreeAndNil(frm_clientesgrade);
    end;
end;

procedure Tfrm_Menu.Pedidos1Click(Sender: TObject);
begin
    try
        if not Assigned(frm_PedidosGrade) then
            frm_PedidosGrade := Tfrm_PedidosGrade.Create(self);
        frm_PedidosGrade.ShowModal;
    finally
        FreeAndNil(frm_PedidosGrade);
    end;
end;

procedure Tfrm_Menu.Produtos1Click(Sender: TObject);
begin
    try
        if not Assigned(frm_produtosgrade) then
            frm_produtosgrade := Tfrm_produtosgrade.Create(self);
        frm_produtosgrade.ShowModal;
    finally
        FreeAndNil(frm_produtosgrade);
    end;
end;

procedure Tfrm_Menu.Sair1Click(Sender: TObject);
begin
    Close;
end;

end.

