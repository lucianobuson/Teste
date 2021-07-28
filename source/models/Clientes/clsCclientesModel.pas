unit clsCclientesModel;

interface

uses
    clsClientesObj,
    clsModel,
    Data.DB,
    System.SysUtils;

type
    TClientesModel = class(TModel)
    private
        const Tabela = 'CLIENTES';
    public
        class function alterar(pObj: TClientesObj): boolean;
        class function consultarLista(pSentenca: string = ''): TDataSet; overload;
        class function consultarUm(pChave: string): TDataSet; overload;
        class function excluir(pId: string): boolean;
        class function incluir(pObj: TClientesObj): integer;
    end;

implementation

{ TClientesModel }

class function TClientesModel.alterar(pObj: TClientesObj): boolean;
begin
    result := executaComando('update ' + Tabela + ' set nome = "' + pObj.Nome + '" where id = ' + pObj.Id.ToString);
end;

class function TClientesModel.consultarLista(pSentenca: string): TDataSet;
var
    sentenca: string;
begin
    case string.IsNullOrEmpty(pSentenca) of
        true: sentenca := 'select * from ' + Tabela + ' order by nome';
        else sentenca := pSentenca;
    end;

    result := TDataSet.Create(nil);
    result := executaConsulta(sentenca);
end;

class function TClientesModel.consultarUm(pChave: string): TDataSet;
begin
    result := TDataSet.Create(nil);
    result := executaConsulta('select * from ' + Tabela + ' where id = ' + pChave);
end;

class function TClientesModel.excluir(pId: string): boolean;
begin
    result := executaComando('delete from ' + Tabela + ' where id = ' + pId);
end;

class function TClientesModel.incluir(pObj: TClientesObj): integer;
begin
    result := executaInsertInc('insert into ' + Tabela + ' (nome) values ("' + pObj.Nome + '")');
end;

end.
