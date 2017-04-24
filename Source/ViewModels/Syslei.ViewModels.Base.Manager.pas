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

unit Syslei.ViewModels.Base.Manager;

interface

uses
  System.Classes,
  Syslei.ViewModels.Base,
  Syslei.ViewModels.Interfaces,

  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Criteria.Interfaces;

type
  TAfterSaveAction = reference to procedure;
  TAfterDeleteAction = reference to procedure;

  TManagerViewModelBase<TEntity: class, constructor> = class(TViewModelBase, IManagerViewModel<TEntity>)
  private
    FEntity: TEntity;
    FEntityId: Integer;
    [Inject]
    FEntityRepository: IPagedRepository<TEntity, Integer>;

    FAfterSaveAction: TAfterSaveAction;
    FAfterDeleteAction: TAfterDeleteAction;
  protected
    function GetEntity: TEntity; virtual;
    procedure SetEntity(const Value: TEntity); virtual;
    procedure SetEntityId(const Value: Integer); virtual;

    property EntityRepository: IPagedRepository<TEntity, Integer> read FEntityRepository;

    property AfterSaveAction: TAfterSaveAction read FAfterSaveAction write FAfterSaveAction;
    property AfterDeleteAction: TAfterDeleteAction read FAfterDeleteAction write FAfterDeleteAction;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure Novo(Sender: TObject); virtual;
    procedure Gravar(Sender: TObject); virtual;
    procedure Excluir(Sender: TObject); virtual;
    procedure Buscar(Sender: TObject); virtual; abstract;

    property Entity: TEntity read GetEntity write SetEntity;
    property EntityId: Integer read FEntityId write SetEntityId;
  end;

implementation

uses
  System.SysUtils,
  Syslei.PresentationModel.Dialog;

{$REGION 'TManagerViewModelBase<TEntity>' }

destructor TManagerViewModelBase<TEntity>.Destroy;
begin
  FEntity.Free;
  inherited;
end;

procedure TManagerViewModelBase<TEntity>.AfterConstruction;
begin
  inherited;
  AfterSaveAction :=
    procedure
    begin
      Dialog.ShowInformationMessage('Registro gravado com sucesso.');
    end;

  AfterDeleteAction :=
    procedure
    begin
      Dialog.ShowInformationMessage('Registro excluído com sucesso.');
    end;

  Novo(Self);
end;

procedure TManagerViewModelBase<TEntity>.Novo(Sender: TObject);
begin
  Entity := nil;
  EntityId := 0;
end;

procedure TManagerViewModelBase<TEntity>.Gravar(Sender: TObject);
begin
  if not Validate() then
    Abort;

  Dialog.ShowConfirmationMessage('Confirma gravar Registro ?',
    procedure(const result: TModalResult)
    begin
      if (result = mrYes) then
      try
        FEntityRepository.Save(FEntity);
        if Assigned(AfterSaveAction) then
          AfterSaveAction();
        Novo(Sender);
      except
        Dialog.ShowErrorMessage('Erro ao tentar gravar o registro!');
      end;
    end);
end;

procedure TManagerViewModelBase<TEntity>.Excluir(Sender: TObject);
begin
  Dialog.ShowConfirmationMessage('Confirma exclusão desse registro ?',
    procedure(const result: TModalResult)
    begin
      if (result = mrYes) then
      try
        FEntityRepository.Delete(FEntity);
        if Assigned(AfterDeleteAction) then
          AfterDeleteAction();
        Novo(Sender);
      except
        Dialog.ShowErrorMessage('Erro ao tentar excluir o registro.');
      end;
    end);
end;

function TManagerViewModelBase<TEntity>.GetEntity: TEntity;
begin
  Result := FEntity;
end;

procedure TManagerViewModelBase<TEntity>.SetEntity(const Value: TEntity);
begin
  if Assigned(FEntity) then
    FreeAndNil(FEntity);

  if Assigned(Value) then
    FEntity := Value
  else
    FEntity := TEntity.Create;

  DoPropertyChanged('Entity');
end;

procedure TManagerViewModelBase<TEntity>.SetEntityId(const Value: Integer);
begin
  if (FEntityId <> Value) then
  begin
    FEntityId := Value;
    Entity := FEntityRepository.FindOne(FEntityId);
  end;
end;

{$ENDREGION}

end.
