program Syslei.Tests;

{$IFNDEF TESTINSIGHT}
  {$APPTYPE GUI}
{$ENDIF}

{$STRONGLINKTYPES ON}

uses
  System.SysUtils,
  Forms,
  Graphics,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.GUI.VCL,
  DUnitX.TestFramework,
  Syslei.Tests.Repositories.Lote in 'Source\Syslei.Tests.Repositories.Lote.pas',
  Syslei.Tests.Repositories.Pessoa in 'Source\Syslei.Tests.Repositories.Pessoa.pas',
  Syslei.Tests.Registrations.ContainerResolver in 'Source\Syslei.Tests.Registrations.ContainerResolver.pas',
  Syslei.Tests.TestDB in 'Source\Syslei.Tests.TestDB.pas',
  Syslei.Tests.TestDB.Consts in 'Source\Syslei.Tests.TestDB.Consts.pas',
  Syslei.Tests.TestSession in 'Source\Syslei.Tests.TestSession.pas';

begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  Exit;
{$ENDIF}
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.CreateForm(TGUIVCLTestRunner, GUIVCLTestRunner);
  Application.Run;
end.
