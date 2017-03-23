unit Syslei.ViewModels.Finders.Lote;

interface

uses
  Syslei.Models.Entities.Lote,
  Syslei.ViewModels.Base.Finder;

type
  TLoteFinderViewModel = class(TFinderViewModelBase<TLote>)
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Syslei.ViewModels.Base.Domain;

{$REGION 'TLoteFinderViewModel' }

procedure TLoteFinderViewModel.AfterConstruction;
begin
  inherited;
  SearchProperties.AddRange([
    TPropertyData.Create('N�MERO', 'NUMERO'),
    TPropertyData.Create('DESCRI��O', 'DESCRICAO')
  ]);
end;

{$ENDREGION}

end.
