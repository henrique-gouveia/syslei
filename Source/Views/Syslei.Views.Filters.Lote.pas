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

unit Syslei.Views.Filters.Lote;

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
  Syslei.Views.Base.Filter,

  DSharp.Bindings.VCLControls,
  DSharp.Bindings,

  Spring,
  Spring.Container.Common;

type
  TLoteFilterView = class(TFilterBaseView)
    Buscar: TAction;
    buscarButton: TSpeedButton;
    doadorGroup: TGroupBox;
    doadorIdEdit: TEdit;
    doadorNomeEdit: TEdit;
    statusGroup: TRadioGroup;
    tipoGroup: TRadioGroup;
    periodoCadastroGroup: TGroupBox;
    dataCadastroInicialLabel: TLabel;
    dataCadastroInicialDtp: TDateTimePicker;
    dataCadastroFinalLabel: TLabel;
    dataCadastroFinalDtp: TDateTimePicker;
    bindings: TBindingGroup;
    procedure FormDestroy(Sender: TObject);
  private
    procedure ConfigureBind;
  protected
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(LOTE_FILTER_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  Spring.Container,
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts;

{$REGION 'TLoteFilterView' }

procedure TLoteFilterView.FormDestroy(Sender: TObject);
begin
  inherited;
  GlobalContainer.Release(DataContext);
end;

procedure TLoteFilterView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TLoteFilterView.ConfigureBind;
var
  binding: TBinding;
begin
  bindings.AddBinding(DataContext, 'ActiveControl', Self, 'ActiveControl', bmTwoWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_CONTROL_STRING_NAME, [Self]));

  binding := bindings.AddBinding(DataContext, 'DoadorId', doadorIdEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;
  binding.UpdateSource();

  bindings.AddBinding(DataContext, 'Filter.Doador.Id', doadorIdEdit, 'Text', bmOneWay);
  bindings.AddBinding(DataContext, 'Filter.Doador.Nome', doadorNomeEdit, 'Text', bmOneWay);

  bindings.AddBinding(DataContext, 'Filter.Status', statusGroup, 'ItemIndex');
  bindings.AddBinding(DataContext, 'Filter.Tipo', tipoGroup, 'ItemIndex');

  bindings.AddBinding(DataContext, 'Filter.DataCadastroInicial', dataCadastroInicialDtp, 'Date');
  bindings.AddBinding(DataContext, 'Filter.DataCadastroFinal', dataCadastroFinalDtp, 'Date');
end;

{$ENDREGION}

end.
