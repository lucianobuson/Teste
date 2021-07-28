unit clsPedidosModel;

interface

uses
    clsPedidosObj,
    clsModel,
    Data.DB,
    System.Contnrs,
    System.SysUtils;

type
    TPedidosModel = class(TModel)
    private
        const Tabela = 'PEDIDOS';
    public
        class function alterar(pObj: TPedidosObj): boolean;
        class function consultarLista(pSentenca: string = ''): TObjectList;
        class function consultarUm(pChave: string): TPedidosObj;
        class function excluir(pId: string): boolean;
        class function incluir(pObj: TPedidosObj): integer;
    end;

implementation

{ TPedidosModel }

class function TPedidosModel.alterar(pObj: TPedidosObj): boolean;
begin
    result := executaComando('update ' + Tabela + ' set ' +
                             ' id_cliente = ' + pObj.Id_cliente.ToString + ',' +
                             ' data_pedido = "' + pObj.Data_pedidoBD + '", ' +
                             ' total = ' + pObj.TotalBD +
                             ' where id = ' + pObj.Id.ToString);
end;

class function TPedidosModel.consultarLista(pSentenca: string): TObjectList;
var
    sentenca: string;
    tempDataset: TDataSet;
    tempObjeto: TPedidosObj;
begin
    result := TObjectList.Create;
    tempDataset := TDataSet.Create(nil);

    case string.IsNullOrEmpty(pSentenca) of
        true: sentenca := 'select ped.*, cli.nome ' +
                          '  from ' + Tabela + ' as ped ' +
                          '  left join clientes as cli on ped.id_cliente = cli.id ' +
                          ' order by data_pedido';
        else sentenca := pSentenca;
    end;

    try
        tempDataset := executaConsulta(sentenca);
        with tempDataset do
            while not eof do
            begin
                tempObjeto := TPedidosObj.Create;
                tempObjeto.Id := FieldByName('Id').AsInteger;
                tempObjeto.Id_cliente := FieldByName('Id_cliente').AsInteger;
                tempObjeto.Nome := FieldByName('Nome').AsString;
                tempObjeto.Data_pedido := FieldByName('Data_pedido').AsDateTime;
                tempObjeto.Total := FieldByName('Total').AsFloat;
                Result.Add(tempObjeto);

                Next;
            end;
    finally
        FreeAndNil(tempDataset);
    end;
end;

class function TPedidosModel.consultarUm(pChave: string): TPedidosObj;
var
    tempDataset: TDataSet;
begin
    result := TPedidosObj.Create;
    tempDataset := TDataSet.Create(nil);

    try
        tempDataset := executaConsulta('select ped.*, cli.nome ' +
                                       '  from ' + Tabela + ' as ped ' +
                                       '  left join clientes as cli on ped.id_cliente = cli.id ' +
                                       ' where ped.id = ' + pChave);
        result.Id := tempDataset.FieldByName('id').AsInteger;
        result.Id_cliente := tempDataset.FieldByName('id_cliente').AsInteger;
        result.Nome := tempDataset.FieldByName('nome').AsString;
        result.Data_pedido := tempDataset.FieldByName('data_pedido').AsFloat;
        result.Total := tempDataset.FieldByName('total').AsFloat;
    finally
        FreeAndNil(tempDataset);
    end;
end;

class function TPedidosModel.excluir(pId: string): boolean;
begin
    result := executaComando('delete from itens where id_pedido = ' + pId);
    case result of
        true: result := executaComando('delete from ' + Tabela + ' where id = ' + pId);
    end;
end;

class function TPedidosModel.incluir(pObj: TPedidosObj): integer;
begin
    result := executaInsertInc('insert into ' + Tabela +
                               ' (id_cliente, data_pedido, total) values (' +
                               pObj.Id_cliente.ToString + ', "' + pObj.Data_pedidoBD + '", ' + pObj.TotalBD + ')');
end;

end.
