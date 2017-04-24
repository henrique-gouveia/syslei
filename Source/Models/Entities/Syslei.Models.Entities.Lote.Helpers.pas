{******************************************************************************}
{                                                                              }
{  Copyright (c) 2017, Henrique Gouveia                                        }
{                                                                              }
{  Redistribution and use in source and binary forms, with or without          }
{  modification, are permitted provided that the following conditions are met: }
{                                                                              }
{    1. Redistributions of source code must retain the above copyright notice, }
{    this list of conditions and the following disclaimer.                     }
{                                                                              }
{    2. Redistributions in binary form must reproduce the above copyright      }
{    notice, this list of conditions and the following disclaimer in the       }
{    documentation and/or other materials provided with the distribution.      }
{                                                                              }
{    3. Neither the name of the copyright holder nor the names of its          }
{    contributors may be used to endorse or promote products derived from      }
{    this software without specific prior written permission.                  }
{                                                                              }
{  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" }
{  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE   }
{  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  }
{  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE   }
{  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR         }
{  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF        }
{  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS    }
{  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN     }
{  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)     }
{  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE  }
{  POSSIBILITY OF SUCH DAMAGE.                                                 }
{                                                                              }
{******************************************************************************}

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
