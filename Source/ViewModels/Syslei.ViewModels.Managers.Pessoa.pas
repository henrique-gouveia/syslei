unit Syslei.ViewModels.Managers.Pessoa;

interface

uses
  Syslei.Models.Entities.Pessoa,
  Syslei.ViewModels.Base.Manager;

type
  TPessoaManagerViewModel = class(TManagerViewModelBase<TPessoa>)
  public
    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject); override;
  end;

implementation

{$REGION 'TPessoaManagerViewModel' }

procedure TPessoaManagerViewModel.Novo(Sender: TObject);
begin
  inherited;
  ActiveControl := 'idEdit';
end;

procedure TPessoaManagerViewModel.Buscar(Sender: TObject);
begin
  inherited;

end;

{$ENDREGION}

end.
