-- Active: 1728688414725@@127.0.0.1@3306@est_caso_v
#CREATE SCHEMA Est_Caso_V;

Use Est_Caso_V;

CREATE TABLE IF NOT EXISTS Clientes(
    CPF VARCHAR(11) PRIMARY KEY,
    Nome_Clientes VARCHAR(75) NOT NULL,
    Data_Nasc_Clientes DATE NOT NULL,
    Status_Fideli_Cliente ENUM('Normal','Prata','Ouro'),
    Cod_Pagamentos VARCHAR(50),
    CONSTRAINT FK_Pagamento_Clientes FOREIGN KEY(Cod_Pagamentos)
    REFERENCES Pagamentos(Cod_Pagamentos)
);

CREATE TABLE IF NOT EXISTS Pagamentos(
    Cod_Pagamentos VARCHAR(50) PRIMARY KEY,
    Data_Pagamentos DATE NOT NULL,
    Valor_Pagamentos FLOAT NOT NULL,
    Status_Pagamento ENUM('PENDENTE','CONCLUÍDO','EM ESPERA'),
    Cod_Venda VARCHAR(50),
    CONSTRAINT FK_Vendas_Pag FOREIGN KEY (Cod_Venda)
    REFERENCES Vendas(Cod_Venda)
);

CREATE TABLE IF NOT EXISTS Vendas(
    Cod_Venda VARCHAR(50) PRIMARY KEY,
    Nome_comprados VARCHAR(50) NOT NULL,
    QTD_Comprados INT not null,
    Cod_Pagamentos VARCHAR(50),
    CONSTRAINT FK_Pag_Vendas FOREIGN KEY (Cod_Pagamentos)
    REFERENCES Pagamentos(Cod_Pagamentos)
);

CREATE TABLE IF NOT EXISTS Produtos(
    Cod_Prod VARCHAR(30) PRIMARY KEY,
    Estoque VARCHAR(100) NOT NULL,
    Preco FLOAT NOT NULL,
    Categoria VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Fornecedores(
    Cod_Fornecedores VARCHAR(30) PRIMARY KEY,
    Contato_Fornecedor VARCHAR(50) NOT NULL,
    Produtos_Fornecidos VARCHAR(50) NOT NULL,
    Cod_Prod VARCHAR(30),
    CONSTRAINT FK_Prod_Forn FOREIGN KEY (Cod_Prod)
    REFERENCES Produtos(Cod_Prod)
);
