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

unit Syslei.ViewModels.Managers.Pessoa;

interface

uses
  Syslei.Models.Entities.Pessoa,
  Syslei.ViewModels.Base.Manager;

type
  TPessoaManagerViewModel = class(TManagerViewModelBase<TPessoa>)
  private const
    ID_CONTROL_NAME = 'idEdit';
    NOME_CONTROL_NAME = 'nomeEdit';
  protected
    function Validate: Boolean; override;
  public
    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject); override;
  end;

implementation

uses
  System.SysUtils,

  Syslei.ViewModels.Base.Finder,
  Syslei.Views.Consts,
  Syslei.PresentationModel.Dialog,
  Syslei.PresentationModel.ResourceStrings,
  Syslei.PresentationModel.View.Interfaces,

  Spring.Container;

{$REGION 'TPessoaManagerViewModel' }

procedure TPessoaManagerViewModel.Novo(Sender: TObject);
begin
  inherited;
  ActiveControl := ID_CONTROL_NAME;
end;

procedure TPessoaManagerViewModel.Buscar(Sender: TObject);
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
      EntityId := finderViewModel.Entity.Id;
      ActiveControl := ID_CONTROL_NAME;
    end;
  end;
end;

function TPessoaManagerViewModel.Validate: Boolean;
begin
  Result := True;

  if (Entity.Nome.IsEmpty()) then
  begin
    Dialog.ShowWarningMessage(Format(SCampoObrigatorio, ['Nome']));
    ActiveControl := NOME_CONTROL_NAME;
    Exit(False);
  end;
end;

{$ENDREGION}

end.
