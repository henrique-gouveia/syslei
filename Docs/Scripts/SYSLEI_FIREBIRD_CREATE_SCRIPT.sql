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
CPF                  VARCHAR(12)                                  COLLATE PT_BR,
DATA_CADASTRO        DATE,
CONSTRAINT PK_PESSOA PRIMARY KEY (ID)
);

/*==============================================================*/
/*                            INDICES                           */
/*==============================================================*/

CREATE INDEX IDX_LOTE_DESCRICAO ON LOTE (DESCRICAO);
CREATE INDEX IDX_PESSOA_CPF ON PESSOA (CPF);
CREATE INDEX IDX_PESSOA_NOME ON PESSOA (NOME);

/*==============================================================*/
/*                      FOREIGN KEYS                            */
/*==============================================================*/

ALTER TABLE LOTE
   ADD CONSTRAINT FK_LOTE_DOADOR FOREIGN KEY (DOADOR_ID)
      REFERENCES PESSOA (ID);
