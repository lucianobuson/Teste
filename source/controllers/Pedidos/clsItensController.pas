unit clsItensController;

interface

uses
    clsItensModel,
    clsItensObj,
    System.Contnrs,
    System.SysUtils,
    System.Variants;

type
    tNomes = (idproduto, quantidade, preco, desconto);

type
    TItensController = class
    private
        { Private declarations }
    public
        { Public declarations }
        class function RetornaLista(pId_pedido: string): TObjectList;
        class function RetornaRegistro(pId: string): TItensObj;
        class function Excluir(pId, pId_pedido: string): boolean;
        class function Gravar(pObjeto: TItensObj): integer;
        class function Validador(pNome: tNomes; pConteudo: String): boolean;
    end;

implementation

{ TItensController }

class function TItensController.Excluir(pId, pId_pedido: string): boolean;
begin
    result := TItensModel.excluir(pId, pId_pedido);
end;

class function TItensController.Gravar(pObjeto: TItensObj): integer;
begin
    result := -1;
    case pObjeto.Id of
        0: result := TItensModel.Incluir(pObjeto);
        else case TItensModel.alterar(pObjeto) of true: result := 0; end;
    end;
end;

class function TItensController.RetornaLista(pId_pedido: string): TObjectList;
begin
    result := TObjectList.Create;
    result := TItensModel.consultarLista('', pid_pedido);
end;

class function TItensController.RetornaRegistro(pId: string): TItensObj;
begin
    result := TItensObj.Create;
    result := TItensModel.consultarUm(pId);
end;

class function TItensController.Validador(pNome: tNomes; pConteudo: String): boolean;
var
    tempValor: Extended;
begin
    case pNome of
        idproduto: result := not string.IsNullOrEmpty(pConteudo);
        quantidade: result := TryStrToFloat(pConteudo, tempValor);
        preco: result := TryStrToFloat(pConteudo, tempValor);
        desconto: result := TryStrToFloat(pConteudo, tempValor);
    end;
end;

end.

