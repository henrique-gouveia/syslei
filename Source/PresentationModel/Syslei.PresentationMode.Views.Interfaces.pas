unit Syslei.PresentationMode.Views.Interfaces;

interface

type
  IDataContextable = interface
    ['{65E11043-38A0-41D9-96F9-9CDC3FB40FCE}']
    function GetDataContext: TObject;
    procedure SetDataContext(const value: TObject);
  end;

  IView = interface(IDataContextable)
    ['{AD9ACC1C-85AC-45DE-A585-A11B79A8D9A0}']
    procedure ShowView;
    function ShowModalView: Integer;
  end;

  IReportPreview = interface(IDataContextable)
    ['{8FEF93BE-2D03-4331-99ED-CC8CBF8CCDEA}']
    function Preview: Boolean;
    function PreviewModal: Boolean;
  end;

implementation

end.
