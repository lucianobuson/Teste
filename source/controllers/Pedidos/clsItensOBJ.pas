unit clsItensOBJ;

interface

uses
    System.SysUtils;

type
    TItensObj = class(TObject)
    private
        Fdesconto: real;
        Fid_produto: integer;
        Fpreco: real;
        Fid_pedido: integer;
        Ftotal: real;
        Fid: integer;
        Fproduto: string;
        Fquantidade: real;
        function GettotalBD: string;
        function GettotalSt: string;
        procedure Setdesconto(const Value: real);
        procedure Setid(const Value: integer);
        procedure Setid_pedido(const Value: integer);
        procedure Setid_produto(const Value: integer);
        procedure Setpreco(const Value: real);
        procedure Settotal(const Value: real);
        function GetdescontoBD: string;
        function GetdescontoSt: string;
        function GetprecoBD: string;
        function GetprecoSt: string;
        procedure Setproduto(const Value: string);
        procedure Setquantidade(const Value: real);
        function GetquantidadeBD: string;
        function GetquantidadeSt: string;
    public
        property id: integer read Fid write Setid;
        property id_pedido: integer read Fid_pedido write Setid_pedido;
        property id_produto: integer read Fid_produto write Setid_produto;

        property quantidade: real read Fquantidade write Setquantidade;
        property quantidadeBD: string read GetquantidadeBD;
        property quantidadeSt: string read GetquantidadeSt;

        property preco: real read Fpreco write Setpreco;
        property precoBD: string read GetprecoBD;
        property precoSt: string read GetprecoSt;

        property desconto: real read Fdesconto write Setdesconto;
        property descontoBD: string read GetdescontoBD;
        property descontoSt: string read GetdescontoSt;

        property total: real read Ftotal write Settotal;
        property totalBD: string read GettotalBD;
        property totalSt: string read GettotalSt;

        property produto: string read Fproduto write Setproduto;
    end;

implementation

{ TitensObj }

function TItensObj.GetdescontoBD: string;
begin
    result := StringReplace(FormatFloat('0.00', Fdesconto), ',', '.', [rfReplaceAll]);
end;

function TItensObj.GetdescontoSt: string;
begin
    result := FormatFloat('0.00', Fdesconto);
end;

function TItensObj.GetprecoBD: string;
begin
    result := StringReplace(FormatFloat('0.00', Fpreco), ',', '.', [rfReplaceAll]);
end;

function TItensObj.GetprecoSt: string;
begin
    result := FormatFloat('0.00', Fpreco);
end;

function TItensObj.GetquantidadeBD: string;
begin
    result := StringReplace(FormatFloat('0.00', Fquantidade), ',', '.', [rfReplaceAll]);
end;

function TItensObj.GetquantidadeSt: string;
begin
    result := FormatFloat('0.00', Fquantidade);
end;

function TItensObj.GettotalBD: string;
begin
    result := StringReplace(FormatFloat('0.00', Ftotal), ',', '.', [rfReplaceAll]);
end;

function TItensObj.GettotalSt: string;
begin
    result := FormatFloat('0.00', Ftotal);
end;

procedure TItensObj.Setproduto(const Value: string);
begin
    Fproduto := Value;
end;

procedure TItensObj.Setid(const Value: integer);
begin
    Fid := Value;
end;

procedure TItensObj.Setid_pedido(const Value: integer);
begin
    Fid_pedido := Value;
end;

procedure TItensObj.Setid_produto(const Value: integer);
begin
    Fid_produto := Value;
end;

procedure TItensObj.Settotal(const Value: real);
begin
    Ftotal := Value;
end;

procedure TItensObj.Setquantidade(const Value: real);
begin
    Fquantidade := Value;
end;

procedure TItensObj.Setpreco(const Value: real);
begin
    Fpreco := Value;
end;

procedure TItensObj.Setdesconto(const Value: real);
begin
    Fdesconto := Value;
end;

end.
