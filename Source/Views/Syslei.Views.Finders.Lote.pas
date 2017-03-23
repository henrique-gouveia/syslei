unit Syslei.Views.Finders.Lote;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.ImageList,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,

  Data.DB,

  Syslei.ViewModels.Consts,
  Syslei.Views.Base.Finder,

  DSharp.Bindings,
  DSharp.Bindings.VCLControls,

  Spring,
  Spring.Collections,
  Spring.Container.Common,
  Spring.Data.VirtualDataSet,
  Spring.Data.ObjectDataSet;

type
  TLoteFinderView = class(TFinderBaseView)
    dataSet: TObjectDataSet;
    dataSetId: TIntegerField;
    dataSetDataCadastro: TDateField;
    bindings: TBindingGroup;
    dataSetNumero: TStringField;
    dataSetDescricao: TStringField;
    dataSetLanceInicial: TFloatField;
    procedure FormDestroy(Sender: TObject);
    procedure OkExecute(Sender: TObject);
  private
    FModelBind: TBinding;
    procedure ConfigureBind;
    function GetModel: TObject;
  protected
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(LOTE_FINDER_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
    property Model: TObject read GetModel;  end;

implementation

{$R *.dfm}

uses
  Spring.Container;

{$REGION 'TLoteFinderView' }

procedure TLoteFinderView.FormDestroy(Sender: TObject);
begin
  inherited;
  GlobalContainer.Release(DataContext);
end;

function TLoteFinderView.GetModel: TObject;
begin
  Result := dataSet.GetCurrentModel<TObject>();
end;

procedure TLoteFinderView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TLoteFinderView.ConfigureBind;
begin
  bindings.AddBinding(DataContext, 'SearchProperties', propertyNameCombo, 'View.ItemsSource', bmOneWay);

  bindings.AddBinding(DataContext, 'SearchProperty.Name', propertyNameCombo, 'View.CurrentItem.Name', bmOneWayToSource)
    .UpdateSource();
  bindings.AddBinding(DataContext, 'SearchProperty.Value', propertyValueEdit, 'Text', bmOneWayToSource);

  bindings.AddBinding(DataContext, 'Entities', dataSet, 'DataList', bmOneWay);

  FModelBind := bindings.AddBinding(DataContext, 'Entity', Self, 'Model', bmOneWayToSource);
  FModelBind.SourceUpdateTrigger := utExplicit;
end;

procedure TLoteFinderView.OkExecute(Sender: TObject);
begin
  inherited;
  if ModalResult = mrOk then
    FModelBind.UpdateSource();
end;

{$ENDREGION}

end.
