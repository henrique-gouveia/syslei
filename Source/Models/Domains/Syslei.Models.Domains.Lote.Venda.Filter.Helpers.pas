unit Syslei.Models.Domains.Lote.Venda.Filter.Helpers;

interface

uses
  Syslei.Models.Domains.Lote.Venda.Filter;

type
  TTipoLoteHelper = record helper for TTipoLote
  public
    function ToInteger: Integer;
    function ToShortString: String;
    function ToLongString: String;
  end;

implementation

{$REGION 'TTipoLoteHelper' }

function TTipoLoteHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

function TTipoLoteHelper.ToShortString: String;
begin
  case Self of
    tlAnimal: Result := 'A';
    tlImovel: Result := 'I';
    tlPrenda: Result := 'P';
    tlTodos: Result := 'T';
  end;
end;

function TTipoLoteHelper.ToLongString: String;
begin
  case Self of
    tlAnimal: Result := 'Animal';
    tlImovel: Result := 'Imóvel';
    tlPrenda: Result := 'Prenda';
    tlTodos: Result := 'Todos';
  end;
end;

{$ENDREGION}

end.
