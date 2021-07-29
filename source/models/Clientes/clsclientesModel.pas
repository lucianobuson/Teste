unit clsClientesModel;

interface

uses
    clsClientesObj,
    clsModel,
    Data.DB,
    System.Contnrs,
    System.SysUtils;

type
    TClientesModel = class(TModel)
    private
        const Tabela = 'CLIENTES';
    public
        class function alterar(pObj: TClientesObj): boolean;
        class function consultarLista(pSentenca: string = ''): TObjectList;
        class function consultarUm(pChave: string): TClientesObj;
        class function excluir(pId: string): boolean;
        class function incluir(pObj: TClientesObj): integer;
    end;

implementation

{ TClientesModel }

class function TClientesModel.alterar(pObj: TClientesObj): boolean;
begin
    result := executaComando('update ' + Tabela + ' set ' +
                             'nome = "' + pObj.Nome + '", ' +
                             'cidade = "' + pObj.cidade + '", ' +
                             'uf = "' + pObj.uf +
                             '" where id = ' + pObj.Id.ToString);
end;

class function TClientesModel.consultarLista(pSentenca: string): TObjectList;
var
    sentenca: string;
    tempDataset: TDataSet;
    tempObjeto: TClientesObj;
begin
    result := TObjectList.Create;
    tempDataset := TDataSet.Create(nil);

    case string.IsNullOrEmpty(pSentenca) of
        true: sentenca := 'select * from ' + Tabela + ' order by nome';
        else sentenca := pSentenca;
    end;

    try
        tempDataset := executaConsulta(sentenca);
        with tempDataset do
            while not eof do
            begin
                tempObjeto := TClientesObj.Create;
                tempObjeto.Id := FieldByName('Id').AsInteger;
                tempObjeto.Nome := FieldByName('Nome').AsString;
                tempObjeto.Cidade := FieldByName('Cidade').AsString;
                tempObjeto.UF := FieldByName('UF').AsString;
                Result.Add(tempObjeto);

                Next;
            end;
    finally
        FreeAndNil(tempDataset);
    end;
end;

class function TClientesModel.consultarUm(pChave: string): TClientesObj;
var
    tempDataset: TDataSet;
begin
    result := TClientesObj.Create;
    tempDataset := TDataSet.Create(nil);
    try
        tempDataset := executaConsulta('select * from ' + Tabela + ' where id = ' + pChave);
        with tempDataset do
        begin
            result.Id := FieldByName('Id').AsInteger;
            result.Nome := FieldByName('Nome').AsString;
            result.Cidade := FieldByName('Cidade').AsString;
            result.UF := FieldByName('UF').AsString;
        end;
    finally
        FreeAndNil(tempDataset);
    end;
end;

class function TClientesModel.excluir(pId: string): boolean;
begin
    result := executaComando('delete from ' + Tabela + ' where id = ' + pId);
end;

class function TClientesModel.incluir(pObj: TClientesObj): integer;
begin
    result := executaInsertInc('insert into ' + Tabela + ' (nome, cidade, uf) ' +
                               'values ("' + pObj.Nome + '", "' + pObj.cidade + '", "' + pObj.uf + '")');
end;

end.

