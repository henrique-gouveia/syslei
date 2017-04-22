unit Syslei.Models.Domains.Lote.Filter.Helpers;

interface

uses
  Syslei.Models.Domains.Lote.Filter;

type
  TStatusLoteHelper = record helper for TStatusLote
  public
    function ToInteger: Integer;
  end;

  TTipoLoteHelper = record helper for TTipoLote
  public
    function ToInteger: Integer;
  end;

implementation

{$REGION 'TStatusLoteHelper' }

function TStatusLoteHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

{$ENDREGION}

{$REGION 'TTipoLoteHelper' }

function TTipoLoteHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

{$ENDREGION}

end.
