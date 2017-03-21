program Syslei;

uses
  Vcl.Forms,
  Syslei.Models.Entities.Lote in 'Source\Models\Entities\Syslei.Models.Entities.Lote.pas',
  Syslei.Models.Entities.Pessoa in 'Source\Models\Entities\Syslei.Models.Entities.Pessoa.pas',
  Syslei.Models.Finders.Interfaces in 'Source\Models\Finders\Syslei.Models.Finders.Interfaces.pas',
  Syslei.Models.Finders.Simple in 'Source\Models\Finders\Syslei.Models.Finders.Simple.pas',
  Syslei.Modules.Connections.Consts in 'Source\Modules\Syslei.Modules.Connections.Consts.pas',
  Syslei.Modules.Connections.Firebird in 'Source\Modules\Syslei.Modules.Connections.Firebird.pas' {FirebirdConnectionModule: TDataModule},
  Syslei.Modules.Connections.Interfaces in 'Source\Modules\Syslei.Modules.Connections.Interfaces.pas',
  Syslei.PresentationModel.Dialog in 'Source\PresentationModel\Syslei.PresentationModel.Dialog.pas',
  Syslei.PresentationModel.Dialog.VCL in 'Source\PresentationModel\Syslei.PresentationModel.Dialog.VCL.pas',
  Syslei.PresentationModel.View.Interfaces in 'Source\PresentationModel\Syslei.PresentationModel.View.Interfaces.pas',
  Syslei.PresentationModel.View.VCLForm in 'Source\PresentationModel\Syslei.PresentationModel.View.VCLForm.pas',
  Syslei.Registrations in 'Source\Registrations\Syslei.Registrations.pas',
  Syslei.Registrations.Connections in 'Source\Registrations\Syslei.Registrations.Connections.pas',
  Syslei.Registrations.Finders in 'Source\Registrations\Syslei.Registrations.Finders.pas',
  Syslei.Registrations.Interfaces in 'Source\Registrations\Syslei.Registrations.Interfaces.pas',
  Syslei.Registrations.Modules in 'Source\Registrations\Syslei.Registrations.Modules.pas',
  Syslei.Registrations.Repositories in 'Source\Registrations\Syslei.Registrations.Repositories.pas',
  Syslei.Registrations.SpringRegisters in 'Source\Registrations\Syslei.Registrations.SpringRegisters.pas',
  Syslei.ViewModels.Interfaces in 'Source\ViewModels\Syslei.ViewModels.Interfaces.pas',
  Syslei.ViewModels.Base in 'Source\ViewModels\Syslei.ViewModels.Base.pas',
  Syslei.ViewModels.Base.Domain in 'Source\ViewModels\Syslei.ViewModels.Base.Domain.pas',
  Syslei.ViewModels.Base.Filter in 'Source\ViewModels\Syslei.ViewModels.Base.Filter.pas',
  Syslei.ViewModels.Base.Finder in 'Source\ViewModels\Syslei.ViewModels.Base.Finder.pas',
  Syslei.ViewModels.Base.Manager in 'Source\ViewModels\Syslei.ViewModels.Base.Manager.pas',
  Syslei.ViewModels.Base.Report in 'Source\ViewModels\Syslei.ViewModels.Base.Report.pas',
  Syslei.Views.Base in 'Source\Views\Syslei.Views.Base.pas' {BaseView},
  Syslei.Views.Base.Finder in 'Source\Views\Syslei.Views.Base.Finder.pas' {FinderBaseView},
  Syslei.Views.Base.Filter in 'Source\Views\Syslei.Views.Base.Filter.pas' {FilterBaseView},
  Syslei.Views.Base.Manager in 'Source\Views\Syslei.Views.Base.Manager.pas' {ManagerBaseView},
  Syslei.Views.Base.Report in 'Source\Views\Syslei.Views.Base.Report.pas' {ReportBaseView},
  Syslei.Views.Main in 'Source\Views\Syslei.Views.Main.pas' {MainView};

{$R *.res}

begin
  Application.Initialize;
  Application.Run;
end.
