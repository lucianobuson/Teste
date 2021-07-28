unit clsModel;

interface

uses
    dtmDados,
    FireDAC.Comp.Client,
    DataSnap.DBClient,
    Data.DB,
    System.SysUtils;

type
    TModel = class
    private
    protected
        class function executaConsulta(pSQL: string): TDataSet;
        class function executaComando(pSQL: string): boolean;
        class function executaInsertInc(pSQL: string): integer;
    end;

implementation

{ TModelVELHO }
{ TModelVELHO }
{ TModelVELHO }

/////////////////////////////
///    METODOS PUBLICOS /////
/////////////////////////////

class function TModel.executaInsertInc(pSQL: string): integer;
begin
    try
        try
            dtm_Dados.FDQuery1.SQL.Text := pSQL;

            dtm_Dados.fconectar;
            dtm_Dados.FDQuery1.ExecSQL;

            dtm_Dados.FDQuery1.Close;
            dtm_Dados.FDQuery1.Params.Clear;
            dtm_Dados.FDQuery1.SQL.Text := 'SELECT LAST_INSERT_ID()';
            dtm_Dados.FDQuery1.Open;
            dtm_Dados.FDQuery1.First;

            result := dtm_Dados.FDQuery1.FieldByName('LAST_INSERT_ID()').AsInteger;
        except
            on e: Exception do
            begin
                result := -1;

                raise Exception.Create(#13#10 + 'Erro: ' + E.Message + #13#10 + #13#10 +
                                       'Ao consultar o banco de dados.' + #13#10 + pSQL);
            end;
        end;
    finally
        dtm_Dados.fdesconectar;
    end;
end;

class function TModel.executaComando(pSQL: string): boolean;
begin
    try
        try
            dtm_Dados.FDQuery1.SQL.Text := pSQL;

            dtm_Dados.fconectar;
            dtm_Dados.fdConexao.StartTransaction;
            dtm_Dados.FDQuery1.ExecSQL;
            dtm_Dados.fdConexao.Commit;

            result := true;
        except
            on e: Exception do
            begin
                dtm_Dados.fdConexao.Rollback;
                result := false;

                //TGravaLog.GravaLog( 'Não foi possível atualizar banco de dados.' + #10#13 + e.ClassName + ': ' + e.Message );
                //TGravaLog.GravaLog( FDQuery1.SQL.Text );
                raise Exception.Create(#13#10 + 'Erro: ' + E.Message + #13#10 + #13#10 +
                                       'Ao consultar o banco de dados.' + #13#10 + pSQL);
            end;
        end;
    finally
        dtm_Dados.fdesconectar;
    end;
end;

class function TModel.executaConsulta(pSQL: string): TDataset;
var
    tempTable: TFDMemTable;
begin
    result := nil;
    try
        try
            dtm_Dados.FDQuery1.SQL.Text := pSQL;
            dtm_Dados.fconectar;
            dtm_Dados.FDQuery1.Open;

            tempTable := TFDMemTable.Create(nil);
            tempTable.data := dtm_Dados.FDQuery1.data;
            result := TCustomClientDataSet.Create(nil);
            result := tempTable;
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
        dtm_Dados.fdesconectar;
    end;
end;

end.

