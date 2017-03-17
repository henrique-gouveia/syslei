program Syslei;

uses
  Vcl.Forms,
  Syslei.Models.Entities.Lote in 'Source\Models\Entities\Syslei.Models.Entities.Lote.pas',
  Syslei.Models.Entities.Pessoa in 'Source\Models\Entities\Syslei.Models.Entities.Pessoa.pas',
  Syslei.Views.Main in 'Source\View\Syslei.Views.Main.pas' {MainView};

{$R *.res}

begin
  Application.Initialize;
  Application.Run;
end.
