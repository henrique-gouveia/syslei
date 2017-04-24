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

unit Syslei.Registrations.Views;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TViewsRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Forms,

  Syslei.Views.Consts,
  Syslei.Views.Main,
  Syslei.Views.Filters.Lote,
  Syslei.Views.Filters.Lote.Venda,
  Syslei.Views.Finders.Lote,
  Syslei.Views.Finders.Lote.Venda,
  Syslei.Views.Finders.Pessoa,
  Syslei.Views.Managers.Lote,
  Syslei.Views.Managers.Lote.Venda,
  Syslei.Views.Managers.Pessoa,
  Syslei.Views.Reports.Lote,
  Syslei.Views.Reports.Lote.Venda,
  Syslei.Views.Reports.Lote.Venda.Promissoria,

  Syslei.ViewModels.Consts,

  Syslei.PresentationModel.View.Interfaces,
  Syslei.PresentationModel.Dialog,
  Syslei.PresentationModel.Dialog.VCL,

  DSharp.PresentationModel.ViewModelBinder,
  DSharp.PresentationModel.VCLConventionManager;

{$REGION 'TViewsRegiterType' }

procedure TViewsRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<IDialog, TVCLDialogAdapter>();

  container
    .RegisterType<TMainView>()
    .DelegateTo(
      function: TMainView
      begin
        Application.CreateForm(TMainView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(MAIN_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TLoteFilterView>(LOTE_FILTER_VIEW_NAME)
    .DelegateTo(
      function: TLoteFilterView
      begin
        Application.CreateForm(TLoteFilterView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(LOTE_FILTER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TLoteReportView>(LOTE_REPORT_VIEW_NAME)
    .DelegateTo(
      function: TLoteReportView
      begin
        Application.CreateForm(TLoteReportView, Result);
      end);

  container
    .RegisterType<TLoteFinderView>(LOTE_FINDER_VIEW_NAME)
    .DelegateTo(
      function: TLoteFinderView
      begin
        Application.CreateForm(TLoteFinderView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(LOTE_FINDER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TLoteManagerView>(LOTE_MANAGER_VIEW_NAME)
    .DelegateTo(
      function: TLoteManagerView
      begin
        Application.CreateForm(TLoteManagerView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(LOTE_MANAGER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TPessoaFinderView>(PESSOA_FINDER_VIEW_NAME)
    .DelegateTo(
      function: TPessoaFinderView
      begin
        Application.CreateForm(TPessoaFinderView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(PESSOA_FINDER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TPessoaManagerView>(PESSOA_MANAGER_VIEW_NAME)
    .DelegateTo(
      function: TPessoaManagerView
      var
        dataContext: TObject;
      begin
        dataContext := container.Resolve<TObject>(PESSOA_MANAGER_VIEW_MODEL_NAME);
        Application.CreateForm(TPessoaManagerView, Result);

        Result.DataContext := dataContext;
        Result.Caption := 'Gerenciar Pessoa';

        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(PESSOA_MANAGER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TPessoaManagerView>(PROPRIO_MANAGER_VIEW_NAME)
    .DelegateTo(
      function: TPessoaManagerView
      var
        dataContext: TObject;
      begin
        dataContext := container.Resolve<TObject>(PROPRIO_MANAGER_VIEW_MODEL_NAME);
        Application.CreateForm(TPessoaManagerView, Result);

        Result.DataContext := dataContext;
        Result.Caption := 'Gerenciar Próprio';

        // connect controls to viewmodel properties
        ViewModelBinder.Bind(dataContext, Result);
      end);

  container
    .RegisterType<TVendaLoteFilterView>(VENDA_LOTE_FILTER_VIEW_NAME)
    .DelegateTo(
      function: TVendaLoteFilterView
      begin
        Application.CreateForm(TVendaLoteFilterView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(VENDA_LOTE_FILTER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TVendaLoteFinderView>(VENDA_LOTE_FINDER_VIEW_NAME)
    .DelegateTo(
      function: TVendaLoteFinderView
      begin
        Application.CreateForm(TVendaLoteFinderView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(VENDA_LOTE_FINDER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TVendaLoteManagerView>(VENDA_LOTE_MANAGER_VIEW_NAME)
    .DelegateTo(
      function: TVendaLoteManagerView
      begin
        Application.CreateForm(TVendaLoteManagerView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(VENDA_LOTE_MANAGER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TVendaLoteReportView>(VENDA_LOTE_REPORT_VIEW_NAME)
    .DelegateTo(
      function: TVendaLoteReportView
      begin
        Application.CreateForm(TVendaLoteReportView, Result);
      end);

  container
    .RegisterType<TPromissoriaVendaLoteReportView>(PROMISSORIA_VENDA_LOTE_REPORT_VIEW_NAME)
    .DelegateTo(
      function: TPromissoriaVendaLoteReportView
      begin
        Application.CreateForm(TPromissoriaVendaLoteReportView, Result);
      end);

end;

{$ENDREGION}

end.
