unit clsModel2;

interface

uses
    dtmDados,
    System.JSON,
    System.SysUtils;

type
    TModelNOVO = class(TObject)
    private
        function afgeraInsert(pJSONObj: TJSONObject): WideString;
        function afgeraUpdate(pJSONObj: TJSONObject): WideString;
    public
    protected
        vtabela: string;
        constructor Create(ptabela: String);
        class function afNovo(ptabela: String): TModelNOVO;

        function afalterar(pJSONObj: TJSONObject = NIL; pSentenca: WideString = ''): integer;
        function afconsultar(pSentenca: WideString = ''): TJSONObject;
        function afexcluir(pChave: WideString): integer;
        function afincluir(pJSONObj: TJSONObject; pIncremental: boolean = false): integer;

//        function altera(pJSONObj: TJSONObject = NIL; pSentenca: WideString = ''): integer;
//        function consulta(pSentenca: WideString = ''): TJSONObject;
//        function exclui(pChave: WideString): integer;
//        function inclui(pJSONObj: TJSONObject; pIncremental: boolean = false): integer;
    end;

implementation

constructor TModelNOVO.Create(ptabela: String);
begin
    inherited Create;
    vtabela := ptabela;
end;

class function TModelNOVO.afNovo(ptabela: String): TModelNOVO;
begin
    result := TModelNOVO.Create(ptabela);
end;

///////////////////////////////////////////////
////////////// PRIVATE ////////////////////////
///////////////////////////////////////////////

function TModelNOVO.afalterar(pJSONObj: TJSONObject = NIL; pSentenca: WideString = ''): integer;
begin
    case Assigned(pJSONObj) of TRUE: pSentenca := afgeraUpdate(pJSONObj); end;
    result := dtm_Dados.fexecutaComando2(pSentenca);
end;

function TModelNOVO.afconsultar(pSentenca: WideString): TJSONObject;
begin
    case string.IsNullOrEmpty(pSentenca) of FALSE: pSentenca := 'select * from ' + vtabela + ' limit 1'; end;
    result := dtm_Dados.fexecutaConsulta(pSentenca);
end;

function TModelNOVO.afexcluir(pChave: WideString): integer;
begin
    result := dtm_Dados.fexecutaComando2('delete from ' + vtabela + ' where ' + pChave);
end;

function TModelNOVO.afincluir(pJSONObj: TJSONObject; pIncremental: boolean = false): integer;
begin
    result := dtm_Dados.fexecutaComando2(afgeraInsert(pJSONObj), pIncremental);
end;

/////////////////////////////////////////////////
////////////// GERADORES ////////////////////////
/////////////////////////////////////////////////

function TModelNOVO.afgeraInsert(pJSONObj: TJSONObject): WideString;
var
    jSubObj: TJSONObject;
    jsonArray: TJSONArray;
    jsonValue: TJSONValue;
    i1: Integer;
    vVirgula: string;
    vSQL1, vSQL2: WideString;
begin
    jsonValue := pJSONObj.Get('CAMPOS_VALORES').JsonValue;
    jsonArray := jsonValue as TJSONArray;
    vSQL1 := '';
    vSQL2 := '';
    vVirgula := '';
    for i1 := 0 to jsonArray.Count - 1 do
    begin
        vSQL1 := vSQL1 + vVirgula;
        vSQL2 := vSQL2 + vVirgula;
        jSubObj := (jsonArray.Items[i1] as TJSONObject);
        jsonValue := jSubObj.Pairs[i1].JsonValue;
        vSQL1 := vSQL1 + jSubObj.Value;
        vSQL2 := vSQL2 + jsonValue.Value;
        vVirgula := ', ';
    end;

    result := 'insert into ' + vtabela + ' (' + vSQL1 + ') values (' + vSQL2 + ')';
end;

function TModelNOVO.afgeraUpdate(pJSONObj: TJSONObject): WideString;
var
    jSubObj: TJSONObject;
    jsonArray: TJSONArray;
    jsonValue: TJSONValue;
    i1: Integer;
    vVirgula: string;
    vSQL1, vSQL2: WideString;
begin
    // jsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Memo1.Text), 0) as TJSONObject;

    jsonValue := pJSONObj.Get('CAMPOS_VALORES').JsonValue;
    jsonArray := jsonValue as TJSONArray;
    vSQL1 := '';
    vVirgula := '';
    for i1 := 0 to jsonArray.Count - 1 do
    begin
        vSQL1 := vSQL1 + vVirgula;
        jSubObj := (jsonArray.Items[i1] as TJSONObject);
        jsonValue := jSubObj.Pairs[i1].JsonValue;
        vSQL1 := vSQL1 + jSubObj.Value + ' = ' + jsonValue.Value;
        vVirgula := ', ';
    end;
    vSQL2 := 'update ' + vtabela + ' set ' + vSQL1;

    jsonValue := pJSONObj.Get('WHERE').JsonValue;
    jsonArray := jsonValue as TJSONArray;
    vSQL1 := '';
    vVirgula := '';
    for i1 := 0 to jsonArray.Count - 1 do
    begin
        vSQL1 := vSQL1 + vVirgula;
        jSubObj := (jsonArray.Items[i1] as TJSONObject);
        jsonValue := jSubObj.Pairs[i1].JsonValue;
        vSQL1 := vSQL1 + jSubObj.Value + ' = ' + jsonValue.Value;
        vVirgula := ', ';
    end;

    result := vSQL2 + ' where ' + vSQL1;
end;

///////////////////////////////////////
////////////// protected //////////////
///////////////////////////////////////

//function TModelNOVO.altera(pJSONObj: TJSONObject; pSentenca: WideString): integer;
//begin
//    result := -1;
//end;
//
//function TModelNOVO.consulta(pSentenca: WideString): TJSONObject;
//begin
//    result := NIL;
//end;
//
//function TModelNOVO.exclui(pChave: WideString): integer;
//begin
//    result := -1;
//end;
//
//function TModelNOVO.inclui(pJSONObj: TJSONObject; pIncremental: boolean): integer;
//begin
//    result := -1;
//end;

end.
