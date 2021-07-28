unit clsClientesController;

interface

uses
    clsClientesModel,
    clsClientesObj,
    System.Contnrs,
    System.SysUtils,
    System.Variants;

type
    tNomes = (nome);

type
    TClientesController = class
    private
        { Private declarations }
    public
        { Public declarations }
        class function RetornaLista: TObjectList;
        class function RetornaRegistro(pId: string): TClientesObj;
        class function Excluir(pId: string): boolean;
        class function Gravar(pObjeto: TClientesObj): integer;
        class function Validador(pNome: tNomes; pConteudo: String): boolean;
    end;

implementation

{ TClientesController }

class function TClientesController.Excluir(pId: string): boolean;
begin
    result := TClientesModel.excluir(pId);
end;

class function TClientesController.Gravar(pObjeto: TClientesObj): integer;
begin
    result := -1;
    case pObjeto.Id of
        0: result := TClientesModel.incluir(pObjeto);
        else case TClientesModel.alterar(pObjeto) of true: result := 0; end;
    end;
end;

class function TClientesController.RetornaLista: TObjectList;
begin
    result := TObjectList.Create;
    result := TClientesModel.consultarLista;
end;

class function TClientesController.RetornaRegistro(pId: string): TClientesObj;
begin
    inherited;
    result := TClientesObj.Create;
    result := TClientesModel.consultarUm(pId);
end;

class function TClientesController.Validador(pNome: tNomes; pConteudo: String): boolean;
begin
    case pNome of
        nome: result := not string.IsNullOrEmpty(pConteudo);
    end;
end;

end.
