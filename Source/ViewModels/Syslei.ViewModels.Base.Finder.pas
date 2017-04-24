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

unit Syslei.ViewModels.Base.Finder;

interface

uses
  Syslei.Models.Finders.Interfaces,
  Syslei.ViewModels.Base,
  Syslei.ViewModels.Base.Domain,
  Syslei.ViewModels.Interfaces,

  Spring.Collections,
  Spring.Container.Common;

type
  TFinderViewModelBase<TEntity: class, constructor> = class(TViewModelBase, IFinderViewModel<TEntity>)
  private
    FEntity: TEntity;
    FEntities: IObjectList;
    [Inject]
    FEntityFinder: IEntityFinder<TEntity>;

    FSearchProperty: TPropertyData;
    FSearchProperties: IObjectList;

    function GetEntity: TEntity;
    procedure SetEntity(const Value: TEntity);

    function GetEntities: IObjectList;
    procedure SetEntities(const Value: IObjectList);

    procedure SetSearchProperty(const Value: TPropertyData); virtual;
  protected
    property EntityFinder: IEntityFinder<TEntity> read FEntityFinder;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure Novo(Sender: TObject); virtual;
    procedure Avulsa(Sender: TObject); virtual;
    procedure Inicial(Sender: TObject); virtual;
    procedure Exata(Sender: TObject); virtual;

    property Entity: TEntity read GetEntity write SetEntity;
    property Entities: IObjectList read GetEntities write SetEntities;

    property SearchProperty: TPropertyData read FSearchProperty write SetSearchProperty;
    property SearchProperties: IObjectList read FSearchProperties;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TFinderViewModelBase<TEntity>' }

destructor TFinderViewModelBase<TEntity>.Destroy;
begin
  FreeAndNil(FSearchProperty);
  inherited;
end;

procedure TFinderViewModelBase<TEntity>.AfterConstruction;
begin
  inherited;
  FSearchProperty := TPropertyData.Create;
  FSearchProperties := TCollections.CreateObjectList<TPropertyData>() as IObjectList;
  Novo(Self);
end;

procedure TFinderViewModelBase<TEntity>.Novo(Sender: TObject);
begin
  Entity := nil;
  Entities := nil;
end;

procedure TFinderViewModelBase<TEntity>.Avulsa(Sender: TObject);
begin
  Entities := EntityFinder.FindLikeAnyware(SearchProperty.Name, SearchProperty.Value) as IObjectList;
end;

procedure TFinderViewModelBase<TEntity>.Inicial(Sender: TObject);
begin
  Entities := EntityFinder.FindLikeStart(SearchProperty.Name, SearchProperty.Value) as IObjectList;
end;

procedure TFinderViewModelBase<TEntity>.Exata(Sender: TObject);
begin
  Entities := EntityFinder.FindEqual(SearchProperty.Name, SearchProperty.Value) as IObjectList;
end;

function TFinderViewModelBase<TEntity>.GetEntity: TEntity;
begin
  Result := FEntity;
end;

procedure TFinderViewModelBase<TEntity>.SetEntity(const Value: TEntity);
begin
  FEntity := Value
end;

function TFinderViewModelBase<TEntity>.GetEntities: IObjectList;
begin
  Result := FEntities;
end;

procedure TFinderViewModelBase<TEntity>.SetEntities(const Value: IObjectList);
begin
  if Assigned(Value) then
    FEntities := Value
  else
    FEntities := TCollections.CreateObjectList<TEntity>() as IObjectList;

  DoPropertyChanged('Entities');
end;

procedure TFinderViewModelBase<TEntity>.SetSearchProperty(const Value: TPropertyData);
begin
  if Assigned(FSearchProperty) then
    FreeAndNil(FSearchProperty);
  FSearchProperty := Value;
end;

{$ENDREGION}

end.
