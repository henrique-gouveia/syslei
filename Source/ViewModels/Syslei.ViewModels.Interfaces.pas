unit Syslei.ViewModels.Interfaces;

interface

type
  IFilterViewModel = interface
    ['{0A18DE3D-84CE-4627-AD3E-54A26F299152}']
    procedure Novo(Sender: TObject);
    procedure Executar(Sender: TObject);
    procedure Ok(Sender: TObject);
  end;

  IFinderViewModel = interface
    ['{2011FDFC-FAAB-4876-BAF1-06FDD72989A3}']
    procedure Novo(Sender: TObject);
    procedure Avulsa(Sender: TObject);
    procedure Inicial(Sender: TObject);
    procedure Exata(Sender: TObject);
  end;

  IFinderViewModel<TEntity: class, constructor> = interface(IFinderViewModel)
    ['{A22E2DB4-AD39-4341-AE36-EC8B80D36C68}']
    function GetEntity: TEntity;
    procedure SetEntity(const value: TEntity);
  end;

  IManagerViewModel = interface
    ['{E04D38A0-1A83-410E-8B9A-951265A7CB64}']
    procedure Novo(Sender: TObject);
    procedure Gravar(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure Buscar(Sender: TObject);
  end;

  IManagerViewModel<TEntity: class, constructor> = interface(IManagerViewModel)
    ['{4098570A-18E7-41C5-8FE7-37D001FEA534}']
    function GetEntity: TEntity;
    procedure SetEntity(const value: TEntity);
  end;

implementation

end.
