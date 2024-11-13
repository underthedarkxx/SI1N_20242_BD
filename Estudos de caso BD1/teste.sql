-- Active: 1728688414725@@127.0.0.1@3306@ec1_si1n
#FASE 1: CRIAR O BANCO DE DADOS (SCHEMA OU DATABASE):
#MEU PRIMEIRO BANQUINHO
#CREATE SCHEMA EC1_SI1N;

#FASE 2: SELECIONAR O NOVO SCHEMA OU DATABASE PARA USO:
#USANDO MEU BANQUINHO
USE EC1_SI1N;


# FASE 3: CRIANDO AS TABELAS SEM CHAVES ESTRANGEIRAS
DROP TABLE FORNECEDORES;
#CRIANDO A TABELINHA FORNECEDORES
CREATE TABLE IF NOT EXISTS FORNECEDORES(
#NOMEDOATRIBUTO - TIPO - RESTRIÇÃO DE INTEGRIDADE(OPCIONAL)
FORNEC_COD INT PRIMARY KEY,
FORNEC_NOME VARCHAR(45) NOT NULL,
FORNEC_RUA VARCHAR(45) NOT NULL,
FORNEC_NUMRUA INT,
FORNEC_BAIRRO VARCHAR(45) NOT NULL,
FORNEC_CIDADE VARCHAR(45) NOT NULL,
FORNEC_ESTADO VARCHAR(45) NOT NULL,
FORNEC_PAIS VARCHAR(30) NOT NULL,
FORNEC_CODPOSTAL VARCHAR(10) NOT NULL,
FORNEC_TELEFONE VARCHAR(15) NOT NULL,
FORNEC_CONTATO TEXT NOT NULL
);
ALTER TABLE FORNECEDORES
ADD COLUMN data_contrato DATE;

INSERT INTO FORNECEDORES(
    FORNEC_COD, FORNEC_NOME, FORNEC_RUA, FORNEC_NUMRUA, FORNEC_BAIRRO, FORNEC_CIDADE, FORNEC_ESTADO, FORNEC_PAIS, FORNEC_CODPOSTAL, FORNEC_TELEFONE, FORNEC_CONTATO
) VALUES
(100, 'Empresa 1', 'Av 1', NULL, 'Bairro 1', 'Cidade 1', 'Estado 1', 'Pais 1', '12345-678', '27-99999-8888', 'contato 1'),
(101, 'Empresa 2', 'Av 2', NULL, 'Bairro 2', 'Cidade 2', 'Estado 2', 'Pais 1', '12345-677', '27-99999-8887', 'contato 2'),
(102, 'Empresa 3', 'Av 3', NULL, 'Bairro 3', 'Cidade 3', 'Estado 3', 'Pais 1', '12345-676', '27-99999-8886', 'contato 3'),
(103, 'Empresa 4', 'Av 4', NULL, 'Bairro 4', 'Cidade 4', 'Estado 4', 'Pais 1', '12345-675', '27-99999-8885', 'contato 4'),
(104, 'Empresa 5', 'Av 5', NULL, 'Bairro 5', 'Cidade 5', 'Estado 5', 'Pais 1', '12345-674', '27-99999-8884', 'contato 5');

UPDATE FORNECEDORES
SET FORNEC_PAIS = 'Pais 2'
WHERE FORNEC_COD = 100;
UPDATE FORNECEDORES
SET FORNEC_PAIS = 'Pais 2'
WHERE FORNEC_COD = 101;


#CRIANDO A TABELINHA FILIAIS
DROP TABLE FILIAIS;
CREATE TABLE IF NOT EXISTS FILIAIS(
FILIAL_COD INT PRIMARY KEY,
FILIAL_NOME VARCHAR(45) NOT NULL,
FILIAL_RUA VARCHAR(100) NOT NULL,
FILIAL_NUMRUA INT,
FILIAL_BAIRRO VARCHAR(50) NOT NULL,
FILIAL_CIDADE VARCHAR(50) NOT NULL,
FILIAL_ESTADO VARCHAR(50) NOT NULL,
FILIAL_PAIS VARCHAR(50) NOT NULL,
FILIAL_CODPOSTAL VARCHAR(10) NOT NULL,
FILIAL_CAPACIDADE TEXT NOT NULL);

ALTER TABLE FILIAIS
DROP COLUMN FILIAL_NUMRUA;

ALTER TABLE FILIAIS
MODIFY COLUMN FILIAL_NOME VARCHAR(30);

INSERT INTO FILIAIS(
    FILIAL_COD, FILIAL_NOME, FILIAL_RUA, FILIAL_BAIRRO, FILIAL_CIDADE, FILIAL_ESTADO, FILIAL_PAIS, FILIAL_CODPOSTAL, FILIAL_CAPACIDADE
) VALUES
(200, 'Empresa 1', 'Av 1', 'Bairro 1', 'Cidade 1', 'Estado 1', 'Pais 1', '12345-678', 50),
(201, 'Empresa 2', 'Av 2', 'Bairro 2', 'Cidade 2', 'Estado 2', 'Pais 1', '12345-677', 51),
(202, 'Empresa 3', 'Av 3', 'Bairro 3', 'Cidade 3', 'Estado 3', 'Pais 1', '12345-676', 52),
(203, 'Empresa 4', 'Av 4', 'Bairro 4', 'Cidade 4', 'Estado 4', 'Pais 1', '12345-675', 53),
(204, 'Empresa 5', 'Av 5', 'Bairro 5', 'Cidade 5', 'Estado 5', 'Pais 1', '12345-674', 54);

UPDATE FILIAIS
SET FILIAL_PAIS = 'Pais 2'
WHERE FILIAL_COD = 200;

UPDATE FILIAIS
SET FILIAL_PAIS = 'Pais 2'
WHERE FILIAL_COD = 201;

#CRIANDO A TABELINHA PRODUTOS
DROP TABLE PRODUTOS;
CREATE TABLE IF NOT EXISTS PRODUTOS(
PROD_COD INT PRIMARY KEY,
PROD_NOME VARCHAR(50) NOT NULL,
PROD_DESCRICAO TEXT NOT NULL,
PROD_ESPECTEC TEXT NOT NULL,
PROD_QUANT DECIMAL(10,3) NOT NULL,
PROD_PRECOUNIT DECIMAL(10,2) NOT NULL,
PROD_UNIDMEDIDA VARCHAR(10) NOT NULL,
PROD_ESTOQ_MIN DECIMAL(10,3) NOT NULL
);

ALTER TABLE PRODUTOS
CHANGE COLUMN PROD_DESCRICAO PROD_DESCR TEXT;

INSERT INTO PRODUTOS(
    PROD_COD, PROD_QUANT, PROD_NOME, PROD_DESCRICAO, PROD_ESPECTEC,  PROD_PRECOUNIT, PROD_UNIDMEDIDA, PROD_ESTOQ_MIN
) VALUES
(300, 1000000.11, 'Produto 1', 'Descricao 1', 'Especificacao tecnica 1',  '100.99', 'Ml', '12345.678'),
(301, 100000.22, 'Produto 2', 'Descricao 2', 'Especificacao tecnica 2',  '200.99', '"T"', '12345.677'),
(302, 10000.33, 'Produto 3', 'Descricao 3', 'Especificacao tecnica 3',  '300.99', '"kg "', '12345.676'),
(303, 1000.44, 'Produto 4', 'Descricao 4', 'Especificacao tecnica 4',  '400.99', '"G "', '12345.675'),
(304, 100.55, 'Produto 5', 'Descricao 5', 'Especificacao tecnica 5',  '500.99', '"Mg"', '12345.674');

UPDATE PRODUTOS
SET PROD_DESCRICAO = 'Descricao 10'
WHERE PROD_COD = 300;

UPDATE PRODUTOS
SET PROD_DESCRICAO = 'Descricao 20'
WHERE PROD_COD = 301;

#FASE 4: CRIAR AS TABELAS COM DEPENDÊNCIA DE CHAVE ESTRANGEIRA

#CRIANDO A TABELA PEDIDOS
DROP TABLE PEDIDOS;
CREATE TABLE IF NOT EXISTS PEDIDOS(
PED_CODIGO INT PRIMARY KEY,
PED_DATA DATE NOT NULL,
PED_HORA TIME NOT NULL,
PED_PREVISAO DATE NOT NULL,
PED_STATUS ENUM('PENDENTE','CONCLUÍDO','EM ESPERA'),
PED_FORNECEDOR INT NOT NULL, 
#NOSSA CHAVE ESTRANGEIRA DE FORNECEDOR
#CRIANDO A REFERENCIA PARA A CHAVE ESTRANGEIRA
#RESTRIÇÃO APELIDO CH.ESTRANGEIRA(CAMPO CRIADO) REFERENCIA TABELA(CH.PRIMÁRIA)
CONSTRAINT FK_FORNECEDOR FOREIGN KEY (PED_FORNECEDOR) 
#DAR NOME A RESTRIÇÃO(CONSTRAINT) É UMA BOA PRÁTICA
REFERENCES FORNECEDORES(FORNEC_COD) 
#REFERENCIA A CHAVE PRIMÁRIA DE FORNECEDORES
);

ALTER TABLE PEDIDOS
CHANGE COLUMN PED_PREVISAO PED_PREV DATE NOT NULL;

ALTER TABLE PEDIDOS
CHANGE COLUMN  PED_PREV PED_PREVISAO DATE NOT NULL;

INSERT INTO PEDIDOS(PED_CODIGO, PED_DATA, PED_HORA, PED_PREVISAO, PED_STATUS, PED_FORNECEDOR)
VALUES
(400, '2024-11-01', '01:00:00', '2024-11-11', 'PENDENTE', 100),
(401, '2024-11-02', '02:00:00', '2024-11-12', 'CONCLUÍDO', 101),
(402, '2024-11-03', '03:00:00', '2024-11-13', 'EM ESPERA', 102),
(403, '2024-11-04', '04:00:00', '2024-11-14', 'PENDENTE', 103),
(404, '2024-11-05', '05:00:00', '2024-11-15', 'CONCLUÍDO', 104);

#CRIANDO A TABELA RECEBIMENTOS (VEIO DEPOIS POIS TEM DEPENDÊNCIA DE PEDIDOS)
CREATE TABLE IF NOT EXISTS RECEBIMENTOS(
RECEB_DATA DATE NOT NULL,
RECEB_HORA TIME NOT NULL,
RECEB_QUANT_PROD DECIMAL(10,3),
RECEB_CONDICAO TEXT NOT NULL,
RECEB_PEDIDOS INT PRIMARY KEY,
CONSTRAINT FK_PEDIDOS FOREIGN KEY(RECEB_PEDIDOS) REFERENCES PEDIDOS(PED_CODIGO));

#FASE 5: CRIANDO AS TABELAS ASSOCIATIVAS (ENTIDADES ASSOCIATIVAS)
DROP TABLE RECEBIMENTOS;

#CRIANDO A TABELA PEDIDOS_PRODUTOS
CREATE TABLE IF NOT EXISTS PEDIDOS_PRODUTOS(
PDPR_PEDIDOS INT,
PDPR_PRODUTOS INT,
PRIMARY KEY(PDPR_PEDIDOS,PDPR_PRODUTOS),
PDPR_QUANT DECIMAL(10,3) NOT NULL,
CONSTRAINT PDPR_FK_PEDIDOS FOREIGN KEY(PDPR_PEDIDOS) REFERENCES PEDIDOS(PED_CODIGO),
CONSTRAINT PDPR_FK_PRODUTOS FOREIGN KEY(PDPR_PRODUTOS) REFERENCES PRODUTOS(PROD_COD)
);

#CRIANDO A TABELA FILIAIS_PRODUTOS
CREATE TABLE IF NOT EXISTS FILIAIS_PRODUTOS(
FLPR_FILIAL INT,
FLPR_PRODUTOS INT,
PRIMARY KEY(FLPR_FILIAL,FLPR_PRODUTOS),
FLPR_QUANT DECIMAL(10,3) NOT NULL,
CONSTRAINT FLPR_FK_FILIAIS FOREIGN KEY(FLPR_FILIAL) REFERENCES FILIAIS(FILIAL_COD),
CONSTRAINT FLPR_FK_PRODUTOS FOREIGN KEY(FLPR_PRODUTOS) REFERENCES PRODUTOS(PROD_COD));

#CRIAR A TABELA FORNECEDORES_PRODUTOS
CREATE TABLE IF NOT EXISTS FORNECEDORES_PRODUTOS(
FRPR_FORNECEDOR INT,
FRPR_PRODUTOS INT,
PRIMARY KEY(FRPR_FORNECEDOR,FRPR_PRODUTOS),
CONSTRAINT FRPR_FK_FORNECEDORES FOREIGN KEY(FRPR_FORNECEDOR)
REFERENCES FORNECEDORES(FORNEC_COD),
CONSTRAINT FRPR_FK_PRODUTOS FOREIGN KEY(FRPR_PRODUTOS) 
REFERENCES PRODUTOS(PROD_COD));