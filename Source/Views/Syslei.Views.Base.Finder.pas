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

unit Syslei.Views.Base.Finder;

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
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,

  Data.DB,

  Syslei.Views.Base,
  DSharp.Bindings.VCLControls;

type
  TFinderBaseView = class(TBaseView)
    novoButton: TSpeedButton;
    avulsaButton: TSpeedButton;
    inicialButton: TSpeedButton;
    exataButton: TSpeedButton;
    okButton: TSpeedButton;
    sairButton: TSpeedButton;
    headerPanel: TPanel;
    propertyNameBox: TGroupBox;
    propertyNameCombo: TComboBox;
    propertyValueBox: TGroupBox;
    propertyValueEdit: TEdit;
    dataGrid: TDBGrid;
    dataSource: TDataSource;
    Novo: TAction;
    Avulsa: TAction;
    Inicial: TAction;
    Exata: TAction;
    Ok: TAction;
    Sair: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure OkExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TFinderBaseView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  dataSource.DataSet.Close;
end;

procedure TFinderBaseView.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(dataSource.DataSet) then
    dataSource.DataSet.Open;
end;

procedure TFinderBaseView.OkExecute(Sender: TObject);
begin
  inherited;
  if Assigned(dataSource.DataSet) and not dataSource.DataSet.IsEmpty() then
    ModalResult := mrOk;
end;

procedure TFinderBaseView.SairExecute(Sender: TObject);
begin
  inherited;
  Close();
end;

end.
