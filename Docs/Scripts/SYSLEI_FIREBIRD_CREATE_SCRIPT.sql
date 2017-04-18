/*==============================================================*/
/*                 Generated 2017.03.21 10:00:00                */
/*==============================================================*/

SET SQL DIALECT 3;

SET NAMES ISO8859_1;

SET CLIENTLIB 'fbclient.dll';

CREATE DATABASE 'LOCALHOST:C:\SYSLEI.FDB'
  USER 'SYSDBA' PASSWORD 'masterkey'
  PAGE_SIZE 4096
  DEFAULT CHARACTER SET ISO8859_1;

/*==============================================================*/
/*                         GENERATORS                           */
/*==============================================================*/

CREATE GENERATOR GEN_LOTE_ID;
SET GENERATOR GEN_LOTE_ID TO 0;

CREATE GENERATOR GEN_PESSOA_ID;
SET GENERATOR GEN_PESSOA_ID TO 0;

CREATE GENERATOR GEN_PROPRIO_ID;
SET GENERATOR GEN_PROPRIO_ID TO 0;

CREATE GENERATOR GEN_VENDA_LOTE_ID;
SET GENERATOR GEN_VENDA_LOTE_ID TO 0;

/*==============================================================*/
/*                          TABLES                              */
/*==============================================================*/

CREATE TABLE LOTE (
ID                   INTEGER                        NOT NULL,
DOADOR_ID            INTEGER                        NOT NULL,
DESCRICAO            VARCHAR(100)                                 COLLATE PT_BR,
NUMERO               VARCHAR(20)                                  COLLATE PT_BR,
LANCE_INICIAL        DECIMAL(15,5),
STATUS               INTEGER,
TIPO                 INTEGER,
IDADE                INTEGER,
SEXO                 INTEGER,
DATA_CADASTRO        DATE,
CONSTRAINT PK_LOTE PRIMARY KEY (ID)
);

CREATE TABLE PESSOA (
ID                   INTEGER                        NOT NULL,
NOME                 VARCHAR(60)                    NOT NULL      COLLATE PT_BR,
CPF_CNPJ             VARCHAR(20)                                  COLLATE PT_BR,
FONE1                VARCHAR(15)                                  COLLATE PT_BR,
DATA_CADASTRO        DATE,
CONSTRAINT PK_PESSOA PRIMARY KEY (ID)
);

CREATE TABLE PROPRIO (
ID                   INTEGER                        NOT NULL,
NOME                 VARCHAR(60)                    NOT NULL      COLLATE PT_BR,
CPF_CNPJ             VARCHAR(20)                                  COLLATE PT_BR,
FONE1                VARCHAR(15)                                  COLLATE PT_BR,
DATA_CADASTRO        DATE,
CONSTRAINT PK_PROPRIO PRIMARY KEY (ID)
);

CREATE TABLE VENDA_LOTE (
ID                   INTEGER                        NOT NULL,
COMPRADOR_ID         INTEGER                        NOT NULL,
LOTE_ID              INTEGER                        NOT NULL,
LANCE_ARREMATE       DECIMAL(15,5),
DATA                 DATE,
CONSTRAINT PK_VENDA_LOTE PRIMARY KEY (ID)
);

/*==============================================================*/
/*                            INDICES                           */
/*==============================================================*/

CREATE INDEX IDX_LOTE_DESCRICAO ON LOTE (DESCRICAO);
CREATE INDEX IDX_PESSOA_CPF_CNPJ ON PESSOA (CPF_CNPJ);
CREATE INDEX IDX_PESSOA_NOME ON PESSOA (NOME);
CREATE INDEX IDX_PROPRIO_CPF_CNPJ ON PROPRIO (CPF_CNPJ);
CREATE INDEX IDX_PROPRIO_NOME ON PROPRIO (NOME);
CREATE INDEX IDX_VENDA_LOTE_DATA ON VENDA_LOTE (DATA);

/*==============================================================*/
/*                      FOREIGN KEYS                            */
/*==============================================================*/

ALTER TABLE LOTE
   ADD CONSTRAINT FK_LOTE_DOADOR FOREIGN KEY (DOADOR_ID)
      REFERENCES PESSOA (ID);

ALTER TABLE VENDA_LOTE
   ADD CONSTRAINT FK_VENDA_LOTE_COMPRADOR FOREIGN KEY (COMPRADOR_ID)
      REFERENCES PESSOA (ID);

ALTER TABLE VENDA_LOTE
   ADD CONSTRAINT FK_VENDA_LOTE_LOTE FOREIGN KEY (LOTE_ID)
      REFERENCES LOTE (ID);
