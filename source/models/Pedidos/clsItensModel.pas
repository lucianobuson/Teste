unit clsItensModel;

interface

uses
    clsItensObj,
    clsModel,
    Data.DB,
    System.Contnrs,
    System.SysUtils;

type
    TItensModel = class(TModel)
    private
        const Tabela = 'ITENS';
        class function AtualizaPedido(pId_pedido: string): boolean;
    public
        class function alterar(pObj: TItensObj): boolean;
        class function consultarLista(pSentenca: string = ''; pId_pedido: string = ''): TObjectList;
        class function consultarUm(pChave: string): TItensObj;
        class function excluir(pId, pId_pedido: string): boolean;
        class function incluir(pObj: TItensObj): integer;
    end;

implementation

{ TItensModel }

class function TItensModel.alterar(pObj: TItensObj): boolean;
begin
    result := executaComando('update ' + Tabela + ' set ' +
                             ' id_produto = ' + pObj.id_pedido.ToString + ',' +
                             ' id_produto = ' + pObj.id_produto.ToString + ',' +
                             ' quantidade = ' + pObj.quantidadeBD + ',' +
                             ' preco = ' + pObj.precoBD + ',' +
                             ' desconto = ' + pObj.descontoBD + ',' +
                             ' total = ' + pObj.TotalBD +
                             ' where id = ' + pObj.Id.ToString);
    AtualizaPedido(pObj.id_pedido.ToString);
end;

class function TItensModel.AtualizaPedido(pId_pedido: string): boolean;
var
    tempDataset: TDataSet;
    sentenca: string;
    valor: real;
begin
    sentenca := 'select sum(total) as total_ped from itens where id_pedido = ' + pId_pedido;
    try
        tempDataset := TDataSet.Create(nil);
        tempDataset := executaConsulta(sentenca);
        valor := tempDataset.FieldByName('total_ped').AsFloat;
    finally
        FreeAndNil(tempDataset);
    end;

    sentenca := 'update pedidos set total = ' +
                StringReplace(FormatFloat('0.00', valor), ',', '.', [rfReplaceAll]) +
                ' where id = ' + pId_pedido;
    try
        tempDataset := TDataSet.Create(nil);
        result := executaComando(sentenca);
    finally
        FreeAndNil(tempDataset);
    end;
end;

class function TItensModel.consultarLista(pSentenca: string; pId_pedido: string): TObjectList;
var
    sentenca: string;
    tempDataset: TDataSet;
    tempObjeto: TItensObj;
begin
    result := TObjectList.Create;
    case string.IsNullOrEmpty(pId_pedido) of true: EXIT; end;

    tempDataset := TDataSet.Create(nil);

    case string.IsNullOrEmpty(pSentenca) of
        true: sentenca := 'select ite.*, pro.nome as produto ' +
                          '  from ' + Tabela + ' as ite ' +
                          '  left join produtos as pro on ite.id_produto = pro.id ' +
                          ' where ite.id_pedido = ' + pId_pedido +
                          ' order by ite.id';
        else sentenca := pSentenca;
    end;

    try
        tempDataset := executaConsulta(sentenca);
        with tempDataset do
            while not eof do
            begin
                tempObjeto := TItensObj.Create;
                tempObjeto.Id := FieldByName('Id').AsInteger;
                tempObjeto.id_pedido := FieldByName('id_pedido').AsInteger;
                tempObjeto.id_produto := FieldByName('id_produto').AsInteger;
                tempObjeto.Produto := FieldByName('produto').AsString;
                tempObjeto.quantidade := FieldByName('quantidade').AsFloat;
                tempObjeto.preco := FieldByName('preco').AsFloat;
                tempObjeto.desconto := FieldByName('desconto').AsFloat;
                tempObjeto.Total := FieldByName('Total').AsFloat;
                Result.Add(tempObjeto);

                Next;
            end;
    finally
        FreeAndNil(tempDataset);
    end;
end;

class function TItensModel.consultarUm(pChave: string): TItensObj;
var
    tempDataset: TDataSet;
begin
    result := TItensObj.Create;
    tempDataset := TDataSet.Create(nil);

    try
        tempDataset := executaConsulta('select ite.*, pro.nome as produto ' +
                                       '  from ' + Tabela + ' as ite ' +
                                       '  left join produtos as pro on ite.id_produto = pro.id ' +
                                       ' where ite.id = ' + pChave);
        result.Id := tempDataset.FieldByName('Id').AsInteger;
        result.id_pedido := tempDataset.FieldByName('id_pedido').AsInteger;
        result.id_produto := tempDataset.FieldByName('id_produto').AsInteger;
        result.Produto := tempDataset.FieldByName('produto').AsString;
        result.quantidade := tempDataset.FieldByName('quantidade').AsFloat;
        result.preco := tempDataset.FieldByName('preco').AsFloat;
        result.desconto := tempDataset.FieldByName('desconto').AsFloat;
        result.Total := tempDataset.FieldByName('Total').AsFloat;
    finally
        FreeAndNil(tempDataset);
    end;
end;

class function TItensModel.excluir(pId, pId_pedido: string): boolean;
var
    totalPedido: real;
begin
    result := executaComando('delete from ' + Tabela + ' where id = ' + pId);
    case result of
        true: result := AtualizaPedido(pId_pedido);
    end;
    case result of
        true: AtualizaPedido(pid_pedido);
    end;
end;

class function TItensModel.incluir(pObj: TItensObj): integer;
begin
    result := executaInsertInc('insert into ' + Tabela +
                               ' (id_pedido, id_produto, quantidade, preco, desconto, total) values (' +
                                pObj.id_pedido.ToString + ', ' + pObj.id_produto.ToString + ', ' +
                                pObj.quantidadeBD + ', ' + pObj.PrecoBD + ', ' +
                                pObj.descontoBD + ', ' + pObj.totalBD + ')');
    case result > 0 of
        true: AtualizaPedido(pObj.id_pedido.ToString);
    end;
end;

end.

