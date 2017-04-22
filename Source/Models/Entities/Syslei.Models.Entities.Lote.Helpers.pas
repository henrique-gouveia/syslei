unit Syslei.Models.Entities.Lote.Helpers;

interface

uses
  Syslei.Models.Entities.Lote;

type
  TSexoHelper = record helper for TSexo
  public
    function ToInteger: Integer;
    function ToLongString: String;
    function ToShortString: String;
  end;

  TStatusLoteHelper = record helper for TStatusLote
  public
    function ToInteger: Integer;
    function ToLongString: String;
  end;

  TTipoLoteHelper = record helper for TTipoLote
  public
    function ToInteger: Integer;
    function ToLongString: String;
    function ToShortString: String;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TSexoHelper' }

function TSexoHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

function TSexoHelper.ToLongString: String;
begin
  case Self of
    Masculino: Result := 'Masculino';
    Feminino: Result := 'Feminino';
  end;
end;

function TSexoHelper.ToShortString: String;
begin
  case Self of
    Masculino: Result := 'M';
    Feminino: Result := 'F';
  end;
end;

{$ENDREGION}

{$REGION 'TStatusLoteHelper' }

function TStatusLoteHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

function TStatusLoteHelper.ToLongString: String;
begin
  case Self of
    Aguardando: Result := 'Aguardando';
    Agendado: Result := 'Agendado';
    Arrematado: Result := 'Arrematado';
  end;
end;

{$ENDREGION}

{$REGION 'TTipoLoteHelper' }

function TTipoLoteHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

function TTipoLoteHelper.ToLongString: String;
begin
  case Self of
    Animal: Result := 'Animal';
    Imovel: Result := 'Imóvel';
    Prenda: Result := 'Prenda';
  end;
end;

function TTipoLoteHelper.ToShortString: String;
begin
  case Self of
    Animal: Result := 'A';
    Imovel: Result := 'I';
    Prenda: Result := 'P';
  end;
end;

{$ENDREGION}

end.
