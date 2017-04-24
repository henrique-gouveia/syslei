unit Syslei.Tests.TestDB.Helpers;

interface

type
  TDateHelper = record Helper for TDate
  private const
    FORMAT_DATE_ISO = 'yyyy-mm-dd';
    FORMAT_DATE_USA = 'mm/dd/yyyy';
    FORMAT_DATE_EUR = 'dd.mm.yyyy';
  public
    function ToDateISOString: String;
    function ToDateUSAString: String;
    function ToDateEURString: String;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TDateHelper' }

function TDateHelper.ToDateISOString: String;
begin
  Result := FormatDateTime(FORMAT_DATE_ISO, Self);
end;

function TDateHelper.ToDateUSAString: String;
begin
  Result := FormatDateTime(FORMAT_DATE_USA, Self);
end;

function TDateHelper.ToDateEURString: String;
begin
  Result := FormatDateTime(FORMAT_DATE_EUR, Self);
end;

{$ENDREGION}

end.
