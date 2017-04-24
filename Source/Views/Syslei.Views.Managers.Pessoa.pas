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
  DSharp.Bindings.VCLControls;

type
  TPessoaManagerView = class(TManagerBaseView)
    idLabel: TLabel;
    idEdit: TEdit;
    nomeLabel: TLabel;
    nomeEdit: TEdit;
    cpfLabel: TLabel;
    cpfCnpjMask: TMaskEdit;
    telefoneMask: TMaskEdit;
    telefoneLabel: TLabel;
    dtCadastroLabel: TLabel;
    dtCadastroDtp: TDateTimePicker;
    bindings: TBindingGroup;
    procedure FormDestroy(Sender: TObject);
  private
    procedure ConfigureBind;
  protected
    procedure ActiveChanged; override;
    procedure SetDataContext(const Value: TObject); override;
  public
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  Spring.Container,
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts;

{$REGION 'TPessoaManagerView' }

procedure TPessoaManagerView.ActiveChanged;
begin
  inherited;
  bindings.GetBindingForTarget(Self).UpdateSource();
end;

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
  bindings.AddBinding(DataContext, 'ActiveControl', Self, 'ActiveControl', bmTwoWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_CONTROL_STRING_NAME, [Self]));

  binding := bindings.AddBinding(DataContext, 'EntityId', idEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;

  bindings.AddBinding(DataContext, 'Entity.Id', idEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.Nome', nomeEdit, 'Text');
  bindings.AddBinding(DataContext, 'Entity.CpfCnpj', cpfCnpjMask, 'Text');
  bindings.AddBinding(DataContext, 'Entity.Telefone', telefoneMask, 'Text');
  bindings.AddBinding(DataContext, 'Entity.DataCadastro', dtCadastroDtp, 'Date', bmOneWay);
end;

{$ENDREGION}

end.
