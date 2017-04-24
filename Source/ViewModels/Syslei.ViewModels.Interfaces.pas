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

unit Syslei.ViewModels.Interfaces;

interface

type
  IFilterViewModel = interface
    ['{0A18DE3D-84CE-4627-AD3E-54A26F299152}']
    procedure Novo(Sender: TObject);
    procedure Executar(Sender: TObject);
    procedure Ok(Sender: TObject);
  end;

  IFinderViewModel = interface
    ['{2011FDFC-FAAB-4876-BAF1-06FDD72989A3}']
    procedure Novo(Sender: TObject);
    procedure Avulsa(Sender: TObject);
    procedure Inicial(Sender: TObject);
    procedure Exata(Sender: TObject);
  end;

  IFinderViewModel<TEntity: class, constructor> = interface(IFinderViewModel)
    ['{A22E2DB4-AD39-4341-AE36-EC8B80D36C68}']
    function GetEntity: TEntity;
    procedure SetEntity(const value: TEntity);
  end;

  IManagerViewModel = interface
    ['{E04D38A0-1A83-410E-8B9A-951265A7CB64}']
    procedure Novo(Sender: TObject);
    procedure Gravar(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure Buscar(Sender: TObject);
  end;

  IManagerViewModel<TEntity: class, constructor> = interface(IManagerViewModel)
    ['{4098570A-18E7-41C5-8FE7-37D001FEA534}']
    function GetEntity: TEntity;
    procedure SetEntity(const value: TEntity);
  end;

implementation

end.
