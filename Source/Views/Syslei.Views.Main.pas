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

unit Syslei.Views.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.Actions,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.UITypes,
  Vcl.Imaging.pngimage,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ToolWin,
  Vcl.ComCtrls,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Menus,

  RLXLSXFilter,
  RLXLSFilter,
  RLPDFFilter,
  RLHTMLFilter,
  RLFilters,
  RLRichFilter;

type
  TMainView = class(TForm)
    Actions: TActionList;
    ProprioManager: TAction;
    PessoaManager: TAction;
    LoteManager: TAction;
    LoteReport: TAction;
    VendaLoteManager: TAction;
    VendaLoteReport: TAction;
    Sair: TAction;
    toolBar: TToolBar;
    toolBarImages: TImageList;
    backgroundImage: TImage;
    logoImage: TImage;
    proprioManagerButton: TToolButton;
    pessoaManagerButton: TToolButton;
    loteManagerButton: TToolButton;
    separador1: TToolButton;
    vendaLoteManagerButton: TToolButton;
    separador2: TToolButton;
    sairButton: TToolButton;
    loteMenu: TPopupMenu;
    loteManagerMenuItem: TMenuItem;
    loteReportMenuItem: TMenuItem;
    vendaLoteMenu: TPopupMenu;
    vendaLoteManagerMenuItem: TMenuItem;
    vendaLoteReportMenuItem: TMenuItem;
    richFilter: TRLRichFilter;
    htmlFilter: TRLHTMLFilter;
    pdfFilter: TRLPDFFilter;
    xlsFilter: TRLXLSFilter;
    xlsxFilter: TRLXLSXFilter;

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SairExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TMainView.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('Deseja realmente fechar o sistema ?', mtConfirmation, mbYesNo, 0) = mrYes;
end;

procedure TMainView.SairExecute(Sender: TObject);
begin
  Close;
end;

end.
