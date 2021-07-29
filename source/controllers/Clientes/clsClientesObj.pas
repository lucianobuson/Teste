unit clsClientesObj;

interface

type
    TClientesObj = class(TObject)
    private
        FId: integer;
        FNome: string;
        FUF: string;
        FCidade: string;
        procedure SetId(const Value: integer);
        procedure SetNome(const Value: string);
        procedure SetCidade(const Value: string);
        procedure SetUF(const Value: string);
    public
        property Id: integer read FId write SetId;
        property Nome: string read FNome write SetNome;
        property Cidade: string read FCidade write SetCidade;
        property UF: string read FUF write SetUF;
    end;

var
    ClientesObj: TClientesObj;

implementation

{ ClientesObj }

procedure TClientesObj.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TClientesObj.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TClientesObj.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TClientesObj.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.

