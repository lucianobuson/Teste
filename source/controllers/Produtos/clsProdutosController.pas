unit clsProdutosController;

interface

uses
    clsProdutosModel,
    clsProdutosObj,
    System.Contnrs,
    System.SysUtils,
    System.Variants;

type
    tNomes = (nome, preco);

type
    TProdutosController = class
    private
        { Private declarations }
    public
        { Public declarations }
        class function RetornaLista: TObjectList;
        class function RetornaRegistro(pId: string): TProdutosObj;
        class function Excluir(pId: string): boolean;
        class function Gravar(pObjeto: TProdutosObj): integer;
        class function Validador(pNome: tNomes; pConteudo: String): boolean;
    end;

implementation

{ TProdutosController }

class function TProdutosController.Excluir(pId: string): boolean;
begin
    result := TProdutosModel.excluir(pId);
end;

class function TProdutosController.Gravar(pObjeto: TProdutosObj): integer;
begin
    result := -1;
    case pObjeto.Id of
        0: result := TProdutosModel.incluir(ProdutosObj);
        else case TProdutosModel.alterar(ProdutosObj) of true: result := 0; end;
    end;
end;

class function TProdutosController.RetornaLista: TObjectList;
begin
    result := TObjectList.Create;
    result := TProdutosModel.consultarLista;
end;

class function TProdutosController.RetornaRegistro(pId: string): TProdutosObj;
begin
    inherited;
    result := TProdutosObj.Create;
    result := TProdutosModel.consultarUm(pId);
end;


class function TProdutosController.Validador(pNome: tNomes; pConteudo: String): boolean;
begin
    case pNome of
        nome: result := not string.IsNullOrEmpty(pConteudo);
        preco: result := StrToFloatDef(pConteudo, 0) > 0;
    end;
end;

end.

