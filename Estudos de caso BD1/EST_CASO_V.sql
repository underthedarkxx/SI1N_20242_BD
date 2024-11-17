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

INSERT INTO Pagamentos (Cod_Pagamentos, Data_Pagamentos, Valor_Pagamentos, Estado_Pagamento, FK_Venda)
VALUES 
('PAG001', '2024-11-17', 1500.00, 'CONCLUÍDO', 'VENDA001'),
('PAG002', '2024-11-18', 320.75, 'PENDENTE', 'VENDA002'),
('PAG003', '2024-11-19', 450.50, 'EM ESPERA', 'VENDA003');

UPDATE Pagamentos
SET Valor_Pagamentos = 2500.00, Estado_Pagamento = 'PENDENTE'
WHERE Cod_Pagamentos = 'PAG001';

UPDATE Pagamentos
SET Valor_Pagamentos = 2000.00, Estado_Pagamento = 'CONCLUÍDO'
WHERE Cod_Pagamentos = 'PAG002';

DELETE FROM Pagamentos
WHERE Estado_Pagamento = 'EM ESPERA' AND Cod_Pagamentos = 'PAG003';


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

INSERT INTO Clientes (CPF, Nome_Completo_Clientes, Data_Nasc_Clientes, Status_Fideli_Cliente, FK_Pagamentos)
VALUES
('12345678901', 'João Silva', '1985-07-20', 'Ouro', 'PAG001'),
('23456789012', 'Maria Souza', '1990-11-15', 'Prata', 'PAG002'),
('34567890123', 'Carlos Oliveira', '1982-03-10', 'Normal', 'PAG003');

UPDATE Clientes
SET Status_Fideli_Cliente = 'Platinum'
WHERE CPF = '12345678901';

UPDATE Clientes
SET Status_Fideli_Cliente = 'Prata'
WHERE CPF = '23456789012';

DELETE FROM Clientes
WHERE CPF = '34567890123';


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

INSERT INTO Vendas (Cod_Venda, Nome_comprados, QTD_Comprados)
VALUES
('VENDA001', 'Produto A', 10),
('VENDA002', 'Produto B', 5),
('VENDA003', 'Produto C', 20);

UPDATE Vendas
SET Nome_comprados = 'Produto X'
WHERE Cod_Venda = 'VENDA001';

UPDATE Vendas
SET Nome_comprados = 'Produto Y'
WHERE Cod_Venda = 'VENDA002';

DELETE FROM Vendas
WHERE Cod_Venda = 'VENDA003';

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

INSERT INTO Produtos (Cod_Prod, Estoque, Preco, Categoria)
VALUES
('PROD001', 'Estoque A', 299.99, 'Eletrônicos'),
('PROD002', 'Estoque B', 59.99, 'Roupas'),
('PROD003', 'Estoque C', 499.50, 'Móveis');

UPDATE Produtos
SET Preco = 279.99
WHERE Cod_Prod = 'PROD001';

UPDATE Produtos
SET Preco = 259.99
WHERE Cod_Prod = 'PROD002';

DELETE FROM Produtos
WHERE Cod_Prod = 'PROD003';


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

INSERT INTO Fornecedores (Cod_Fornecedores, Contato_Fornecedor, Produtos_Fornecidos, Cod_Prod)
VALUES
('FORN001', 'João da Silva', 'Produto A', 'PROD001'),
('FORN002', 'Maria Oliveira', 'Produto B', 'PROD002'),
('FORN003', 'Carlos Pereira', 'Produto C', 'PROD003');

UPDATE Fornecedores
SET Contato_Fornecedor = 'Maria Santos', Produtos_Fornecidos = 'Produto X'
WHERE Cod_Fornecedores = 'FORN001';

UPDATE Fornecedores
SET Contato_Fornecedor = 'Maria Santana', Produtos_Fornecidos = 'Produto Y'
WHERE Cod_Fornecedores = 'FORN002';

DELETE FROM Fornecedores
WHERE Cod_Fornecedores = 'FORN003';

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

INSERT INTO Enderecos (ID_Enderecos, Num_End, Tipo_End, Logradouro_End, CEP_End, Bairro_End, Estado_End, Cidade_End, CPF, Pais_End)
VALUES
(1, 123, 'Residencial', 'Rua A', '12345678', 'Bairro X', 'São Paulo', 'São Paulo', '12345678901', 'Brasil'),
(2, 456, 'Comercial', 'Avenida B', '87654321', 'Bairro Y', 'Rio de Janeiro', 'Rio de Janeiro', '23456789012', 'Brasil'),
(3, 789, 'Residencial', 'Rua C', '13579246', 'Bairro Z', 'Belo Horizonte', 'Minas Gerais', '34567890123', 'Brasil');

UPDATE Enderecos
SET Tipo_End = 'Comercial', Bairro_End = 'Bairro X'
WHERE ID_Enderecos = 1;

UPDATE Enderecos
SET Tipo_End = 'Residencial', Bairro_End = 'Bairro Y'
WHERE ID_Enderecos = 2;

DELETE FROM Enderecos
WHERE ID_Enderecos = 3;

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

INSERT INTO Clientes_Produtos (CPF, Cod_Prod)
VALUES
('12345678901', 'PROD001'),
('23456789012', 'PROD002'),
('34567890123', 'PROD003');

UPDATE Clientes_Produtos
SET Cod_Prod = 'PROD004'
WHERE CPF = '12345678901';

UPDATE Clientes_Produtos
SET Cod_Prod = 'PROD005'
WHERE CPF = '23456789012';

DELETE FROM Clientes_Produtos
WHERE CPF = '34567890123';


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

INSERT INTO Vendas_Produtos (Cod_Venda, Cod_Prod)
VALUES
('VENDA001', 'PROD001'),
('VENDA002', 'PROD002'),
('VENDA003', 'PROD003');

UPDATE Vendas_Produtos
SET Cod_Prod = 'PROD004'
WHERE Cod_Venda = 'VENDA001';

UPDATE Vendas_Produtos
SET Cod_Prod = 'PROD005'
WHERE Cod_Venda = 'VENDA002';

DELETE FROM Vendas_Produtos
WHERE Cod_Venda = 'VENDA003';
