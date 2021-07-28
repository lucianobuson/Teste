unit dtmDados;

interface

uses
//    DataSnap.DBClient,
    FireDAC.Stan.Intf,
    FireDAC.Stan.Option,
    FireDAC.Stan.Error,
    FireDAC.UI.Intf,
    FireDAC.Phys.Intf,
    FireDAC.Stan.Def,
    FireDAC.Stan.Pool,
    FireDAC.Stan.Async,
    FireDAC.Phys,
    FireDAC.Phys.MySQL,
    FireDAC.Phys.MySQLDef,
    FireDAC.Stan.Param,
    FireDAC.DatS,
    FireDAC.DApt.Intf,
    FireDAC.DApt,
    FireDAC.VCLUI.Wait,
    FireDAC.Comp.UI,
    Data.DB,
    FireDAC.Comp.DataSet,
    FireDAC.Comp.Client,
    System.JSON,
    System.SysUtils,
    System.Classes;

type
    Tdtm_Dados = class(TDataModule)
        fdConexao: TFDConnection;
        FDQuery1: TFDQuery;
        FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    private
        { Private declarations }
    public
        { Public declarations }
        function fconectar: boolean;
        function fdesconectar: boolean;

        function fexecutaComando(pSQL: string): boolean;
        function fexecutaComando2(pSQL: string; pIncremental: boolean = false): integer;
        function fexecutaConsulta(pSQL: string): TJSONObject;
        function fexecutaInsertInc(pSQL: string): integer;
    end;

var
    dtm_Dados: Tdtm_Dados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdtm_Dados }

function Tdtm_Dados.fconectar: boolean;
begin
    try
        case FDConexao.Connected of true: FDConexao.Close; end;
        result := FDConexao.Connected;
    except
        on e: Exception do
        begin
            result := false;
            raise Exception.Create(#13#10 + 'Erro ao conectar no banco de dados.' +
                                   #13#10 + #13#10 + 'Erro: ' + E.Message);
        end;
    end;
end;

function Tdtm_Dados.fdesconectar: boolean;
begin
    FDConexao.Close;
    result := FDConexao.Connected;
end;

/////////////////////////////
///    METODOS PUBLICOS /////
/////////////////////////////

function Tdtm_Dados.fexecutaComando(pSQL: string): boolean;
begin
    try
        try
            FDQuery1.SQL.Text := pSQL;

            fconectar;
            fdConexao.StartTransaction;
            FDQuery1.ExecSQL;
            fdConexao.Commit;

            result := true;
        except
            on e: Exception do
            begin
                fdConexao.Rollback;
                result := false;

                //TGravaLog.GravaLog( 'Não foi possível atualizar banco de dados.' + #10#13 + e.ClassName + ': ' + e.Message );
                //TGravaLog.GravaLog( FDQuery1.SQL.Text );
                raise Exception.Create(#13#10 + 'Erro: ' + E.Message + #13#10 + #13#10 +
                                       'Ao consultar o banco de dados.' + #13#10 + pSQL);
            end;
        end;
    finally
        fdesconectar;
    end;
end;

function Tdtm_Dados.fexecutaComando2(pSQL: string; pIncremental: boolean): integer;
begin
    result := 0;
    try
        try
            FDQuery1.SQL.Text := pSQL;

            fconectar;
            fdConexao.StartTransaction;
            FDQuery1.ExecSQL;

            case pIncremental of FALSE: EXIT; end;

            FDQuery1.Close;
            FDQuery1.Params.Clear;
            FDQuery1.SQL.Text := 'SELECT LAST_INSERT_ID()';
            FDQuery1.Open;
            FDQuery1.First;

            result := FDQuery1.FieldByName('LAST_INSERT_ID()').AsInteger;
        except
            on e: Exception do
            begin
                result := -1;
                fdConexao.Rollback;
                case fdConexao.InTransaction of TRUE: fdConexao.Commit; end;

                //TGravaLog.GravaLog( 'Não foi possível atualizar banco de dados.' + #10#13 + e.ClassName + ': ' + e.Message );
                //TGravaLog.GravaLog( FDQuery1.SQL.Text );
                raise Exception.Create(#13#10 + 'Erro: ' + E.Message + #13#10 + #13#10 +
                                       'Ao consultar o banco de dados.' + #13#10 + pSQL);
            end;
        end;
    finally
        case fdConexao.InTransaction of TRUE: fdConexao.Commit; end;
        fdesconectar;
    end;
end;

function Tdtm_Dados.fexecutaConsulta(pSQL: string): TJSONObject;
var
    field_name, Columnname, ColumnValue : String;
    I1: Integer;

    LJSONObject:TJsonObject;

    tempTable: TFDMemTable;
begin
    result := nil;
    try
        try
            FDQuery1.SQL.Text := pSQL;
            fconectar;
            FDQuery1.Open;

            tempTable := TFDMemTable.Create(nil);
            tempTable.data := dtm_Dados.FDQuery1.data;

            tempTable.BeginBatch;//Don't update external references until EndBatch;
            tempTable.First;
            LJSONObject:= TJSONObject.Create;
            while (not tempTable.EOF) do
            begin
                for I1 := 0 to tempTable.FieldDefs.Count-1 do
                begin
                    ColumnName := tempTable.FieldDefs[I1].Name;
                    case tempTable.FieldDefs[I1].Datatype of
                        ftBoolean:
                            case tempTable.Fields[I1].AsBoolean of
                                True: LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create(ColumnName), TJSONTrue.Create));
                                else LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create(ColumnName), TJSONFalse.Create));
                            end;
                        ftInteger,ftFloat{,ftSmallint,ftWord,ftCurrency} :
                            LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create(ColumnName), TJSONNumber.Create(tempTable.Fields[I1].value)));
                        ftDate,ftDatetime,ftTime:
                            //LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create(ColumnName), TJSONString.Create(tempTable.Fields[I1].AsString)));
                            LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create(ColumnName), TJSONString.Create(formatDateTime('dd/mm/yyyy', tempTable.Fields[I1].Value))));
                            //or TJSONString.Create(formatDateTime('dd/mm/yyyy', tempTable.Fields[I1].Value));
                        else
                            LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create(ColumnName), TJSONString.Create(tempTable.Fields[I1].AsString)));
                    end;
                end;

                tempTable.Next;
            end;
            tempTable.EndBatch;
        except
            on e: Exception do
            begin
                //TGravaLog.GravaLog( 'Não foi possível consultar banco de dados.' + #10#13 + e.ClassName + ': ' + e.Message );
                //TGravaLog.GravaLog( FDQuery1.SQL.Text );
                raise Exception.Create(#13#10 + 'Erro: ' + E.Message + #13#10 + #13#10 +
                                       'Ao consultar o banco de dados.' + #13#10 + pSQL);
            end;
        end;
    finally
        fdesconectar;
        FreeAndNil(tempTable);
        FDQuery1.Close;
    end;
end;

function Tdtm_Dados.fexecutaInsertInc(pSQL: string): integer;
begin
    try
        try
            FDQuery1.SQL.Text := pSQL;

            fconectar;
            FDQuery1.ExecSQL;

            FDQuery1.Close;
            FDQuery1.Params.Clear;
            FDQuery1.SQL.Text := 'SELECT LAST_INSERT_ID()';
            FDQuery1.Open;
            FDQuery1.First;

            result := FDQuery1.FieldByName('LAST_INSERT_ID()').AsInteger;
        except
            on e: Exception do
            begin
                result := -1;

                raise Exception.Create(#13#10 + 'Erro: ' + E.Message + #13#10 + #13#10 +
                                       'Ao consultar o banco de dados.' + #13#10 + pSQL);
            end;
        end;
    finally
        fdesconectar;
    end;
end;

end.
