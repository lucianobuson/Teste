unit clsClientesModelNOVO;

interface

uses
    clsModel2,
    System.JSON,
    System.SysUtils;

type
    TClientesModelNOVO = class(TModelNOVO)
    public
        constructor Create(ptabela: String);
        class function Novo: TModelNOVO;

        function consultaLista: TJSONObject;
        function consultaRegistro(pchave: WideString): TJSONObject;
        function altera(pJSONObj: TJSONObject): integer;
        function exclui(pchave: WideString): integer;
        function inclui(pJSONObj: TJSONObject): integer;
    end;

implementation

{ TClientesModel }

{ TClientesModelNOVO }

constructor TClientesModelNOVO.Create(ptabela: String);
begin
    inherited Create(ptabela);
end;

class function TClientesModelNOVO.Novo: TModelNOVO;
begin
    result := TClientesModelNOVO.Create('clientes');
end;

/////////////////////////////////////////////
////////////// AÇÕES ////////////////////////
/////////////////////////////////////////////

function TClientesModelNOVO.consultaLista: TJSONObject;
var
    sentenca: WideString;
begin
    sentenca := 'select * from ' + vtabela + ' order by nome';
    result := afconsultar(sentenca);
end;

function TClientesModelNOVO.consultaRegistro(pchave: WideString): TJSONObject;
var
    sentenca: WideString;
begin
    sentenca := 'select * from ' + vtabela + ' where ' + pchave + ' order by nome';
    result := afconsultar(sentenca);
end;

function TClientesModelNOVO.altera(pJSONObj: TJSONObject): integer;
begin
    result := afalterar(pJSONObj, '');
end;

function TClientesModelNOVO.exclui(pchave: WideString): integer;
begin
    result := afexcluir(pchave);
end;

function TClientesModelNOVO.inclui(pJSONObj: TJSONObject): integer;
begin
    result := afincluir(pJSONObj, TRUE);
end;

end.

