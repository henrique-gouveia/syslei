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

unit Syslei.Registrations.ViewModels;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TViewModelsRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  Syslei.ViewModels.Base.Report,
  Syslei.ViewModels.Consts,
  Syslei.ViewModels.Main,
  Syslei.ViewModels.Filters.Lote,
  Syslei.ViewModels.Filters.Lote.Venda,
  Syslei.ViewModels.Finders.Lote,
  Syslei.ViewModels.Finders.Lote.Venda,
  Syslei.ViewModels.Finders.Pessoa,
  Syslei.ViewModels.Managers.Lote,
  Syslei.ViewModels.Managers.Lote.Venda,
  Syslei.ViewModels.Managers.Pessoa,
  Syslei.ViewModels.Managers.Proprio,
  Syslei.ViewModels.Reports.Lote.Venda;

{$REGION 'TViewModelsRegiterType' }

procedure TViewModelsRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<TObject, TMainViewModel>(MAIN_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TLoteFilterViewModel>(LOTE_FILTER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TLoteFinderViewModel>(LOTE_FINDER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TReportViewModelBase>(LOTE_REPORT_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TLoteManagerViewModel>(LOTE_MANAGER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TPessoaFinderViewModel>(PESSOA_FINDER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TPessoaManagerViewModel>(PESSOA_MANAGER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TProprioManagerViewModel>(PROPRIO_MANAGER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TVendaLoteFilterViewModel>(VENDA_LOTE_FILTER_VIEW_MODEL_NAME)
    .AsSingleton();

 container
    .RegisterType<TObject, TVendaLoteFinderViewModel>(VENDA_LOTE_FINDER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TVendaLoteManagerViewModel>(VENDA_LOTE_MANAGER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TVendaLoteReportViewModel>(VENDA_LOTE_REPORT_VIEW_MODEL_NAME)
    .AsSingleton();
end;

{$ENDREGION}

end.
