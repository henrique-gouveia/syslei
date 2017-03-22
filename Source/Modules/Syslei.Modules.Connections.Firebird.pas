unit Syslei.Modules.Connections.Firebird;

interface

uses
  System.SysUtils,
  System.Classes,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.IBBase,
  FireDAC.Comp.UI,

  Syslei.Modules.Connections.Interfaces;

type
  TFirebirdConnectionModule = class(TDataModule, IConnectionModule<TFDConnection>)
    SysleiConnection: TFDConnection;
    guixWaitCursor: TFDGUIxWaitCursor;
    firebirdDriverLink: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  protected
    function GetConnection: TFDConnection; virtual;
    function GetDriverName: String; virtual;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{$REGION 'TFirebirdConnectionModule' }

procedure TFirebirdConnectionModule.DataModuleCreate(Sender: TObject);
begin
  {$IFDEF FIREBIRD_DB}
  SysleiConnection.Connected := True;
  {$ENDIF}
end;

function TFirebirdConnectionModule.GetConnection: TFDConnection;
begin
  Result := SysleiConnection;
end;

function TFirebirdConnectionModule.GetDriverName: String;
begin
  Result := SysleiConnection.DriverName;
end;

{$ENDREGION}

end.
