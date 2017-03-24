unit Syslei.ViewModels.Managers.Proprio;

interface

uses
  Syslei.Models.Entities.Proprio,
  Syslei.ViewModels.Base.Manager;

type
  TProprioManagerViewModel = class(TManagerViewModelBase<TProprio>)
  private const
    ID_CONTROL_NAME = 'idEdit';
    NOME_CONTROL_NAME = 'nomeEdit';
  protected
    function Validate: Boolean; override;
  public
    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject); override;
  end;

implementation

uses
  System.SysUtils,
  Syslei.PresentationModel.ResourceStrings;


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

function TProprioManagerViewModel.Validate: Boolean;
begin
  Result := True;

  if (Entity.Nome.IsEmpty()) then
  begin
    Dialog.ShowWarningMessage(Format(SCampoObrigatorio, ['Nome']));
    ActiveControl := NOME_CONTROL_NAME;
    Exit(False);
  end;

end;

{$ENDREGION}

end.
