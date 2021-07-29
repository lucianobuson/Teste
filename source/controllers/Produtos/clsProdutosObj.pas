unit clsProdutosObj;

interface

uses
    System.SysUtils;

type
    TProdutosObj = class(TObject)
    private
        FId: integer;
        FNome: string;
        FPreco: real;
        procedure SetId(const Value: integer);
        procedure SetNome(const Value: string);
        procedure SetPreco(const Value: real);
        function GetPrecoBD: string;
        function GetPrecoSt: string;
    public
        property Id: integer read FId write SetId;
        property Nome: string read FNome write SetNome;
        property Preco: real read FPreco write SetPreco;
        property PrecoBD: string read GetPrecoBD;
        property PrecoSt: string read GetPrecoSt;
    end;

var
    ProdutosObj: TProdutosObj;

implementation

{ TProdutosObj }

function TProdutosObj.GetPrecoBD: string;
begin
    result := StringReplace(FormatFloat('0.00', FPreco), ',', '.', [rfReplaceAll]);
end;

function TProdutosObj.GetPrecoSt: string;
begin
    result := FormatFloat('0.00', FPreco);
end;

procedure TProdutosObj.SetId(const Value: integer);
begin
    FId := Value;
end;

procedure TProdutosObj.SetNome(const Value: string);
begin
    FNome := Value;
end;

procedure TProdutosObj.SetPreco(const Value: real);
begin
    FPreco := Value;
end;

end.

