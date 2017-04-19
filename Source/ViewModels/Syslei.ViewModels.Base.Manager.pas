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
