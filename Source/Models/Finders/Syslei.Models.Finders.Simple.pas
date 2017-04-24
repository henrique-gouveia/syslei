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

unit Syslei.Models.Finders.Simple;

interface

uses
  Syslei.Models.Finders.Interfaces,
  Spring,
  Spring.Collections,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Criteria.Interfaces;

type
  TSimpleEntityFinder<TEntity: class, constructor; TID> = class(TInterfacedObject, IEntityFinder<TEntity>)
  private
    FEntityRepository: IPagedRepository<TEntity,TID>;
  protected
    function FindEqual(const propertyName: String; const propertyValue: TValue): IList<TEntity>; virtual;
    function FindLikeAnyware(const propertyName: String; const propertyValue: TValue): IList<TEntity>; virtual;
    function FindLikeStart(const propertyName: String; const propertyValue: TValue): IList<TEntity>; virtual;

    property EntityRepository: IPagedRepository<TEntity,TID> read FEntityRepository;
  public
    constructor Create(const entityRepository: IPagedRepository<TEntity,TID>); virtual;
  end;

implementation

uses
  Spring.Persistence.Criteria.Restrictions,
  Spring.Persistence.SQL.Types;

{$REGION 'TSimpleEntityFinder<T, TID>' }

constructor TSimpleEntityFinder<TEntity, TID>.Create(const entityRepository: IPagedRepository<TEntity,TID>);
begin
  inherited Create;
  FEntityRepository := entityRepository;
end;

function TSimpleEntityFinder<TEntity, TID>.FindEqual(const propertyName: String;
  const propertyValue: TValue): IList<TEntity>;
begin
  Result := FEntityRepository
              .FindWhere(
                Restrictions.Eq(
                  propertyName,
                  propertyValue)
              );
end;

function TSimpleEntityFinder<TEntity, TID>.FindLikeAnyware(const propertyName: String;
  const propertyValue: TValue): IList<TEntity>;
begin
  Result := FEntityRepository
              .FindWhere(
                Restrictions.Like(
                  propertyName,
                  propertyValue.AsString,
                  mmAnywhere)
              );
end;

function TSimpleEntityFinder<TEntity, TID>.FindLikeStart(const propertyName: String;
  const propertyValue: TValue): IList<TEntity>;
begin
  Result := FEntityRepository
              .FindWhere(
                Restrictions.Like(
                  propertyName,
                  propertyValue.AsString,
                  mmStart)
              );
end;

{$ENDREGION}

end.
