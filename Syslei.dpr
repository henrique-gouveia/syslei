program Syslei;

uses
  Vcl.Forms,
  Syslei.Models.Entities.Lote in 'Source\Models\Entities\Syslei.Models.Entities.Lote.pas',
  Syslei.Models.Entities.Pessoa in 'Source\Models\Entities\Syslei.Models.Entities.Pessoa.pas',
  Syslei.Modules.Connections.Consts in 'Source\Modules\Syslei.Modules.Connections.Consts.pas',
  Syslei.Modules.Connections.Firebird in 'Source\Modules\Syslei.Modules.Connections.Firebird.pas' {FirebirdConnectionModule: TDataModule},
  Syslei.Modules.Connections.Interfaces in 'Source\Modules\Syslei.Modules.Connections.Interfaces.pas',
  Syslei.Registrations in 'Source\Registrations\Syslei.Registrations.pas',
  Syslei.Registrations.Connections in 'Source\Registrations\Syslei.Registrations.Connections.pas',
  Syslei.Registrations.Interfaces in 'Source\Registrations\Syslei.Registrations.Interfaces.pas',
  Syslei.Registrations.Modules in 'Source\Registrations\Syslei.Registrations.Modules.pas',
  Syslei.Registrations.Repositories in 'Source\Registrations\Syslei.Registrations.Repositories.pas',
  Syslei.Registrations.SpringRegisters in 'Source\Registrations\Syslei.Registrations.SpringRegisters.pas',
  Syslei.Views.Main in 'Source\View\Syslei.Views.Main.pas' {MainView};


{$R *.res}

begin
  Application.Initialize;
  Application.Run;
end.
