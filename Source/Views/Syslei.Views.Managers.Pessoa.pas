unit Syslei.Views.Managers.Pessoa;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.Actions,
  System.SysUtils,
  System.Variants,
  System.Classes,
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
  Vcl.Mask,
  Vcl.StdCtrls,
  Vcl.Grids,

  Syslei.ViewModels.Consts,
  Syslei.Views.Base.Manager,

  DSharp.Bindings,
  DSharp.Bindings.VCLControls,

  Spring,
  Spring.Container.Common;

type
  TPessoaManagerView = class(TManagerBaseView)
    idLabel: TLabel;
    idEdit: TEdit;
    nomeLabel: TLabel;
    nomeEdit: TEdit;
    cpfLabel: TLabel;
    cpfMask: TMaskEdit;
    dtCadastroLabel: TLabel;
    dtCadastroDtp: TDateTimePicker;
    bindings: TBindingGroup;
    procedure FormDestroy(Sender: TObject);
  private
    procedure ConfigureBind;
  protected
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(PESSOA_MANAGER_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  Spring.Container,
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts;

{$REGION 'TPessoaManagerView' }

procedure TPessoaManagerView.FormDestroy(Sender: TObject);
begin
  GlobalContainer.Release(DataContext);
end;

procedure TPessoaManagerView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TPessoaManagerView.ConfigureBind;
var
  binding: TBinding;
begin
  bindings.AddBinding(DataContext, 'ActiveControl', Self, 'ActiveControl', bmOneWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_CONTROL_STRING_NAME, [Self]));

  binding := bindings.AddBinding(DataContext, 'EntityId', idEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;

  bindings.AddBinding(DataContext, 'Entity.Id', idEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.Nome', nomeEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.CPF', cpfMask, 'Text');
  bindings.AddBinding(DataContext, 'Entity.DataCadastro', dtCadastroDtp, 'Date', bmOneWay);
end;

{$ENDREGION}

end.
