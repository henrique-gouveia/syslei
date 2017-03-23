unit Syslei.Views.Managers.Lote;

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
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Grids,

  Syslei.ViewModels.Consts,
  Syslei.Views.Base.Manager,

  DSharp.Bindings.VCLControls,
  DSharp.Bindings,

  Spring,
  Spring.Container.Common;

type
  TLoteManagerView = class(TManagerBaseView)
    idLabel: TLabel;
    idEdit: TEdit;
    numeroLoteLabel: TLabel;
    numeroLoteEdit: TEdit;
    descricaoLabel: TLabel;
    descricaoEdit: TEdit;
    dtCadastroLabel: TLabel;
    dtCadastroDtp: TDateTimePicker;
    doadorGroup: TGroupBox;
    doadorIdLabel: TLabel;
    doadorIdEdit: TEdit;
    doadorNomeLabel: TLabel;
    doadorNomeEdit: TEdit;
    lanceInicialLabel: TLabel;
    lanceInicialEdit: TEdit;
    statusLabel: TLabel;
    statusCombo: TComboBox;
    tipoLabel: TLabel;
    tipoCombo: TComboBox;
    idadeLabel: TLabel;
    idadeEdit: TEdit;
    sexoGroup: TRadioGroup;
    bindings: TBindingGroup;
    procedure FormDestroy(Sender: TObject);
  private
    procedure ConfigureBind;
  protected
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(LOTE_MANAGER_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  Spring.Container,
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts;

{$REGION 'TLoteManagerView' }

procedure TLoteManagerView.FormDestroy(Sender: TObject);
begin
  inherited;
  GlobalContainer.Release(DataContext);
end;

procedure TLoteManagerView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TLoteManagerView.ConfigureBind;
var
  binding: TBinding;
begin
  bindings.AddBinding(DataContext, 'ActiveControl', Self, 'ActiveControl', bmOneWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_CONTROL_STRING_NAME, [Self]));

  binding := bindings.AddBinding(DataContext, 'EntityId', idEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;

  binding := bindings.AddBinding(DataContext, 'DoadorId', doadorIdEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;
  bindings.AddBinding(DataContext, 'Doador.Id', doadorIdEdit, 'Text', bmOneWay);
  bindings.AddBinding(DataContext, 'Doador.Nome', doadorNomeEdit, 'Text', bmOneWay);

  bindings.AddBinding(DataContext, 'Entity.Id', idEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.Numero', numeroLoteEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.Descricao', descricaoEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.DataCadastro', dtCadastroDtp, 'Date', bmOneWay);

  binding := bindings.AddBinding(DataContext, 'Entity.DoadorId', doadorIdEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;

  bindings.AddBinding(DataContext, 'Entity.LanceInicial', lanceInicialEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.Status', statusCombo, 'ItemIndex');
  bindings.AddBinding(DataContext, 'Entity.Tipo', tipoCombo, 'ItemIndex');
  bindings.AddBinding(DataContext, 'Entity.Idade', idadeEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.Sexo', sexoGroup, 'ItemIndex');

  bindings.AddBinding(DataContext, 'TipoLote', tipoCombo, 'ItemIndex', bmOneWayToSource);
  bindings.AddBinding(DataContext, 'IsAnimalLote', idadeLabel, 'Visible', bmOneWay);
  bindings.AddBinding(DataContext, 'IsAnimalLote', idadeEdit, 'Visible', bmOneWay);
  bindings.AddBinding(DataContext, 'IsAnimalLote', sexoGroup, 'Visible', bmOneWay);
end;

{$ENDREGION}

end.
