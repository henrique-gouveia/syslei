program Syslei;

uses
  Vcl.Forms,
  Syslei.Models.Entities.Lote in 'Source\Models\Entities\Syslei.Models.Entities.Lote.pas',
  Syslei.Models.Entities.Pessoa in 'Source\Models\Entities\Syslei.Models.Entities.Pessoa.pas',
  Syslei.Modules.Connections.Consts in 'Source\Modules\Syslei.Modules.Connections.Consts.pas',
  Syslei.Modules.Connections.Firebird in 'Source\Modules\Syslei.Modules.Connections.Firebird.pas' {FirebirdConnectionModule: TDataModule},
  Syslei.Modules.Connections.Interfaces in 'Source\Modules\Syslei.Modules.Connections.Interfaces.pas',
  Syslei.PresentationMode.Views.Interfaces in 'Source\PresentationModel\Syslei.PresentationMode.Views.Interfaces.pas',
  Syslei.PresentationMode.Views.Vcl.Forms in 'Source\PresentationModel\Syslei.PresentationMode.Views.Vcl.Forms.pas',
  Syslei.Registrations in 'Source\Registrations\Syslei.Registrations.pas',
  Syslei.Registrations.Connections in 'Source\Registrations\Syslei.Registrations.Connections.pas',
  Syslei.Registrations.Interfaces in 'Source\Registrations\Syslei.Registrations.Interfaces.pas',
  Syslei.Registrations.Modules in 'Source\Registrations\Syslei.Registrations.Modules.pas',
  Syslei.Registrations.Repositories in 'Source\Registrations\Syslei.Registrations.Repositories.pas',
  Syslei.Registrations.SpringRegisters in 'Source\Registrations\Syslei.Registrations.SpringRegisters.pas',
  Syslei.Views.Base in 'Source\View\Syslei.Views.Base.pas' {BaseView},
  Syslei.Views.Base.Finder in 'Source\View\Syslei.Views.Base.Finder.pas' {FinderBaseView},
  Syslei.Views.Base.Filter in 'Source\View\Syslei.Views.Base.Filter.pas' {FilterBaseView},
  Syslei.Views.Base.Manager in 'Source\View\Syslei.Views.Base.Manager.pas' {ManagerBaseView},
  Syslei.Views.Base.Report in 'Source\View\Syslei.Views.Base.Report.pas' {ReportBaseView},
  Syslei.Views.Main in 'Source\View\Syslei.Views.Main.pas' {MainView};

{$R *.res}

begin
  Application.Initialize;
  Application.Run;
end.
