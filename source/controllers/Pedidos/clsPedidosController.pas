unit clsPedidosController;

interface

uses
    clsPedidosModel,
    clsPedidosObj,
    System.Contnrs,
    System.SysUtils,
    System.Variants;

type
    tNomes = (idcliente, datapedido);

type
    TPedidosController = class
    private
        { Private declarations }
    public
        { Public declarations }
        class function RetornaLista: TObjectList;
        class function RetornaRegistro(pId: string): TPedidosObj;
        class function Excluir(pId: string): boolean;
        class function Gravar(pObjeto: TPedidosObj): integer;
        class function Validador(pNome: tNomes; pConteudo: String): boolean;
    end;

implementation

{ TPedidosController }

class function TPedidosController.Excluir(pId: string): boolean;
begin
    result := TPedidosModel.excluir(pId);
end;

class function TPedidosController.Gravar(pObjeto: TPedidosObj): integer;
begin
    result := -1;
    case pObjeto.Id of
        0: result := TPedidosModel.Incluir(pObjeto);
        else case TPedidosModel.alterar(pObjeto) of true: result := 0; end;
    end;
end;

class function TPedidosController.RetornaLista: TObjectList;
begin
    result := TObjectList.Create;
    result := TPedidosModel.consultarLista;
end;

class function TPedidosController.RetornaRegistro(pId: string): TPedidosObj;
begin
    result := TPedidosObj.Create;
    result := TPedidosModel.consultarUm(pId);
end;

class function TPedidosController.Validador(pNome: tNomes; pConteudo: String): boolean;
var
    tempData: TDateTime;
begin
    case pNome of
        idcliente: result := not string.IsNullOrEmpty(pConteudo);
        datapedido: result := TryStrToDate(pConteudo, tempData)
    end;
end;

end.
