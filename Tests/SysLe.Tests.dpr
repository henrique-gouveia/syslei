program SysLe.Tests;

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
  DUnitX.TestFramework;

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
