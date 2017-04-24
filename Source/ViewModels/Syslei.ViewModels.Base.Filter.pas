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

unit Syslei.ViewModels.Base.Filter;

interface

uses
  Syslei.Models.Finders.Interfaces,
  Syslei.ViewModels.Base,
  Syslei.ViewModels.Interfaces,
  Spring.Collections,
  Spring.Container.Common;

type
  TFilterViewModelBase<TEntity, TFilter: class, constructor> = class(TViewModelBase, IFilterViewModel)
  private
    [Inject]
    FEntityFinder: IEntityFinder<TEntity, TFilter>;
    FEntities: IObjectList;
    FFilter: TFilter;

    function GetEntities: IObjectList;
    procedure SetEntities(const Value: IObjectList);
    function GetFilter: TFilter;
    procedure SetFilter(const Value: TFilter);
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure Novo(Sender: TObject); virtual;
    procedure Ok(Sender: TObject); virtual;
    procedure Executar(Sender: TObject); virtual;

    property Entities: IObjectList read GetEntities write SetEntities;
    property Filter: TFilter read GetFilter write SetFilter;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TFilterViewModelBase<TEntity, TFilter>' }

destructor TFilterViewModelBase<TEntity, TFilter>.Destroy;
begin
  FreeAndNil(FFilter);
  inherited;
end;

procedure TFilterViewModelBase<TEntity, TFilter>.AfterConstruction;
begin
  inherited;
  Novo(Self);
end;

procedure TFilterViewModelBase<TEntity, TFilter>.Novo(Sender: TObject);
begin
  FEntities := nil;
  Filter := nil;
end;

procedure TFilterViewModelBase<TEntity, TFilter>.Ok(Sender: TObject);
begin
  Executar(Self);
end;

procedure TFilterViewModelBase<TEntity, TFilter>.Executar(Sender: TObject);
begin
  Entities := FEntityFinder.Find(Filter) as IObjectList;
end;

function TFilterViewModelBase<TEntity, TFilter>.GetEntities: IObjectList;
begin
  Result := FEntities;
end;

procedure TFilterViewModelBase<TEntity, TFilter>.SetEntities(const Value: IObjectList);
begin
  if Assigned(Value) then
    FEntities := Value
  else
    FEntities := TCollections.CreateObjectList<TObject>() as IObjectList;

  DoPropertyChanged('Entities');
end;

function TFilterViewModelBase<TEntity, TFilter>.GetFilter: TFilter;
begin
  Result := FFilter;
end;

procedure TFilterViewModelBase<TEntity, TFilter>.SetFilter(const Value: TFilter);
begin
  if Assigned(FFilter) then
    FreeAndNil(FFilter);

  if Assigned(Value) then
    FFilter := Value
  else
    FFilter := TFilter.Create;

  DoPropertyChanged('Filter');
end;

{$ENDREGION}

end.
