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

unit Syslei.ViewModels.Filters.Lote;

interface

uses
  Syslei.Models.Domains.Lote.Filter,

  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa,

  Syslei.Models.Finders.Interfaces,

  Syslei.ViewModels.Base.Filter,

  Spring.Collections,
  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces;

type
  TLoteFilterViewModel = class(TFilterViewModelBase<TLote, TLoteFilter>)
  private const
    DOADOR_ID_CONTROL_NAME = 'doadorIdEdit';
  private
    FDoadorId: Integer;
    [Inject]
    FDoadorRepository: IPagedRepository<TPessoa, Integer>;
    procedure SetDoadorId(const Value: Integer);
  public
    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject);
    procedure Ok(Sender: TObject); override;

    property DoadorId: Integer read FDoadorId write SetDoadorId;
  end;

implementation

uses
  Syslei.ViewModels.Base.Finder,
  Syslei.ViewModels.Base.Report,

  Syslei.Views.Consts,

  Syslei.PresentationModel.Dialog,
  Syslei.PresentationModel.View.Interfaces,

  Spring.Container;

{$REGION 'TLoteFilterViewModel' }

procedure TLoteFilterViewModel.Novo(Sender: TObject);
begin
  inherited;
  DoadorId := 0;
end;

procedure TLoteFilterViewModel.Buscar(Sender: TObject);
var
  view: IView;
  finderViewModel: TFinderViewModelBase<TPessoa>;
begin
  inherited;
  view := GlobalContainer.Resolve<IView>(PESSOA_FINDER_VIEW_NAME);
  if Assigned(view) and (view.ShowModalView() = mrOk) then
  begin
    if view.GetDataContext() is TFinderViewModelBase<TPessoa> then
    begin
      finderViewModel := TFinderViewModelBase<TPessoa>(view.GetDataContext());
      DoadorId := finderViewModel.Entity.Id;
      ActiveControl := DOADOR_ID_CONTROL_NAME;
    end;
  end;
end;

procedure TLoteFilterViewModel.Ok(Sender: TObject);
var
  reportPreview: IReportPreview;
begin
  inherited;
  reportPreview := GlobalContainer.Resolve<IReportPreview>(LOTE_REPORT_VIEW_NAME);
  if Assigned(reportPreview) and (reportPreview.GetDataContext() is TReportViewModelBase)  then
  begin
    TReportViewModelBase(reportPreview.GetDataContext()).Entities := Entities;
    reportPreview.PreviewModal();
  end;
end;

procedure TLoteFilterViewModel.SetDoadorId(const Value: Integer);
begin
  if (FDoadorId <> Value) then
  begin
    FDoadorId := Value;
    Filter.Doador := FDoadorRepository.FindOne(FDoadorId);
    DoPropertyChanged('Filter');
  end;
end;

{$ENDREGION}

end.
