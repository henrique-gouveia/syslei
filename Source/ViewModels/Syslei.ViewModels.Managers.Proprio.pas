unit Syslei.ViewModels.Managers.Proprio;

interface

uses
  Syslei.Models.Entities.Proprio,
  Syslei.ViewModels.Base.Manager;

type
  TProprioManagerViewModel = class(TManagerViewModelBase<TProprio>)
  private const
    ID_CONTROL_NAME = 'idEdit';
  public
    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject); override;
  end;

implementation

{$REGION 'TProprioManagerViewModel' }

procedure TProprioManagerViewModel.Novo(Sender: TObject);
begin
  inherited;
  ActiveControl := ID_CONTROL_NAME;
end;

procedure TProprioManagerViewModel.Buscar(Sender: TObject);
begin
  inherited;
  Dialog.ShowInformationMessage('Não implementado!');
end;

{$ENDREGION}

end.
