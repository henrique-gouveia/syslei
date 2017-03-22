unit Syslei.ViewModels.Finders.Pessoa;

interface

uses
  Syslei.Models.Entities.Pessoa,
  Syslei.ViewModels.Base.Finder;

type
  TPessoaFinderViewModel = class(TFinderViewModelBase<TPessoa>)
  public
    procedure AfterConstruction; override;
  end;

implementation

{$REGION 'TPessoaFinderViewModel' }

uses
  Syslei.ViewModels.Base.Domain;

procedure TPessoaFinderViewModel.AfterConstruction;
begin
  inherited;
  SearchProperties.AddRange([
    TPropertyData.Create('NOME', 'NOME'),
    TPropertyData.Create('CPF', 'CPF')
  ]);
end;

{$ENDREGION}

end.
