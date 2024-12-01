-- Active: 1728688414725@@127.0.0.1@3306@est_caso_v
#CREATE SCHEMA Est_Caso_V;

Use Est_Caso_V;

DROP TABLE IF EXISTS Pagamentos;

CREATE TABLE IF NOT EXISTS Pagamentos (
    Cod_Pagamentos VARCHAR(50) PRIMARY KEY,
    Data_Pagamentos DATE NOT NULL,
    Valor_Pagamentos FLOAT NOT NULL,
    Status_Pagamento ENUM('PENDENTE', 'CONCLUÍDO', 'EM ESPERA'),
    FK_Venda VARCHAR(50),
    CONSTRAINT FK_Vendas_Pag FOREIGN KEY (FK_Venda) REFERENCES Vendas(Cod_Venda)
);

ALTER TABLE Pagamentos
ADD COLUMN Descricao_Pagamento VARCHAR(255);

ALTER TABLE Pagamentos
MODIFY COLUMN Valor_Pagamentos DECIMAL(10,2) NOT NULL;

ALTER TABLE Pagamentos
CHANGE COLUMN Status_Pagamento Estado_Pagamento ENUM('PENDENTE', 'CONCLUÍDO', 'EM ESPERA');

ALTER TABLE Pagamentos
DROP COLUMN Descricao_Pagamento;

DROP TABLE IF EXISTS Clientes;

CREATE TABLE IF NOT EXISTS Clientes (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome_Clientes VARCHAR(75) NOT NULL,
    Data_Nasc_Clientes DATE NOT NULL,
    Status_Fideli_Cliente ENUM('Normal', 'Prata', 'Ouro'),
    FK_Pagamentos VARCHAR(50),
    CONSTRAINT FK_Pagamento_Clientes FOREIGN KEY (FK_Pagamentos) REFERENCES Pagamentos(Cod_Pagamentos)
);

ALTER TABLE Clientes
ADD COLUMN Telefone VARCHAR(15);

ALTER TABLE Clientes
MODIFY COLUMN Status_Fideli_Cliente ENUM('Normal', 'Prata', 'Ouro', 'Platinum');

ALTER TABLE Clientes
CHANGE COLUMN Nome_Clientes Nome_Completo_Clientes VARCHAR(75) NOT NULL;

ALTER TABLE Clientes
DROP COLUMN Telefone;

DROP TABLE IF EXISTS Vendas;

CREATE TABLE IF NOT EXISTS Vendas (
    Cod_Venda VARCHAR(50) PRIMARY KEY,
    Nome_comprados VARCHAR(50) NOT NULL,
    QTD_Comprados INT NOT NULL
);

ALTER TABLE Vendas
ADD COLUMN Data_Venda DATE NOT NULL;

ALTER TABLE Vendas
MODIFY COLUMN Nome_comprados VARCHAR(100) NOT NULL;

ALTER TABLE Vendas
CHANGE COLUMN QTD_Comprados Quantidade_Comprada INT NOT NULL;

ALTER TABLE Vendas
CHANGE COLUMN Quantidade_Comprada QTD_Comprados INT NOT NULL;

ALTER TABLE Vendas
DROP COLUMN Data_Venda;

DROP TABLE IF EXISTS Produtos;
CREATE TABLE IF NOT EXISTS Produtos(
    Cod_Prod VARCHAR(30) PRIMARY KEY,
    Estoque VARCHAR(100) NOT NULL,
    Preco FLOAT NOT NULL,
    Categoria VARCHAR(30)
);
ALTER TABLE Produtos
ADD COLUMN Descricao VARCHAR(255);

ALTER TABLE Produtos
MODIFY COLUMN Preco DECIMAL(10,2) NOT NULL;

ALTER TABLE Produtos
CHANGE COLUMN Categoria Categoria_Produtos VARCHAR(50);

ALTER TABLE Produtos
CHANGE COLUMN Categoria_Produtos Categoria VARCHAR(30);
ALTER TABLE Produtos
DROP COLUMN Categoria;

ALTER TABLE Produtos
DROP COLUMN Descricao;

DROP TABLE IF EXISTS Fornecedores;
CREATE TABLE IF NOT EXISTS Fornecedores(
    Cod_Fornecedores VARCHAR(30) PRIMARY KEY,
    Contato_Fornecedor VARCHAR(50) NOT NULL,
    Produtos_Fornecidos VARCHAR(50) NOT NULL,
    Cod_Prod VARCHAR(30),
    CONSTRAINT FK_Prod_Forn FOREIGN KEY (Cod_Prod)
    REFERENCES Produtos(Cod_Prod)
);
ALTER TABLE Fornecedores
ADD COLUMN Endereco_Fornecedor VARCHAR(100);

ALTER TABLE Fornecedores
MODIFY COLUMN Contato_Fornecedor VARCHAR(100) NOT NULL;

ALTER TABLE Fornecedores
CHANGE COLUMN Produtos_Fornecidos Itens_Fornecidos VARCHAR(50) NOT NULL;

ALTER TABLE Fornecedores
CHANGE COLUMN Itens_Fornecidos Produtos_Fornecidos VARCHAR(50) NOT NULL;

ALTER TABLE Fornecedores
DROP COLUMN Endereco_Fornecedor;

DROP TABLE IF EXISTS Enderecos;
CREATE TABLE IF NOT EXISTS Enderecos(
    ID_Enderecos INT PRIMARY KEY,
    Num_End INT NOT NULL,
    Tipo_End VARCHAR(20) NOT NULL,
    Logradouro_End VARCHAR(50) NOT NULL,
    Complemento VARCHAR(100),
    CEP_End INT NOT NULL,
    Bairro_End VARCHAR(50) NOT NULL,
    Estado_End VARCHAR(30) NOT NULL,
    Cidade_End VARCHAR(50) NOT NULL,
    CPF VARCHAR(11),
    CONSTRAINT FK_Clientes_End FOREIGN KEY(CPF)
    REFERENCES Clientes(CPF)
    );

ALTER TABLE Enderecos
ADD COLUMN Pais_End VARCHAR(50) NOT NULL DEFAULT 'Brasil';

ALTER TABLE Enderecos
MODIFY COLUMN CEP_End VARCHAR(10) NOT NULL;

ALTER TABLE Enderecos
CHANGE COLUMN Num_End Numero_Endereco FLOAT NOT NULL;

ALTER TABLE Enderecos
CHANGE COLUMN Numero_Endereco Num_End INT NOT NULL;

ALTER TABLE Enderecos
DROP COLUMN Complemento;

DROP TABLE IF EXISTS Clientes_Produtos;
CREATE TABLE IF NOT EXISTS Clientes_Produtos(
    CPF VARCHAR(11),
    Cod_Prod VARCHAR(30),
    PRIMARY KEY(CPF, Cod_Prod),
    CONSTRAINT FK_Clientes_Produtos FOREIGN KEY(CPF)
    REFERENCES Clientes(CPF),
    CONSTRAINT FK_Produtos_Clientes FOREIGN KEY (Cod_Prod)
    REFERENCES Produtos(Cod_Prod)
);
ALTER TABLE Clientes_Produtos
ADD COLUMN Data_Compra DATE NOT NULL;

ALTER TABLE Clientes_Produtos
MODIFY COLUMN Data_Compra DATETIME NOT NULL;

ALTER TABLE Clientes_Produtos
CHANGE COLUMN Data_Compra Compra_Data DATETIME NOT NULL;
ALTER TABLE Clientes_Produtos
CHANGE COLUMN Compra_Data Data_Compra DATE NOT NULL;

ALTER TABLE Clientes_Produtos
DROP COLUMN Data_Compra;

DROP TABLE IF EXISTS Vendas_Produtos;
CREATE TABLE IF NOT EXISTS Vendas_Produtos(
    Cod_Venda VARCHAR(50),
    Cod_Prod VARCHAR(30),
    PRIMARY KEY(Cod_Venda, Cod_Prod),
    CONSTRAINT FK_Vendas_Produtos FOREIGN KEY(Cod_Venda)
    REFERENCES Vendas(Cod_Venda),
    CONSTRAINT FK_Produtos_Vendas FOREIGN KEY (Cod_Prod)
    REFERENCES Produtos(Cod_Prod)
);

ALTER TABLE Vendas_Produtos
ADD COLUMN Quantidade INT NOT NULL;

ALTER TABLE Vendas_Produtos
MODIFY COLUMN Quantidade FLOAT NOT NULL;

ALTER TABLE Vendas_Produtos
CHANGE COLUMN Cod_Prod Codigo_Produto VARCHAR(30) NOT NULL;
ALTER TABLE Vendas_Produtos
CHANGE COLUMN Codigo_Produto Cod_Prod VARCHAR(30) NOT NULL;

ALTER TABLE Vendas_Produtos
DROP COLUMN Quantidade;
