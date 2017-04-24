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

unit Syslei.Views.Reports.Lote.Venda.Promissoria;

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

  DSharp.Bindings,
  DSharp.Bindings.VCLControls,

  Syslei.PresentationModel.View.Interfaces,
  Syslei.PresentationModel.View.VCLForm,
  Syslei.ViewModels.Consts,

  Spring.Container.Common;

type
  TPromissoriaVendaLoteReportView = class(TForm, IReportPreview)
    report: TRLReport;
    reportDetailBand: TRLBand;
    numeroVendaInfoPanel: TRLPanel;
    tituloInfoPanel: TRLPanel;
    valorVendaInfoPanel: TRLPanel;
    compradorInfoPanel: TRLPanel;
    compradorPanel: TRLPanel;
    loteInfoPanel: TRLPanel;
    emitenteInfoPanel: TRLPanel;
    codigoVendaLabel: TRLLabel;
    codigoVendaText: TRLDBText;
    tituloLabel: TRLLabel;
    valorLabel: TRLLabel;
    valorResult: TRLDBResult;
    compradorLabel: TRLLabel;
    compradorIdText: TRLDBText;
    compradorNomeText: TRLDBText;
    compradorCpfCnpjLabel: TRLLabel;
    compradorCpfCnpjText: TRLDBText;
    compradorTelefoneLabel: TRLLabel;
    compradorTelefoneText: TRLDBText;
    loteNumeroLabel: TRLLabel;
    loteNumeroText: TRLDBText;
    LoteDescricaoLabel: TRLLabel;
    LoteDescricaoText: TRLDBText;
    loteAnimalPanel: TRLPanel;
    loteAnimalIdadeLabel: TRLLabel;
    loteAnimalIdadeText: TRLDBText;
    loteAnimalSexoLabel: TRLLabel;
    loteAnimalSexoText: TRLDBText;
    emitenteNomeLabel: TRLLabel;
    emitenteNomeText: TRLDBText;
    emitenteCpfCnpjLabel: TRLLabel;
    emitenteCpfCnpjText: TRLDBText;
    emitenteTelefoneLabel: TRLLabel;
    emitenteTelefoneText: TRLDBText;
    compradorAssinaturaPanel: TRLPanel;
    compradorAssinaturaLabel: TRLLabel;
    compradorAssinaturaNomeLabel: TRLLabel;
    emitenteAssinaturaPanel: TRLPanel;
    emitenteAssinaturaLabel: TRLLabel;
    emitenteAssinaturaNomeLabel: TRLLabel;
    dataVendaLabel: TRLLabel;
    dataVendaText: TRLDBText;
    dataSource: TDataSource;
    bindings: TBindingGroup;
    proprioDataSource: TDataSource;
    procedure FormDestroy(Sender: TObject);
    procedure LoteAnimalPanelBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure reportBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure ResultCompute(Sender: TObject; var Value: Variant; var Text: string; var ComputeIt: Boolean);
  private const
    TIPO_LOTE_ANIMAL = 'A';
    TIPO_LOTE_IMOVEL = 'I';
  private
    procedure ConfigureBind;
  protected
    function Preview: Boolean;
    function PreviewModal: Boolean;
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(VENDA_LOTE_REPORT_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts,
  Spring.Container;

{$REGION 'TPromissoriaVendaLoteReportView' }

procedure TPromissoriaVendaLoteReportView.FormDestroy(Sender: TObject);
begin
  GlobalContainer.Release(DataContext);
end;

function TPromissoriaVendaLoteReportView.Preview: Boolean;
begin
  Result := report.Preview();
end;

function TPromissoriaVendaLoteReportView.PreviewModal: Boolean;
begin
  Result := report.PreviewModal();
end;

procedure TPromissoriaVendaLoteReportView.LoteAnimalPanelBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  PrintIt := dataSource.DataSet.FieldByName('LoteTipo').AsString = TIPO_LOTE_ANIMAL;
end;

procedure TPromissoriaVendaLoteReportView.reportBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  dataSource.DataSet.Open();
  proprioDataSource.DataSet.Open();
end;

procedure TPromissoriaVendaLoteReportView.ResultCompute(Sender: TObject; var Value: Variant; var Text: string;
  var ComputeIt: Boolean);
begin
  Value := dataSource.DataSet.FieldByName(TRLDBResult(Sender).DataField).AsFloat;
end;

procedure TPromissoriaVendaLoteReportView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TPromissoriaVendaLoteReportView.ConfigureBind;
begin
  {$IFNDEF TESTS}
  bindings.AddBinding(DataContext, 'Entities', dataSource, 'DataSet', bmOneWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_VENDALOTEDATASET_NAME, [Self]));

  bindings.AddBinding(DataContext, 'Proprios', proprioDataSource, 'DataSet', bmOneWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_PROPRIODATASET_NAME, [Self]));
  {$ENDIF}
end;

{$ENDREGION}

end.
