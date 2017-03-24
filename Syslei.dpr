program Syslei;

uses
  Vcl.Forms,
  Vcl.Styles,
  Vcl.Themes,
  Spring.Container,
  Syslei.Conversions.Consts in 'Source\Conversions\Syslei.Conversions.Consts.pas',
  Syslei.Conversions.ControlString in 'Source\Conversions\Syslei.Conversions.ControlString.pas',
  Syslei.Models.Entities.Lote in 'Source\Models\Entities\Syslei.Models.Entities.Lote.pas',
  Syslei.Models.Entities.Lote.Venda in 'Source\Models\Entities\Syslei.Models.Entities.Lote.Venda.pas',
  Syslei.Models.Entities.Pessoa in 'Source\Models\Entities\Syslei.Models.Entities.Pessoa.pas',
  Syslei.Models.Entities.Proprio in 'Source\Models\Entities\Syslei.Models.Entities.Proprio.pas',
  Syslei.Models.Finders.Interfaces in 'Source\Models\Finders\Syslei.Models.Finders.Interfaces.pas',
  Syslei.Models.Finders.Simple in 'Source\Models\Finders\Syslei.Models.Finders.Simple.pas',
  Syslei.Modules.Connections.Consts in 'Source\Modules\Syslei.Modules.Connections.Consts.pas',
  Syslei.Modules.Connections.Firebird in 'Source\Modules\Syslei.Modules.Connections.Firebird.pas' {FirebirdConnectionModule: TDataModule},
  Syslei.Modules.Connections.Interfaces in 'Source\Modules\Syslei.Modules.Connections.Interfaces.pas',
  Syslei.PresentationModel.Dialog in 'Source\PresentationModel\Syslei.PresentationModel.Dialog.pas',
  Syslei.PresentationModel.Dialog.VCL in 'Source\PresentationModel\Syslei.PresentationModel.Dialog.VCL.pas',
  Syslei.PresentationModel.ResourceStrings in 'Source\PresentationModel\Syslei.PresentationModel.ResourceStrings.pas',
  Syslei.PresentationModel.View.Interfaces in 'Source\PresentationModel\Syslei.PresentationModel.View.Interfaces.pas',
  Syslei.PresentationModel.View.VCLForm in 'Source\PresentationModel\Syslei.PresentationModel.View.VCLForm.pas',
  Syslei.Registrations.Connections in 'Source\Registrations\Syslei.Registrations.Connections.pas',
  Syslei.Registrations.Conversions in 'Source\Registrations\Syslei.Registrations.Conversions.pas',
  Syslei.Registrations.Finders in 'Source\Registrations\Syslei.Registrations.Finders.pas',
  Syslei.Registrations.Interfaces in 'Source\Registrations\Syslei.Registrations.Interfaces.pas',
  Syslei.Registrations.Modules in 'Source\Registrations\Syslei.Registrations.Modules.pas',
  Syslei.Registrations in 'Source\Registrations\Syslei.Registrations.pas',
  Syslei.Registrations.Repositories in 'Source\Registrations\Syslei.Registrations.Repositories.pas',
  Syslei.Registrations.SpringRegisters in 'Source\Registrations\Syslei.Registrations.SpringRegisters.pas',
  Syslei.Registrations.ViewModels in 'Source\Registrations\Syslei.Registrations.ViewModels.pas',
  Syslei.Registrations.Views in 'Source\Registrations\Syslei.Registrations.Views.pas',
  Syslei.ViewModels.Base.Domain in 'Source\ViewModels\Syslei.ViewModels.Base.Domain.pas',
  Syslei.ViewModels.Base.Filter in 'Source\ViewModels\Syslei.ViewModels.Base.Filter.pas',
  Syslei.ViewModels.Base.Finder in 'Source\ViewModels\Syslei.ViewModels.Base.Finder.pas',
  Syslei.ViewModels.Base.Manager in 'Source\ViewModels\Syslei.ViewModels.Base.Manager.pas',
  Syslei.ViewModels.Base in 'Source\ViewModels\Syslei.ViewModels.Base.pas',
  Syslei.ViewModels.Base.Report in 'Source\ViewModels\Syslei.ViewModels.Base.Report.pas',
  Syslei.ViewModels.Consts in 'Source\ViewModels\Syslei.ViewModels.Consts.pas',
  Syslei.ViewModels.Finders.Lote in 'Source\ViewModels\Syslei.ViewModels.Finders.Lote.pas',
  Syslei.ViewModels.Finders.Pessoa in 'Source\ViewModels\Syslei.ViewModels.Finders.Pessoa.pas',
  Syslei.ViewModels.Interfaces in 'Source\ViewModels\Syslei.ViewModels.Interfaces.pas',
  Syslei.ViewModels.Main in 'Source\ViewModels\Syslei.ViewModels.Main.pas',
  Syslei.ViewModels.Managers.Lote in 'Source\ViewModels\Syslei.ViewModels.Managers.Lote.pas',
  Syslei.ViewModels.Managers.Lote.Venda in 'Source\ViewModels\Syslei.ViewModels.Managers.Lote.Venda.pas',
  Syslei.ViewModels.Managers.Pessoa in 'Source\ViewModels\Syslei.ViewModels.Managers.Pessoa.pas',
  Syslei.ViewModels.Managers.Proprio in 'Source\ViewModels\Syslei.ViewModels.Managers.Proprio.pas',
  Syslei.Views.Base in 'Source\Views\Syslei.Views.Base.pas' {BaseView},
  Syslei.Views.Base.Filter in 'Source\Views\Syslei.Views.Base.Filter.pas' {FilterBaseView},
  Syslei.Views.Base.Finder in 'Source\Views\Syslei.Views.Base.Finder.pas' {FinderBaseView},
  Syslei.Views.Base.Manager in 'Source\Views\Syslei.Views.Base.Manager.pas' {ManagerBaseView},
  Syslei.Views.Base.Report in 'Source\Views\Syslei.Views.Base.Report.pas' {ReportBaseView},
  Syslei.Views.Consts in 'Source\Views\Syslei.Views.Consts.pas',
  Syslei.Views.Finders.Lote in 'Source\Views\Syslei.Views.Finders.Lote.pas' {LoteFinderView},
  Syslei.Views.Finders.Pessoa in 'Source\Views\Syslei.Views.Finders.Pessoa.pas' {PessoaFinderView},
  Syslei.Views.Main in 'Source\Views\Syslei.Views.Main.pas' {MainView},
  Syslei.Views.Managers.Lote in 'Source\Views\Syslei.Views.Managers.Lote.pas' {LoteManagerView},
  Syslei.Views.Managers.Lote.Venda in 'Source\Views\Syslei.Views.Managers.Lote.Venda.pas' {VendaLoteManagerView},
  Syslei.Views.Managers.Pessoa in 'Source\Views\Syslei.Views.Managers.Pessoa.pas' {PessoaManagerView},
  Syslei.Views.Reports.Venda.Promissoria in 'Source\Views\Syslei.Views.Reports.Venda.Promissoria.pas' {PromissoriaVendaReportView};

{$R *.res}

begin
  TStyleManager.TrySetStyle('Amethyst Kamri');
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  RegisterTypes();

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.HintPause := 10000;

  GlobalContainer.Resolve<TFirebirdConnectionModule>();
  GlobalContainer.Resolve<TMainView>();

  Application.Run;
end.
