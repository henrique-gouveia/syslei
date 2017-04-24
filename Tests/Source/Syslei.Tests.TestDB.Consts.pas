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

unit Syslei.Tests.TestDB.Consts;

interface

const
  LOTE_TABLE_NAME = 'LOTE';
  PESSOA_TABLE_NAME = 'PESSOA';
  PROPRIO_TABLE_NAME = 'PROPRIO';
  VENDA_LOTE_TABLE_NAME = 'VENDA_LOTE';

  LOTE_CREATE_COMMAND =
    'CREATE TABLE IF NOT EXISTS '
  + '[' + LOTE_TABLE_NAME + '] ('
  + '[ID] INTEGER PRIMARY KEY AUTOINCREMENT, '
  + '[DOADOR_ID] INTEGER CONSTRAINT "FK_LOTE_DOADOR" REFERENCES "PESSOA"("ID"), '
  + '[DESCRICAO] VARCHAR(100), '
  + '[NUMERO] VARCHAR(20), '
  + '[LANCE_INICIAL] DECIMAL(15,5), '
  + '[STATUS] INTEGER, '
  + '[TIPO] INTEGER, '
  + '[IDADE] INTEGER, '
  + '[SEXO] INTEGER, '
  + '[DATA_CADASTRO] DATE);';

  PESSOA_CREATE_COMMAND =
    'CREATE TABLE IF NOT EXISTS '
  + '[' + PESSOA_TABLE_NAME + '] ('
  + '[ID] INTEGER PRIMARY KEY AUTOINCREMENT, '
  + '[NOME] VARCHAR(60), '
  + '[CPF_CNPJ] VARCHAR(20), '
  + '[FONE1] VARCHAR(15), '
  + '[DATA_CADASTRO] DATE);';

  PROPRIO_CREATE_COMMAND =
    'CREATE TABLE IF NOT EXISTS '
  + '[' + PROPRIO_TABLE_NAME + '] ('
  + '[ID] INTEGER PRIMARY KEY AUTOINCREMENT, '
  + '[NOME] VARCHAR(60), '
  + '[CPF_CNPJ] VARCHAR(20), '
  + '[FONE1] VARCHAR(15), '
  + '[DATA_CADASTRO] DATE);';

  VENDA_LOTE_CREATE_COMMAND =
    'CREATE TABLE IF NOT EXISTS '
  + '[' + VENDA_LOTE_TABLE_NAME + '] ('
  + '[ID] INTEGER PRIMARY KEY AUTOINCREMENT, '
  + '[COMPRADOR_ID] INTEGER CONSTRAINT "FK_VENDA_LOTE_COMPRADOR" REFERENCES "PESSOA"("ID"), '
  + '[LOTE_ID] INTEGER CONSTRAINT "FK_VENDA_LOTE_LOTE" REFERENCES "LOTE"("ID"), '
  + '[LANCE_ARREMATE] DECIMAL(15,5), '
  + '[DATA] DATE);';

  LOTE_INSERT_COMMAND =
    'INSERT INTO '
  + '[' + LOTE_TABLE_NAME + '] ( '
  + '[DOADOR_ID], [DESCRICAO], [NUMERO], [LANCE_INICIAL], '
  + '[STATUS], [TIPO], [IDADE], [SEXO], [DATA_CADASTRO]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);';

  PESSOA_INSERT_COMMAND =
    'INSERT INTO '
  + '[' + PESSOA_TABLE_NAME + '] ( '
  + '[NOME], [CPF_CNPJ], [FONE1], [DATA_CADASTRO]) VALUES (?, ?, ?, ?);';

  PROPRIO_INSERT_COMMAND =
    'INSERT INTO '
  + '[' + PROPRIO_TABLE_NAME + '] ( '
  + '[NOME], [CPF_CNPJ], [FONE1], [DATA_CADASTRO]) VALUES (?, ?, ?, ?);';

  VENDA_LOTE_INSERT_COMMAND =
    'INSERT INTO '
  + '[' + VENDA_LOTE_TABLE_NAME + '] ('
  + '[COMPRADOR_ID], [LOTE_ID], [LANCE_ARREMATE], [DATA]) VALUES (?, ?, ?, ?);';

  TABLE_DELETE_COMMAND =
    'DELETE FROM [%s];';

implementation

end.
