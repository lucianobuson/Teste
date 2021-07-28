unit clsClientesObj;

interface

type
    TClientesObj = class(TObject)
    private
        FId: integer;
        FNome: string;
        procedure SetId(const Value: integer);
        procedure SetNome(const Value: string);
    public
        property Id: integer read FId write SetId;
        property Nome: string read FNome write SetNome;
    end;

var
    ClientesObj: TClientesObj;

implementation

{ ClientesObj }

procedure TClientesObj.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TClientesObj.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.
