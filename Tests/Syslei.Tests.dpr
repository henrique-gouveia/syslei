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
  Syslei.Tests.Conversions.ControlString in 'Source\Syslei.Tests.Conversions.ControlString.pas',
  Syslei.Tests.Conversions.Lote.ObjectListDataSet.FireDAC in 'Source\Syslei.Tests.Conversions.Lote.ObjectListDataSet.FireDAC.pas',
  Syslei.Tests.Conversions.Lote.Venda.ObjectListDataSet.FireDAC in 'Source\Syslei.Tests.Conversions.Lote.Venda.ObjectListDataSet.FireDAC.pas',
  Syslei.Tests.Conversions.Proprio.ObjectListDataSet.FireDAC in 'Source\Syslei.Tests.Conversions.Proprio.ObjectListDataSet.FireDAC.pas',
  Syslei.Tests.Finders.Lote.Filter in 'Source\Syslei.Tests.Finders.Lote.Filter.pas',
  Syslei.Tests.Finders.Lote.Simple in 'Source\Syslei.Tests.Finders.Lote.Simple.pas',
  Syslei.Tests.Finders.Lote.Venda.Filter in 'Source\Syslei.Tests.Finders.Lote.Venda.Filter.pas',
  Syslei.Tests.Finders.Pessoa.Simple in 'Source\Syslei.Tests.Finders.Pessoa.Simple.pas',
  Syslei.Tests.Repositories.Lote in 'Source\Syslei.Tests.Repositories.Lote.pas',
  Syslei.Tests.Repositories.Lote.Venda in 'Source\Syslei.Tests.Repositories.Lote.Venda.pas',
  Syslei.Tests.Repositories.Pessoa in 'Source\Syslei.Tests.Repositories.Pessoa.pas',
  Syslei.Tests.Repositories.Proprio in 'Source\Syslei.Tests.Repositories.Proprio.pas',
  Syslei.Tests.TestDB in 'Source\Syslei.Tests.TestDB.pas',
  Syslei.Tests.TestDB.Consts in 'Source\Syslei.Tests.TestDB.Consts.pas',
  Syslei.Tests.TestDB.Lote in 'Source\Syslei.Tests.TestDB.Lote.pas',
  Syslei.Tests.TestDB.Lote.Venda in 'Source\Syslei.Tests.TestDB.Lote.Venda.pas',
  Syslei.Tests.TestSession in 'Source\Syslei.Tests.TestSession.pas',
  Syslei.Tests.Registrations.ResolverTypes in 'Source\Syslei.Tests.Registrations.ResolverTypes.pas';

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
