unit clsClientesControllerNOVO;

interface

uses
    clsClientesModelNOVO,
    clsClientesObj,
    System.Contnrs,
    System.JSON,
    System.SysUtils,
    System.Variants;

type
    tNomes = (nome);

type
    TClientesControllerNOVO = class
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

end.
