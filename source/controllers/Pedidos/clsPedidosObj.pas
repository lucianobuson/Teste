unit clsPedidosObj;

interface

uses
    System.SysUtils;

type
    TPedidosObj = class(TObject)
    private
        FTotal: real;
        FId_cliente: integer;
        FId: integer;
        FData_pedido: TDate;
    FNome: string;
        procedure SetData_pedido(const Value: TDate);
        procedure SetId(const Value: integer);
        procedure SetId_cliente(const Value: integer);
        procedure SetTotal(const Value: real);
        function GetData_pedidoBD: string;
        function GetData_pedidoSt: string;
        function GetTotalBD: string;
        function GetTotalSt: string;
    procedure SetNome(const Value: string);
    public
        property Id: integer read FId write SetId;
        property Id_cliente: integer read FId_cliente write SetId_cliente;
        property Data_pedido: TDate read FData_pedido write SetData_pedido;
        property Total: real read FTotal write SetTotal;
        property Data_pedidoBD: string read GetData_pedidoBD;
        property Data_pedidoSt: string read GetData_pedidoSt;
        property TotalBD: string read GetTotalBD;
        property TotalSt: string read GetTotalSt;
        property Nome: string read FNome write SetNome;
    end;

implementation

{ TPedidosObj }

function TPedidosObj.GetData_pedidoBD: string;
begin
    result := FormatDateTime('yyyy-mm-dd', FData_pedido);
end;

function TPedidosObj.GetData_pedidoSt: string;
begin
    result := FormatDateTime('dd/mm/yyyy', FData_pedido);
end;

function TPedidosObj.GetTotalBD: string;
begin
    result := StringReplace(FormatFloat('0.00', FTotal), ',', '.', [rfReplaceAll]);
end;

function TPedidosObj.GetTotalSt: string;
begin
    result := FormatFloat('0.00', Ftotal);
end;

procedure TPedidosObj.SetData_pedido(const Value: TDate);
begin
    FData_pedido := Value;
end;

procedure TPedidosObj.SetId(const Value: integer);
begin
    FId := Value;
end;

procedure TPedidosObj.SetId_cliente(const Value: integer);
begin
    FId_cliente := Value;
end;

procedure TPedidosObj.SetNome(const Value: string);
begin
    FNome := Value;
end;

procedure TPedidosObj.SetTotal(const Value: real);
begin
    FTotal := Value;
end;

end.
