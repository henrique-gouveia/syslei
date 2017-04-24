{******************************************************************************}
{                                                                              }
{  Copyright (c) 2017, Henrique Gouveia                                        }
{                                                                              }
{  Redistribution and use in source and binary forms, with or without          }
{  modification, are permitted provided that the following conditions are met: }
{                                                                              }
{    1. Redistributions of source code must retain the above copyright notice, }
{    this list of conditions and the following disclaimer.                     }
{                                                                              }
{    2. Redistributions in binary form must reproduce the above copyright      }
{    notice, this list of conditions and the following disclaimer in the       }
{    documentation and/or other materials provided with the distribution.      }
{                                                                              }
{    3. Neither the name of the copyright holder nor the names of its          }
{    contributors may be used to endorse or promote products derived from      }
{    this software without specific prior written permission.                  }
{                                                                              }
{  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" }
{  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE   }
{  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  }
{  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE   }
{  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR         }
{  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF        }
{  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS    }
{  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN     }
{  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)     }
{  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE  }
{  POSSIBILITY OF SUCH DAMAGE.                                                 }
{                                                                              }
{******************************************************************************}

unit Syslei.Views.Managers.Lote.Venda;

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
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Grids,

  Syslei.ViewModels.Consts,
  Syslei.Views.Base.Manager,

  DSharp.Bindings,
  DSharp.Bindings.VCLControls,

  Spring,
  Spring.Container.Common;

type
  TVendaLoteManagerView = class(TManagerBaseView)
    idLabel: TLabel;
    idEdit: TEdit;
    dataLabel: TLabel;
    dataDtp: TDateTimePicker;
    compradorGroup: TGroupBox;
    compradorIdEdit: TEdit;
    compradorNomeEdit: TEdit;
    loteGroup: TGroupBox;
    loteIdEdit: TEdit;
    loteDescricaoEdit: TEdit;
    lanceArremateLabel: TLabel;
    Promissoria: TAction;
    promissoriaButton: TSpeedButton;
    bindings: TBindingGroup;
    lanceArremateEdit: TEdit;
    procedure FormDestroy(Sender: TObject);
    procedure LoteIdEditExit(Sender: TObject);
  private
    procedure ConfigureBind;
  protected
    procedure ActiveChanged; override;
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(VENDA_LOTE_MANAGER_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  Spring.Container,
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts;

{$REGION 'TVendaLoteManagerView' }

procedure TVendaLoteManagerView.ActiveChanged;
begin
  inherited;
  bindings.GetBindingForTarget(Self).UpdateSource();
end;

procedure TVendaLoteManagerView.FormDestroy(Sender: TObject);
begin
  inherited;
  GlobalContainer.Release(DataContext);
end;

procedure TVendaLoteManagerView.LoteIdEditExit(Sender: TObject);
begin
  inherited;
  if (StrToIntDef(idEdit.Text, 0) = 0) then
    bindings.GetBindingForTarget(lanceArremateEdit).UpdateTarget();
end;

procedure TVendaLoteManagerView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TVendaLoteManagerView.ConfigureBind;
var
  binding: TBinding;
begin
  bindings.AddBinding(DataContext, 'ActiveControl', Self, 'ActiveControl', bmTwoWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_CONTROL_STRING_NAME, [Self]));

  binding := bindings.AddBinding(DataContext, 'EntityId', idEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;

  binding := bindings.AddBinding(DataContext, 'CompradorId', compradorIdEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;
  bindings.AddBinding(DataContext, 'Comprador.Id', compradorIdEdit, 'Text', bmOneWay);
  bindings.AddBinding(DataContext, 'Comprador.Nome', compradorNomeEdit, 'Text', bmOneWay);

  binding := bindings.AddBinding(DataContext, 'LoteId', loteIdEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;

  bindings.AddBinding(DataContext, 'Lote.Id', loteIdEdit, 'Text', bmOneWay);
  bindings.AddBinding(DataContext, 'Lote.Descricao', loteDescricaoEdit, 'Text', bmOneWay);
  binding := bindings.AddBinding(DataContext, 'Lote.LanceInicial', lanceArremateEdit, 'Text', bmOneWay);
  binding.TargetUpdateTrigger := utExplicit;

  bindings.AddBinding(DataContext, 'Entity.Id', idEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.Data', dataDtp, 'Date', bmOneWay);

  binding := bindings.AddBinding(DataContext, 'Entity.CompradorId', compradorIdEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;
  binding := bindings.AddBinding(DataContext, 'Entity.LoteId', loteIdEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;

  bindings.AddBinding(DataContext, 'Entity.LanceArremate', lanceArremateEdit, 'Text');
end;

{$ENDREGION}

end.
