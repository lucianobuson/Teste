unit clsProdutosModel;

interface

uses
    clsProdutosObj,
    clsModel,
    Data.DB,
    System.Contnrs,
    System.SysUtils;

type
    TProdutosModel = class(TModel)
    private
        const Tabela = 'PRODUTOS';
    public
        class function alterar(pObj: TProdutosObj): boolean;
        class function consultarLista(pSentenca: string = ''): TObjectList;
        class function consultarUm(pChave: string): TProdutosObj;
        class function excluir(pId: string): boolean;
        class function incluir(pObj: TProdutosObj): integer;
    end;

implementation

class function TProdutosModel.alterar(pObj: TProdutosObj): boolean;
begin
    result := executaComando('update ' + Tabela + ' set ' +
                             '  nome = "' + pObj.Nome + '",' +
                             ' preco = ' + pObj.PrecoBD +
                             ' where id = ' + pObj.Id.ToString);
end;

class function TProdutosModel.consultarLista(pSentenca: string): TObjectList;
var
    sentenca: string;
    tempDataset: TDataSet;
    tempObjeto: TProdutosObj;
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
                tempObjeto := TProdutosObj.Create;
                tempObjeto.Id := FieldByName('Id').AsInteger;
                tempObjeto.Nome := FieldByName('Nome').AsString;
                tempObjeto.Preco := FieldByName('Preco').AsFloat;
                Result.Add(tempObjeto);

                Next;
            end;
    finally
        FreeAndNil(tempDataset);
    end;
end;

class function TProdutosModel.consultarUm(pChave: string): TProdutosObj;
var
    tempDataset: TDataSet;
begin
    result := TProdutosObj.Create;
    tempDataset := TDataSet.Create(nil);

    try
        tempDataset := executaConsulta('select * from ' + Tabela + ' where id = ' + pChave);
        result.Id := tempDataset.FieldByName('id').AsInteger;
        result.Nome := tempDataset.FieldByName('nome').AsString;
        result.Preco := tempDataset.FieldByName('preco').AsFloat;
    finally
        FreeAndNil(tempDataset);
    end;
end;

class function TProdutosModel.excluir(pId: string): boolean;
begin
    result := executaComando('delete from ' + Tabela + ' where id = ' + pId);
end;

class function TProdutosModel.incluir(pObj: TProdutosObj): integer;
begin
    result := executaInsertInc('insert into ' + Tabela +
                               ' (nome, preco) values ("' +
                               pObj.Nome + '", ' + pObj.PrecoBD + ')');
end;

end.
