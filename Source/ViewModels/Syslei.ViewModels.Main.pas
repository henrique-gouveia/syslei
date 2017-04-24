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

unit Syslei.ViewModels.Main;

interface

type
  TMainViewModel = class
  private
    procedure InternalShowModalView(const serviceName: String);
  public
    procedure LoteManager(Sender: TObject);
    procedure LoteReport(Sender: TObject);
    procedure PessoaManager(Sender: TObject);
    procedure ProprioManager(Sender: TObject);
    procedure VendaLoteManager(Sender: TObject);
    procedure VendaLoteReport(Sender: TObject);
  end;

implementation

uses
  Syslei.PresentationModel.View.Interfaces,
  Syslei.Views.Consts,

  Spring.Container;

{$REGION 'TMainViewModel' }

procedure TMainViewModel.LoteManager(Sender: TObject);
begin
  InternalShowModalView(LOTE_MANAGER_VIEW_NAME);
end;

procedure TMainViewModel.LoteReport(Sender: TObject);
begin
  InternalShowModalView(LOTE_FILTER_VIEW_NAME);
end;

procedure TMainViewModel.PessoaManager(Sender: TObject);
begin
  InternalShowModalView(PESSOA_MANAGER_VIEW_NAME);
end;

procedure TMainViewModel.ProprioManager(Sender: TObject);
begin
  InternalShowModalView(PROPRIO_MANAGER_VIEW_NAME);
end;

procedure TMainViewModel.VendaLoteManager(Sender: TObject);
begin
  InternalShowModalView(VENDA_LOTE_MANAGER_VIEW_NAME);
end;

procedure TMainViewModel.VendaLoteReport(Sender: TObject);
begin
  InternalShowModalView(VENDA_LOTE_FILTER_VIEW_NAME);
end;

procedure TMainViewModel.InternalShowModalView(const serviceName: String);
var
  view: IView;
begin
  view := GlobalContainer.Resolve<IView>(serviceName);
  view.ShowModalView();
end;

{$ENDREGION}

end.
