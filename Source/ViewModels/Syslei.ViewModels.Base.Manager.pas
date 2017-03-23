unit Syslei.ViewModels.Base.Manager;

interface

uses
  Syslei.ViewModels.Base,
  Syslei.ViewModels.Interfaces,

  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Criteria.Interfaces;

type
  TManagerViewModelBase<TEntity: class, constructor> = class(TViewModelBase, IManagerViewModel<TEntity>)
  private
    FEntity: TEntity;
    FEntityId: Integer;
    [Inject]
    FEntityRepository: IPagedRepository<TEntity, Integer>;
  protected
    function GetEntity: TEntity; virtual;
    procedure SetEntity(const Value: TEntity); virtual;
    procedure SetEntityId(const Value: Integer); virtual;

    property EntityRepository: IPagedRepository<TEntity, Integer> read FEntityRepository;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure Novo(Sender: TObject); virtual;
    procedure Gravar(Sender: TObject); virtual;
    procedure Excluir(Sender: TObject); virtual;
    procedure Buscar(Sender: TObject); virtual; abstract;

    property Entity: TEntity read GetEntity write SetEntity;
    property EntityId: Integer write SetEntityId;
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
  Novo(Self);
end;

procedure TManagerViewModelBase<TEntity>.Novo(Sender: TObject);
begin
  Entity := TEntity.Create;
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

        Dialog.ShowInformationMessage('Registro gravado com sucesso.');
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

        Dialog.ShowInformationMessage('Registro excluído com sucesso.');
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

  FEntity := Value;

  if Assigned(FEntity) then
    DoPropertyChanged('Entity');
end;

procedure TManagerViewModelBase<TEntity>.SetEntityId(const Value: Integer);
begin
  if FEntityId <> Value then
  begin
    FEntityId := Value;
    Entity := FEntityRepository.FindOne(FEntityId);

    if not Assigned(Entity) then
      Entity := TEntity.Create;
  end;
end;

{$ENDREGION}

end.
