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

unit Syslei.Views.Reports.Lote;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Grids,

  Data.DB,

  RLReport,
  RLRichText,

  Syslei.ViewModels.Consts,
  Syslei.Views.Base.Report,

  DSharp.Bindings,
  DSharp.Bindings.VCLControls,

  Spring.Container.Common;

type
  TLoteReportView = class(TReportBaseView)
    reportColumnHeaderBand: TRLBand;
    reportDetailBand: TRLBand;
    reportSummaryrBand: TRLBand;
    idLabel: TRLLabel;
    numeroLabel: TRLLabel;
    descricaoLabel: TRLLabel;
    tipoLabel: TRLLabel;
    idadeLabel: TRLLabel;
    sexoLabel: TRLLabel;
    lanceInicialLabel: TRLLabel;
    idText: TRLDBText;
    numeroText: TRLDBText;
    descricaoRichText: TRLDBRichText;
    tipoText: TRLDBText;
    idadeText: TRLDBText;
    sexoText: TRLDBText;
    lanceInicialSimpleResult: TRLDBResult;
    registrosCountLabel: TRLLabel;
    registrosCountResult: TRLDBResult;
    totalSumLabel: TRLLabel;
    totalSumResult: TRLDBResult;
    dataSource: TDataSource;
    bindings: TBindingGroup;
    procedure ControlTextBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure FormDestroy(Sender: TObject);
  private const
    TIPO_LOTE_ANIMAL = 'ANIMAL';
    TIPO_LOTE_IMOVEL = 'IMÓVEL';
  private
    procedure ConfigureBind;
  protected
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(LOTE_REPORT_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts,
  Spring.Container;

{$REGION 'TLoteReportView' }

procedure TLoteReportView.ControlTextBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := dataSource.DataSet.FieldByName('Tipo').AsString = TIPO_LOTE_ANIMAL;
end;

procedure TLoteReportView.FormDestroy(Sender: TObject);
begin
  inherited;
  GlobalContainer.Release(DataContext);
end;

procedure TLoteReportView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TLoteReportView.ConfigureBind;
begin
  {$IFNDEF TESTS}
  bindings.AddBinding(DataContext, 'Entities', dataSource, 'DataSet', bmOneWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_LOTEDATASET_NAME, [Self]));
  {$ENDIF}
end;

{$ENDREGION}

end.
