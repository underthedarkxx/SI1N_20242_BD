-- Active: 1728688414725@@127.0.0.1@3306@est_caso_iii
#CREATE SCHEMA Est_Caso_III;
Use Est_Caso_III;

DROP TABLE IF EXISTS Clientes;
CREATE TABLE IF NOT EXISTS Clientes (
    cod_Cliente INT PRIMARY KEY,
    CNPJ_Clientes VARCHAR(18) NULL,
    Razao_Social VARCHAR(100) NOT NULL,
    Data_de_Cadastramento DATE NOT NULL,
    P_Contato_Clientes VARCHAR(100),
    Email_Clientes VARCHAR(100) NOT NULL,
    Id_Enderecos INT
);

ALTER TABLE Clientes
ADD CONSTRAINT FK_End_Clientes FOREIGN KEY (Id_Enderecos) REFERENCES Enderecos(ID_Enderecos);

ALTER TABLE Clientes
ADD COLUMN Email_Clientes VARCHAR(100) NOT NULL;

ALTER TABLE Clientes
CHANGE COLUMN Razao_Social Nome_Razao_Social VARCHAR(50) NOT NULL;

ALTER TABLE Clientes
CHANGE COLUMN  Nome_Razao_Social Razao_Social VARCHAR(100) NOT NULL;

ALTER TABLE Clientes
DROP COLUMN Data_de_Cadastramento;

ALTER TABLE Clientes
MODIFY COLUMN CNPJ_Clientes VARCHAR(18) NULL;

INSERT INTO Clientes (cod_Cliente, CNPJ_Clientes, Razao_Social, P_Contato_Clientes, Email_Clientes, Id_Enderecos)
VALUES 
    (1, '12.345.678/0001-90', 'Empresa A', 'Contato A', 'email@empresaA.com', 101),
    (2, '98.765.432/0001-21', 'Empresa B', 'Contato B', 'email@empresaB.com', 102),
    (3, '11.223.344/0001-55', 'Empresa C', 'Contato C', 'email@empresaC.com', 103),
    (4, '12.345.677/0001-91', 'Empresa D', 'Contato D', 'email@empresaD.com', 104),
    (5, '98.765.432/0001-22', 'Empresa E', 'Contato E', 'email@empresaE.com', 105);
UPDATE Clientes
SET Razao_Social = 'Nova Razão Social', P_Contato_Clientes = 'Novo Contato', Email_Clientes = 'novoemail@empresa.com'
WHERE cod_Cliente = 1 AND CNPJ_Clientes = '12.345.678/0001-90';

UPDATE Clientes
SET Razao_Social = 'Nova Razão Social 2', P_Contato_Clientes = 'Novo Contato 2', Email_Clientes = 'novo2email@empresa.com'
WHERE cod_Cliente = 2 AND CNPJ_Clientes = '98.765.432/0001-21';

DELETE FROM Clientes
WHERE cod_Cliente = 3 AND CNPJ_Clientes = '11.223.344/0001-55';


DROP TABLE IF EXISTS Encomendas;
CREATE TABLE IF NOT EXISTS Encomendas(
    Num_Encomendas INT PRIMARY KEY,
    Data_Inclusao_Enc DATE NOT NULL,
    Valor_Total_Enc FLOAT NOT NULL,
    Valor_Desc_Enc FLOAT,
    Valor_Liq_Enc Float NOT NULL,
    ID_Forma_Pag INT NOT NULL,
    Quant_Pac INT
);
ALTER TABLE Encomendas
ADD COLUMN Status_Encomenda VARCHAR(20) NOT NULL DEFAULT 'PENDENTE';

ALTER TABLE Encomendas
MODIFY COLUMN Valor_Liq_Enc DECIMAL(10, 2) NOT NULL;

ALTER TABLE Encomendas
CHANGE COLUMN Quant_Pac Quantidade_Pacotes INT;

ALTER TABLE Encomendas
CHANGE COLUMN Quantidade_Pacotes Quant_Pac INT;

ALTER TABLE Encomendas
DROP COLUMN Valor_Desc_Enc;

INSERT INTO Encomendas (Num_Encomendas, Data_Inclusao_Enc, Valor_Total_Enc, Valor_Liq_Enc, ID_Forma_Pag, Quant_Pac, Status_Encomenda)
VALUES 
(1, '2024-11-17', 500.00, 450.00, 1, 5, 'PENDENTE'),
(2, '2024-11-18', 1000.00, 900.00, 2, 10, 'PENDENTE', 100.00),
(3, '2024-11-19', 750.00, 700.00, 3, 8, 'PENDENTE'),
(4, '2024-11-20', 1200.00, 1200.00, 1, 12, 'CONFIRMADA'),
(5, '2024-11-21', 600.00, 600.00, 2, 6, 'PENDENTE');

UPDATE Encomendas
SET Valor_Liq_Enc = 460.00
WHERE Num_Encomendas = 1 AND Status_Encomenda = 'PENDENTE';

UPDATE Encomendas
SET Status_Encomenda = 'ENVIADA'
WHERE Num_Encomendas = 2 AND Status_Encomenda = 'PENDENTE';

DELETE FROM Encomendas
WHERE Status_Encomenda = 'PENDENTE';


DROP TABLE IF EXISTS Enderecos;
CREATE TABLE IF NOT EXISTS Enderecos (
    ID_Enderecos INT PRIMARY KEY,
    Num_End INT NOT NULL,
    Tipo_End VARCHAR(20) NOT NULL,
    Logradouro_End VARCHAR(50) NOT NULL,
    CEP_End INT NOT NULL,
    Bairro_End VARCHAR(50) NOT NULL,
    Estado_End VARCHAR(30) NOT NULL,
    Cidade_End VARCHAR(50) NOT NULL,
    cod_Clientes INT,
    Matricula_Emp INT
);
ALTER TABLE Enderecos
ADD CONSTRAINT FK_End_Cli FOREIGN KEY (cod_Clientes) REFERENCES Clientes(cod_Cliente),
ADD CONSTRAINT FK_End_Emp FOREIGN KEY (Matricula_Emp) REFERENCES Empregados(Matricula_Empre);


ALTER TABLE Enderecos
ADD COLUMN Pais_End VARCHAR(50) DEFAULT 'Brasil';

ALTER TABLE Enderecos
MODIFY COLUMN CEP_End VARCHAR(10) NULL;

ALTER TABLE Enderecos
CHANGE COLUMN Num_End Numero_Endereco VARCHAR(10) NOT NULL;

ALTER TABLE Enderecos
CHANGE COLUMN Numero_Endereco Num_End  INT NOT NULL;

ALTER TABLE Enderecos
DROP COLUMN Pais_End;

INSERT INTO Enderecos (ID_Enderecos, Num_End, Tipo_End, Logradouro_End, CEP_End, Bairro_End, Estado_End, Cidade_End, cod_Clientes, Matricula_Emp)
VALUES
    (1, 123, 'Residencial', 'Rua das Flores', '12345-678', 'Bairro Jardim', 'São Paulo', 'São Paulo', 1, 1001),
    (2, 456, 'Comercial', 'Avenida Paulista', '23456-789', 'Bairro Centro', 'São Paulo', 'São Paulo', 2, 1002),
    (3, 789, 'Industrial', 'Rua da Indústria', '34567-890', 'Bairro Industrial', 'Campinas', 'Campinas', 3, 1003),
    (4, 101, 'Residencial', 'Rua dos Lírios', '45678-901', 'Bairro Nova Esperança', 'Rio de Janeiro', 'Rio de Janeiro', 4, 1004),
    (5, 202, 'Comercial', 'Avenida Brasil', '56789-012', 'Bairro Boa Vista', 'Belo Horizonte', 'Belo Horizonte', 5, 1005);

UPDATE Enderecos
SET Logradouro_End = 'Rua D', Estado_End = 'Estado F'
WHERE ID_Enderecos = 2 AND Cidade_End = 'Cidade U';

UPDATE Enderecos
SET Bairro_End = 'Bairro Z', Num_End = 321
WHERE ID_Enderecos = 3 AND Estado_End = 'Estado S';

DELETE FROM Enderecos
WHERE ID_Enderecos = 1 AND Bairro_End = 'Bairro X';

DROP TABLE IF EXISTS Empregados;

CREATE TABLE IF NOT EXISTS Empregados (
    Matricula_Empre INT PRIMARY KEY,
    Nome_Empre VARCHAR(50) NOT NULL,
    Cargo_Empre VARCHAR(30) NOT NULL,
    Salario_Empre FLOAT NOT NULL,
    Data_Adimissao_Empre DATE,
    Qualificacoes_Empre VARCHAR(30),
    ID_Endereco INT
);
ALTER TABLE Empregados
ADD CONSTRAINT FK_Empregados FOREIGN KEY (ID_Endereco) REFERENCES Enderecos(ID_Enderecos);
ALTER TABLE Empregados
MODIFY COLUMN Cargo_Empre VARCHAR(50) NOT NULL;

ALTER TABLE Empregados
ADD COLUMN Departamento_Empre VARCHAR(50);

ALTER TABLE Empregados
MODIFY COLUMN Salario_Empre DECIMAL(10,2) NOT NULL;

ALTER TABLE Empregados
CHANGE COLUMN Qualificacoes_Empre Habilidades_Empre TEXT;
ALTER TABLE Empregados
CHANGE COLUMN Habilidades_Empre Qualificacoes_Empre TEXT;
ALTER TABLE Empregados
DROP COLUMN Data_Adimissao_Empre;

-- Inserir múltiplos registros na tabela Empregados
INSERT INTO Empregados (Matricula_Empre, Nome_Empre, Cargo_Empre, Salario_Empre, Qualificacoes_Empre, ID_Endereco, Departamento_Empre)
VALUES
    (1001, 'João Silva', 'Analista de Sistemas', 3500.00, 'Java, SQL', 1, 'TI'),
    (1002, 'Maria Oliveira', 'Gerente de Projetos', 6500.00, 'Gestão de Projetos, Scrum', 2, 'Gestão'),
    (1003, 'Carlos Pereira', 'Desenvolvedor Frontend', 4000.00, 'HTML, CSS, JavaScript', 3, 'Desenvolvimento'),
    (1004, 'Ana Costa', 'Coordenadora de Marketing', 5500.00, 'SEO, Marketing Digital', 4, 'Marketing'),
    (1005, 'Paulo Santos', 'Analista de Dados', 4500.00, 'Python, Excel, BI', 5, 'TI');

UPDATE Empregados
SET Cargo_Empre = 'Coordenador de TI', Salario_Empre = 7000.00
WHERE Matricula_Empre = 1001 AND Nome_Empre = 'João Silva';

UPDATE Empregados
SET Qualificacoes_Empre = 'Gestão de Equipes, Scrum'
WHERE Matricula_Empre = 1002 AND Nome_Empre = 'Maria Oliveira';

DELETE FROM Empregados
WHERE Matricula_Empre = 1005 AND Nome_Empre = 'Paulo Santos';

DROP TABLE IF EXISTS Telefone;
CREATE TABLE IF NOT EXISTS Telefone(
    cod_Tel INT PRIMARY KEY,
    Tel_Fixo VARCHAR(10),
    Tel_Cel VARCHAR(14),
    Matricula_Emp INT,
    CNPJ_Fornecedores_Tel VARCHAR(18)
);
ALTER TABLE Telefone
ADD CONSTRAINT FK_Tel_Emp FOREIGN KEY(Matricula_Emp)
REFERENCES Empregados(Matricula_Empre);

ALTER TABLE Telefone
ADD CONSTRAINT FK_Tel_Forn FOREIGN KEY(CNPJ_Fornecedores_Tel)
REFERENCES Empresas(CNPJ_Empresas);

ALTER TABLE Telefone
ADD COLUMN Email_Telefone VARCHAR(50);

ALTER TABLE Telefone
MODIFY COLUMN Tel_Fixo VARCHAR(15);

ALTER TABLE Telefone
CHANGE COLUMN Tel_Cel Telefone_Celular VARCHAR(20);

ALTER TABLE Telefone
CHANGE COLUMN Telefone_Celular Tel_Cel VARCHAR(14);

ALTER TABLE Telefone
DROP COLUMN Email_Telefone;

INSERT INTO Telefone (cod_Tel, Tel_Fixo, Tel_Cel, Matricula_Emp, CNPJ_Fornecedores_Tel)
VALUES 
    (1, '1234567890', '11987654321', 1001, NULL),
    (2, '2234567890', '21987654321', NULL, '12.345.678/0001-99'),
    (3, '3234567890', '31987654321', 1002, NULL),
    (4, '4234567890', '41987654321', NULL, '98.765.432/0001-22'),
    (5, '5234567890', '51987654321', 1003, NULL);

UPDATE Telefone
SET Tel_Fixo = '1324657890'
WHERE cod_Tel = 1 AND Tel_Cel = '11987654321';

UPDATE Telefone
SET CNPJ_Fornecedores_Tel = '11.222.333/0001-44'
WHERE cod_Tel = 2 AND Tel_Fixo = '2234567890';

DELETE FROM Telefone
WHERE cod_Tel = 1 AND Tel_Cel = '11987654321';

DROP TABLE IF EXISTS Fornecedores;
CREATE TABLE IF NOT EXISTS Fornecedores(
    CNPJ_Fornecedores VARCHAR(18) PRIMARY KEY,
    Nome_Fornecedor VARCHAR(50)
);
ALTER TABLE Fornecedores
ADD COLUMN Email_Fornecedor VARCHAR(100);

ALTER TABLE Fornecedores
MODIFY COLUMN Nome_Fornecedor VARCHAR(100);

ALTER TABLE Fornecedores
CHANGE COLUMN Nome_Fornecedor Nome_Fornec VARCHAR(45);

ALTER TABLE Fornecedores
CHANGE COLUMN Nome_Fornec Nome_Fornecedor VARCHAR(20);

ALTER TABLE Fornecedores
DROP COLUMN Email_Fornecedor;

INSERT INTO Fornecedores (CNPJ_Fornecedores, Nome_Fornecedor) VALUES 
('11.222.333/0001-44', 'Fornecedor A'),
('22.333.444/0001-55', 'Fornecedor B'),
('33.444.555/0001-66', 'Fornecedor C'),
('44.555.666/0001-77', 'Fornecedor D'),
('55.666.777/0001-88', 'Fornecedor E');

UPDATE Fornecedores
SET Nome_Fornecedor = 'Novo Fornecedor A'
WHERE CNPJ_Fornecedores = '11.222.333/0001-44' AND Nome_Fornecedor = 'Fornecedor A';

UPDATE Fornecedores
SET Nome_Fornecedor = 'Fornecedor B Atualizado'
WHERE CNPJ_Fornecedores = '22.333.444/0001-55' AND Nome_Fornecedor = 'Fornecedor B';

DELETE FROM Fornecedores
WHERE CNPJ_Fornecedores = '33.444.555/0001-66' AND Nome_Fornecedor = 'Fornecedor C';


DROP TABLE IF EXISTS Empresas;
CREATE TABLE IF NOT EXISTS Empresas(
    CNPJ_Empresas VARCHAR(18) PRIMARY KEY,
    Razao_Social VARCHAR(50),
    P_Contato_Empresas VARCHAR(50),
    CNPJ_Fornecedores_Emp VARCHAR(18)
);
ALTER TABLE Empresas
ADD CONSTRAINT FK_Emp_Forne FOREIGN KEY(CNPJ_Fornecedores_Emp)
REFERENCES Fornecedores(CNPJ_Fornecedores);

ALTER TABLE Empresas
ADD COLUMN Endereco_Empresa VARCHAR(100);

ALTER TABLE Empresas
MODIFY COLUMN Razao_Social VARCHAR(100);

ALTER TABLE Empresas
CHANGE COLUMN P_Contato_Empresas Contato_Empresa VARCHAR(200);

ALTER TABLE Empresas
CHANGE COLUMN Contato_Empresa P_Contato_Empresas VARCHAR(100);

ALTER TABLE Empresas
DROP COLUMN Endereco_Empresa;

INSERT INTO Empresas (CNPJ_Empresas, Razao_Social, P_Contato_Empresas, CNPJ_Fornecedores_Emp)
VALUES 
('11.222.333/0001-44', 'Empresa A', 'Contato Empresa A', '22.333.444/0001-55'),
('22.333.444/0001-55', 'Empresa B', 'Contato Empresa B', '33.444.555/0001-66'),
('33.444.555/0001-66', 'Empresa C', 'Contato Empresa C', '44.555.666/0001-77'),
('44.555.666/0001-77', 'Empresa D', 'Contato Empresa D', '55.666.777/0001-88'),
('55.666.777/0001-88', 'Empresa E', 'Contato Empresa E', '66.777.888/0001-99');

UPDATE Empresas
SET Razao_Social = 'Empresa A Atualizada'
WHERE CNPJ_Empresas = '11.222.333/0001-44' AND Razao_Social = 'Empresa A';

UPDATE Empresas
SET P_Contato_Empresas = 'Novo Contato Empresa B'
WHERE CNPJ_Empresas = '22.333.444/0001-55' AND P_Contato_Empresas = 'Contato Empresa B';

DELETE FROM Empresas
WHERE CNPJ_Empresas = '44.555.666/0001-77' AND Razao_Social = 'Empresa D';


DROP TABLE IF EXISTS Produtos;
CREATE TABLE IF NOT EXISTS Produtos(
    Cod_Produtos INT PRIMARY KEY,
    Nome_Produtos VARCHAR(50) NOT NULL,
    Cor_Produtos VARCHAR(20) NOT NULL,
    Dimensoes_Produtos FLOAT NOT NULL,
    Peso_Produtos FLOAT NOT NULL,
    Preco_Produtos FLOAT NOT NULL,
    Tempo_Fabri_Produtos TIME NOT NULL,
    Desenho_Produtos INT,
    Cod_RS_Prod INT,
    CONSTRAINT FK_RS_Prod FOREIGN KEY (Cod_RS_Prod)
    REFERENCES Registro_Suprimentos(Cod_RS)
);

ALTER TABLE Produtos
ADD COLUMN Categoria_Produtos VARCHAR(30);

ALTER TABLE Produtos
MODIFY COLUMN Preco_Produtos DECIMAL(10,2) NOT NULL;

ALTER TABLE Produtos
CHANGE COLUMN Desenho_Produtos Desenho_Prod FLOAT;

ALTER TABLE Produtos
CHANGE COLUMN Desenho_Prod Desenho_Produtos INT;

-- Deletando a tabela Categoria_Produtos
DROP TABLE IF EXISTS Categoria_Produtos;



ALTER TABLE Produtos
ADD COLUMN Categoria_Produtos VARCHAR(30);

ALTER TABLE Produtos
MODIFY COLUMN Preco_Produtos DECIMAL(10,2) NOT NULL;

ALTER TABLE Produtos
CHANGE COLUMN Desenho_Produtos Desenho_Prod FLOAT;

ALTER TABLE Produtos
CHANGE COLUMN  Desenho_Prod Desenho_Produtos INT;

INSERT INTO Produtos (Cod_Produtos, Nome_Produtos, Cor_Produtos, Dimensoes_Produtos, Peso_Produtos, Preco_Produtos, Tempo_Fabri_Produtos, Desenho_Produtos, Cod_RS_Prod, Categoria_Produtos)
VALUES 
(1, 'Produto A', 'Vermelho', 30.5, 1.2, 99.99, '02:00:00', 123, 1, 'Categoria 1'),
(2, 'Produto B', 'Azul', 20.3, 0.9, 59.50, '01:30:00', 124, 2, 'Categoria 2'),
(3, 'Produto C', 'Verde', 25.0, 1.5, 75.00, '03:00:00', 125, 3, 'Categoria 1'),
(4, 'Produto D', 'Amarelo', 35.4, 1.3, 120.00, '02:45:00', 126, 4, 'Categoria 3'),
(5, 'Produto E', 'Preto', 40.0, 1.0, 85.75, '01:50:00', 127, 5, 'Categoria 2');

UPDATE Produtos
SET Preco_Produtos = 109.99
WHERE Cod_Produtos = 1 AND Nome_Produtos = 'Produto A';

UPDATE Produtos
SET Categoria_Produtos = 'Categoria Atualizada'
WHERE Cod_Produtos = 2 AND Cor_Produtos = 'Azul';

DELETE FROM Produtos
WHERE Cod_Produtos = 3 AND Nome_Produtos = 'Produto C';

DROP TABLE IF EXISTS Categoria_Produtos;

CREATE TABLE IF NOT EXISTS Registro_Suprimentos(
    Cod_RS INT PRIMARY KEY,
    Quantidade_RS INT NOT NULL,
    Data_Necessidade_RS DATE
);

ALTER TABLE Registro_Suprimentos
ADD COLUMN Data_Entrega_RS DATE;

ALTER TABLE Registro_Suprimentos
MODIFY COLUMN Quantidade_RS INT NOT NULL;

ALTER TABLE Registro_Suprimentos
CHANGE COLUMN Data_Necessidade_RS Data_Registro_RS DATE;

ALTER TABLE Registro_Suprimentos
DROP COLUMN Data_Entrega_RS;

INSERT INTO Registro_Suprimentos (Cod_RS, Quantidade_RS, Data_Registro_RS)
VALUES 
(1, 100, '2024-11-01'),
(2, 200, '2024-11-05'),
(3, 150, '2024-11-10'),
(4, 300, '2024-11-15'),
(5, 50, '2024-11-20');

UPDATE Registro_Suprimentos
SET Quantidade_RS = 120
WHERE Cod_RS = 1 AND Data_Registro_RS = '2024-11-01';

UPDATE Registro_Suprimentos
SET Quantidade_RS = 250
WHERE Cod_RS = 2 AND Data_Registro_RS = '2024-11-05';

DELETE FROM Registro_Suprimentos
WHERE Cod_RS = 3 AND Quantidade_RS = 150;

DROP TABLE IF EXISTS Componentes;
CREATE TABLE IF NOT EXISTS Componentes(
    Cod_Componentes INT PRIMARY KEY,
    Nome_Componentes VARCHAR(100) NOT NULL,
    Tipo_Componentes VARCHAR(100) NOT NULL,
    QTD_Estoque_Componentes INT NOT NULL,
    Preco_Unit_Componentes FLOAT NOT NULL,
    Unidade_Componente INT NOT NULL
);

ALTER TABLE Componentes
ADD COLUMN Data_Compra_Componentes DATE;

ALTER TABLE Componentes
MODIFY COLUMN Preco_Unit_Componentes DECIMAL(10, 2) NOT NULL;

ALTER TABLE Componentes
CHANGE COLUMN QTD_Estoque_Componentes Quantidade_Estoque_Componentes INT NOT NULL;

ALTER TABLE Componentes
DROP COLUMN Data_Compra_Componentes;

INSERT INTO Componentes (Cod_Componentes, Nome_Componentes, Tipo_Componentes, Quantidade_Estoque_Componentes, Preco_Unit_Componentes, Unidade_Componente)
VALUES
(1, 'Resistor 100 Ohm', 'Resistor', 100, 0.10, 1),
(2, 'Capacitor 10uF', 'Capacitor', 50, 0.25, 1),
(3, 'Transistor NPN', 'Transistor', 200, 0.50, 1),
(4, 'LED Vermelho', 'LED', 150, 0.05, 1),
(5, 'Diodo Zener 5.6V', 'Diodo', 75, 0.30, 1);

UPDATE Componentes
SET Preco_Unit_Componentes = 0.12
WHERE Nome_Componentes = 'Resistor 100 Ohm' AND Cod_Componentes = 1;

UPDATE Componentes
SET Quantidade_Estoque_Componentes = 60
WHERE Nome_Componentes = 'Capacitor 10uF' AND Cod_Componentes = 2;

DELETE FROM Componentes
WHERE Cod_Componentes = 3 AND Nome_Componentes = 'Transistor NPN';


DROP TABLE IF EXISTS Registro_Manutencao;

CREATE TABLE IF NOT EXISTS Registro_Manutencao(
    Cod_RM INT PRIMARY KEY,
    Data_RM DATE NOT NULL,
    Descricao_RM TEXT NOT NULL,
    Cod_Maq_RM INT
);

ALTER TABLE Registro_Manutencao
DROP CONSTRAINT FK_Maq_RM;

ALTER TABLE Registro_Manutencao
ADD CONSTRAINT FK_Maq_RM FOREIGN KEY(Cod_Maq_RM)
REFERENCES Maquinas(Cod_Maquina);
ALTER TABLE Registro_Manutencao
ADD COLUMN Tipo_Manutencao VARCHAR(50) NOT NULL;

ALTER TABLE Registro_Manutencao
MODIFY COLUMN Descricao_RM VARCHAR(255) NOT NULL;

ALTER TABLE Registro_Manutencao
CHANGE COLUMN Cod_Maq_RM Cod_Maquina_RM INT;

ALTER TABLE Registro_Manutencao
DROP COLUMN Tipo_Manutencao;

INSERT INTO Registro_Manutencao (Cod_RM, Data_RM, Descricao_RM, Cod_Maquina_RM)
VALUES
(1, '2024-11-10', 'Manutenção preventiva na máquina A', 101),
(2, '2024-11-12', 'Troca de peças da máquina B', 102),
(3, '2024-11-15', 'Ajuste no sistema hidráulico da máquina C', 103),
(4, '2024-11-18', 'Reparo de motor na máquina D', 104),
(5, '2024-11-20', 'Inspeção geral na máquina E', 105);

UPDATE Registro_Manutencao
SET Descricao_RM = 'Manutenção de emergência na máquina A'
WHERE Cod_RM = 1 AND Cod_Maquina_RM = 101;

UPDATE Registro_Manutencao
SET Data_RM = '2024-11-22'
WHERE Cod_RM = 2 AND Cod_Maquina_RM = 102;

DELETE FROM Registro_Manutencao
WHERE Cod_RM = 3 AND Cod_Maquina_RM = 103;


DROP TABLE IF EXISTS Maquinas;

CREATE TABLE IF NOT EXISTS Maquinas(
    Cod_Maquina INT PRIMARY KEY,
    Temp_Vida_Maquina DATE NOT NULL,
    Data_Compra_Maquina DATE NOT NULL,
    Data_Fim_Garan_Maquina DATE NOT NULL,
    Cod_RM_Maq INT,
    CONSTRAINT FK_RM_Maq FOREIGN KEY (Cod_RM_Maq)
    REFERENCES Registro_Manutencao(Cod_RM)
);


ALTER TABLE Maquinas
ADD COLUMN Status_Maquina VARCHAR(20) NOT NULL DEFAULT 'Ativa';

ALTER TABLE Maquinas
MODIFY COLUMN Temp_Vida_Maquina DATE NOT NULL;

ALTER TABLE Maquinas
CHANGE COLUMN Cod_RM_Maq Cod_Registro_Maquina INT;

ALTER TABLE Maquinas
CHANGE COLUMN Cod_Registro_Maquina Cod_RM_Maq INT;

ALTER TABLE Maquinas
DROP COLUMN Status_Maquina;

INSERT INTO Maquinas (Cod_Maquina, Temp_Vida_Maquina, Data_Compra_Maquina, Data_Fim_Garan_Maquina, Cod_RM_Maq)
VALUES
(1, '2028-12-01', '2024-01-10', '2025-01-10', 101),
(2, '2029-05-01', '2024-02-15', '2026-02-15', 102),
(3, '2030-03-01', '2024-03-20', '2026-03-20', 103),
(4, '2031-07-01', '2024-04-25', '2027-04-25', 104),
(5, '2032-06-01', '2024-05-30', '2028-05-30', 105);

UPDATE Maquinas
SET Status_Maquina = 'Inativa'
WHERE Cod_Maquina = 1 AND Cod_RM_Maq = 101;

UPDATE Maquinas
SET Data_Compra_Maquina = '2024-06-15'
WHERE Cod_Maquina = 2 AND Cod_RM_Maq = 102;

DELETE FROM Maquinas
WHERE Cod_Maquina = 3 AND Cod_RM_Maq = 103;



DROP TABLE IF EXISTS Recursos_Especificos_RE;
CREATE TABLE IF NOT EXISTS Recursos_Especificos_RE(
    Cod_RE INT PRIMARY KEY,
    Quant_Necessaria INT NOT NULL,
    Unidade_RE VARCHAR(35) NOT NULL,
    Tempo_Uso TIME,
    Horas_Trabalho_RE TIME NOT NULL,
    Horas_Mao_Obra TIME NOT NULL
);

ALTER TABLE Recursos_Especificos_RE
ADD COLUMN Custo_RE DECIMAL(10, 2);

ALTER TABLE Recursos_Especificos_RE
MODIFY COLUMN Quant_Necessaria INT NOT NULL DEFAULT 1;

ALTER TABLE Recursos_Especificos_RE
CHANGE COLUMN Horas_Trabalho_RE Tempo_Trabalho_RE TIME NOT NULL;

ALTER TABLE Recursos_Especificos_RE
CHANGE COLUMN Tempo_Trabalho_RE Horas_Trabalho_RE TIME NOT NULL;

ALTER TABLE Recursos_Especificos_RE
DROP COLUMN Unidade_RE;

INSERT INTO Recursos_Especificos_RE (Cod_RE, Quant_Necessaria, Tempo_Uso, Horas_Trabalho_RE, Horas_Mao_Obra, Custo_RE)
VALUES
(1, 10, '02:00:00', '04:00:00', '08:00:00', 500.00),
(2, 20, '03:00:00', '05:00:00', '07:00:00', 750.00),
(3, 15, '02:30:00', '04:30:00', '06:30:00', 600.00),
(4, 25, '01:30:00', '03:30:00', '08:30:00', 850.00),
(5, 30, '04:00:00', '06:00:00', '09:00:00', 950.00);

UPDATE Recursos_Especificos_RE
SET Custo_RE = 550.00
WHERE Cod_RE = 1 AND Quant_Necessaria = 10;

UPDATE Recursos_Especificos_RE
SET Tempo_Uso = '03:00:00'
WHERE Cod_RE = 2 AND Horas_Trabalho_RE = '05:00:00';

DELETE FROM Recursos_Especificos_RE
WHERE Cod_RE = 3 AND Quant_Necessaria = 15;


DROP TABLE IF EXISTS Registro_Suprimentos;
CREATE TABLE IF NOT EXISTS Registro_Suprimentos(
    Cod_RS INT PRIMARY KEY,
    Quantidade_RS INT NOT NULL,
    Data_Necessidade_RS DATE NOT NULL
);

ALTER TABLE Registro_Suprimentos
ADD COLUMN Descricao_RS VARCHAR(255);

ALTER TABLE Registro_Suprimentos
MODIFY COLUMN Quantidade_RS DECIMAL(10, 2) NOT NULL;

ALTER TABLE Registro_Suprimentos
CHANGE COLUMN Quantidade_RS Quantidade_Registro_Suprimento FLOAT NOT NULL;

ALTER TABLE Registro_Suprimentos
CHANGE COLUMN Quantidade_Registro_Suprimento Quantidade_RS INT NOT NULL;

ALTER TABLE Registro_Suprimentos
DROP COLUMN Descricao_RS;

INSERT INTO Registro_Suprimentos (Cod_RS, Quantidade_RS, Data_Necessidade_RS)
VALUES
(1, 100.00, '2024-11-01'),
(2, 150.50, '2024-11-05'),
(3, 200.00, '2024-11-10'),
(4, 250.75, '2024-11-15'),
(5, 300.00, '2024-11-20');

UPDATE Registro_Suprimentos
SET Quantidade_RS = 120.00
WHERE Cod_RS = 1 AND Data_Necessidade_RS = '2024-11-01';

UPDATE Registro_Suprimentos
SET Data_Necessidade_RS = '2024-11-25'
WHERE Cod_RS = 2 AND Quantidade_RS = 150.50;

DELETE FROM Registro_Suprimentos
WHERE Cod_RS = 3 AND Quantidade_RS = 200.00;


DROP TABLE IF EXISTS Empregados_Produtos;

CREATE TABLE IF NOT EXISTS Empregados_Produtos(
    Matricula_Empre_EMPR INT,
    Cod_Produtos_EMPR INT,
    PRIMARY KEY(Matricula_Empre_EMPR, Cod_Produtos_EMPR),
    CONSTRAINT FK_Empregados_Produtos FOREIGN KEY(Matricula_Empre_EMPR)
    REFERENCES Empregados(Matricula_Empre),
    CONSTRAINT FK_Produtos_Empregados FOREIGN KEY(Cod_Produtos_EMPR)
    REFERENCES Produtos(Cod_Produtos)
);

ALTER TABLE Empregados_Produtos
ADD COLUMN Quantidade_Produtos_EMPR INT NOT NULL;

ALTER TABLE Empregados_Produtos
MODIFY COLUMN Quantidade_Produtos_EMPR INT NULL;

ALTER TABLE Empregados_Produtos
CHANGE COLUMN Cod_Produtos_EMPR Codigo_Produto_EMPR INT;

ALTER TABLE Empregados_Produtos
CHANGE COLUMN Codigo_Produto_EMPR Cod_Produtos_EMPR INT;

ALTER TABLE Empregados_Produtos
DROP COLUMN Quantidade_Produtos_EMPR;


DROP TABLE IF EXISTS Clientes_Empresas;
CREATE TABLE IF NOT EXISTS Clientes_Empresas(
    cod_Cliente INT,
    CNPJ_Empresas VARCHAR(18),
    PRIMARY KEY(cod_Cliente, CNPJ_Empresas),
    CONSTRAINT FK_Clientes_Empresas FOREIGN KEY(cod_Cliente)
    REFERENCES Clientes(cod_Cliente),
    CONSTRAINT FK_Empresas_Clientes FOREIGN KEY(CNPJ_Empresas)
    REFERENCES Empresas(CNPJ_Empresas)
);

ALTER TABLE Clientes_Empresas
ADD COLUMN Data_Parceira DATE NOT NULL;

ALTER TABLE Clientes_Empresas
MODIFY COLUMN CNPJ_Empresas VARCHAR(30) NOT NULL;

ALTER TABLE Clientes_Empresas
CHANGE COLUMN cod_Cliente Codigo_Cliente INT;

ALTER TABLE Clientes_Empresas
CHANGE COLUMN Codigo_Cliente cod_Cliente INT;

ALTER TABLE Clientes_Empresas
DROP COLUMN Data_Parceira;

INSERT INTO Empregados_Produtos (Matricula_Empre_EMPR, Cod_Produtos_EMPR, Quantidade_Produtos_EMPR)
VALUES
(101, 1, 5),
(102, 2, 10),
(103, 3, 8),
(104, 4, 12),
(105, 5, 20);

UPDATE Empregados_Produtos
SET Quantidade_Produtos_EMPR = 7
WHERE Matricula_Empre_EMPR = 101 AND Cod_Produtos_EMPR = 1;

UPDATE Empregados_Produtos
SET Cod_Produtos_EMPR = 6
WHERE Matricula_Empre_EMPR = 102 AND Quantidade_Produtos_EMPR = 10;

DELETE FROM Empregados_Produtos
WHERE Matricula_Empre_EMPR = 103 AND Cod_Produtos_EMPR = 3;


DROP TABLE IF EXISTS Componentes_Fornecedores;
CREATE TABLE IF NOT EXISTS Componentes_Fornecedores(
    Cod_Componentes INT,
    CNPJ_Fornecedores VARCHAR(18),
    PRIMARY KEY(Cod_Componentes, CNPJ_Fornecedores),
    CONSTRAINT FK_Componentes_Fornecedores FOREIGN KEY(Cod_Componentes)
    REFERENCES Componentes(Cod_Componentes),
    CONSTRAINT FK_Fornecedores_Componentes FOREIGN KEY(CNPJ_Fornecedores)
    REFERENCES Fornecedores(CNPJ_Fornecedores)
);

ALTER TABLE Componentes_Fornecedores
ADD COLUMN Data_Fornecedor DATE NOT NULL;

ALTER TABLE Componentes_Fornecedores
MODIFY COLUMN CNPJ_Fornecedores VARCHAR(18) NULL;

ALTER TABLE Componentes_Fornecedores
CHANGE COLUMN Cod_Componentes Codigo_Componente INT;

ALTER TABLE Componentes_Fornecedores
DROP COLUMN Data_Fornecedor;

INSERT INTO Componentes_Fornecedores (Cod_Componentes, CNPJ_Fornecedores)
VALUES
(1, '12345678000100'),
(2, '98765432000101'),
(3, '11223344000102'),
(4, '55667788000103'),
(5, '22334455000104');

UPDATE Componentes_Fornecedores
SET Cod_Componentes = 6
WHERE CNPJ_Fornecedores = '12345678000100' AND Cod_Componentes = 1;

UPDATE Componentes_Fornecedores
SET CNPJ_Fornecedores = '99887766000105'
WHERE Cod_Componentes = 3 AND CNPJ_Fornecedores = '11223344000102';

DELETE FROM Componentes_Fornecedores
WHERE Cod_Componentes = 4 AND CNPJ_Fornecedores = '55667788000103';



DROP TABLE IF EXISTS Enderecos_Empresas;

CREATE TABLE IF NOT EXISTS Enderecos_Empresas(
    ID_Enderecos INT,
    CNPJ_Empresas VARCHAR(18),
    PRIMARY KEY(ID_Enderecos, CNPJ_Empresas),
    CONSTRAINT FK_Enderecos_Empresas FOREIGN KEY(ID_Enderecos)
    REFERENCES Enderecos(ID_Enderecos),
    CONSTRAINT FK_Empresas_Enderecos FOREIGN KEY(CNPJ_Empresas)
    REFERENCES Empresas(CNPJ_Empresas)
);

ALTER TABLE Enderecos_Empresas
ADD COLUMN Data_Associacao DATE;


ALTER TABLE Enderecos_Empresas
MODIFY COLUMN CNPJ_Empresas VARCHAR(20) NOT NULL;

ALTER TABLE Enderecos_Empresas
CHANGE COLUMN Data_Associacao Data_Associacao_Empre DATETIME NOT NULL;

ALTER TABLE Enderecos_Empresas
CHANGE COLUMN Data_Associacao_Empre Data_Associacao DATETIME NOT NULL;

ALTER TABLE Enderecos_Empresas
DROP COLUMN Data_Associacao;

INSERT INTO Enderecos_Empresas (ID_Enderecos, CNPJ_Empresas)
VALUES
(1, '12345678000100'),
(2, '98765432000101'),
(3, '11223344000102'),
(4, '55667788000103'),
(5, '22334455000104');


UPDATE Enderecos_Empresas
SET CNPJ_Empresas = '99887766000105'
WHERE ID_Enderecos = 2 AND CNPJ_Empresas = '98765432000101';

UPDATE Enderecos_Empresas
SET Data_Associacao = '2024-11-17'
WHERE ID_Enderecos = 3 AND CNPJ_Empresas = '11223344000102';

DELETE FROM Enderecos_Empresas
WHERE ID_Enderecos = 4 AND CNPJ_Empresas = '55667788000103';

DELETE FROM Enderecos_Empresas
WHERE CNPJ_Empresas = '22334455000104';


DROP TABLE IF EXISTS Endereço_Fornecedores;
CREATE TABLE IF NOT EXISTS Endereço_Fornecedores(
    ID_Enderecos INT,
    CNPJ_Fornecedores VARCHAR(18),
    PRIMARY KEY(ID_Enderecos, CNPJ_Fornecedores),
    CONSTRAINT FK_Endereço_Fornecedores FOREIGN KEY(CNPJ_Fornecedores)
    REFERENCES Fornecedores(CNPJ_Fornecedores),
    CONSTRAINT FK_Fornecedores_Enderecos FOREIGN KEY(ID_Enderecos)
    REFERENCES Enderecos(ID_Enderecos)
);

ALTER TABLE Endereço_Fornecedores
ADD COLUMN Data_Associacao DATE;

ALTER TABLE Endereço_Fornecedores
MODIFY COLUMN CNPJ_Fornecedores VARCHAR(20) NOT NULL;

ALTER TABLE Endereço_Fornecedores
CHANGE COLUMN CNPJ_Fornecedores CNPJ_Fornecedor VARCHAR(18) NOT NULL;

ALTER TABLE Endereço_Fornecedores
DROP COLUMN Data_Associacao;

-- Inserir 5 registros na tabela Endereço_Fornecedores
INSERT INTO Endereço_Fornecedores (ID_Enderecos, CNPJ_Fornecedores)
VALUES
(1, '12345678000100'),
(2, '98765432000101'),
(3, '11223344000102'),
(4, '55667788000103'),
(5, '22334455000104');

UPDATE Endereço_Fornecedores
SET CNPJ_Fornecedores = '99887766000105'
WHERE ID_Enderecos = 2 AND CNPJ_Fornecedores = '98765432000101';

UPDATE Endereço_Fornecedores
SET Data_Associacao = '2024-11-17'
WHERE ID_Enderecos = 3 AND CNPJ_Fornecedores = '11223344000102';

DELETE FROM Endereço_Fornecedores
WHERE ID_Enderecos = 4 AND CNPJ_Fornecedores = '55667788000103';

DELETE FROM Endereço_Fornecedores
WHERE CNPJ_Fornecedores = '22334455000104';

DROP TABLE IF EXISTS Encomendas_Produtos;
CREATE TABLE IF NOT EXISTS Encomendas_Produtos(
    Num_Encomendas INT,
    Cod_Produtos_EMPR INT,
    PRIMARY KEY(Num_Encomendas, Cod_Produtos_EMPR),
    CONSTRAINT FK_Encomendas_Produtos FOREIGN KEY(Num_Encomendas)
    REFERENCES Encomendas(Num_Encomendas),
    CONSTRAINT FK_Produtos_Encomendas FOREIGN KEY(Cod_Produtos_EMPR)
    REFERENCES Produtos(Cod_Produtos)
);

ALTER TABLE Encomendas_Produtos
ADD COLUMN Data_Encomenda DATE NOT NULL;

ALTER TABLE Encomendas_Produtos
MODIFY COLUMN Cod_Produtos_EMPR INT NOT NULL;

ALTER TABLE Encomendas_Produtos
CHANGE COLUMN Cod_Produtos_EMPR Cod_Produto_Encomenda INT NOT NULL;

ALTER TABLE Encomendas_Produtos
DROP COLUMN Data_Encomenda;

INSERT INTO Encomendas_Produtos (Num_Encomendas, Cod_Produtos_EMPR)
VALUES
(101, 1),
(102, 2),
(103, 3),
(104, 4),
(105, 5);

UPDATE Encomendas_Produtos
SET Cod_Produto_Encomenda = 10
WHERE Num_Encomendas = 102 AND Cod_Produto_Encomenda = 2;

UPDATE Encomendas_Produtos
SET Data_Encomenda = '2024-11-17'
WHERE Num_Encomendas = 103 AND Cod_Produto_Encomenda = 3;

DELETE FROM Encomendas_Produtos
WHERE Num_Encomendas = 104 AND Cod_Produto_Encomenda = 4;

DROP TABLE IF EXISTS Componentes_Produtos;

CREATE TABLE IF NOT EXISTS Componentes_Produtos(
    Cod_Componentes INT,
    Cod_Produtos_EMPR INT,
    PRIMARY KEY(Cod_Componentes, Cod_Produtos_EMPR),
    CONSTRAINT FK_Produtos_Componentes FOREIGN KEY(Cod_Componentes)
    REFERENCES Componentes(Cod_Componentes),
    CONSTRAINT FK_Componentes_Produtos FOREIGN KEY(Cod_Produtos_EMPR)
    REFERENCES Produtos(Cod_Produtos)
);

ALTER TABLE Componentes_Produtos
ADD COLUMN Quantidade_Utilizada INT NOT NULL;

ALTER TABLE Componentes_Produtos
MODIFY COLUMN Cod_Produtos_EMPR INT NOT NULL;

ALTER TABLE Componentes_Produtos
CHANGE COLUMN Cod_Produtos_EMPR Cod_Produto_Empr INT NOT NULL;

ALTER TABLE Componentes_Produtos
DROP COLUMN Quantidade_Utilizada;

INSERT INTO Componentes_Produtos (Cod_Componentes, Cod_Produto_Empr)
VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105);

UPDATE Componentes_Produtos
SET Cod_Produto_Empr = 110
WHERE Cod_Componentes = 2 AND Cod_Produto_Empr = 102;

UPDATE Componentes_Produtos
SET Quantidade_Utilizada = 20
WHERE Cod_Componentes = 3 AND Cod_Produto_Empr = 103;

DELETE FROM Componentes_Produtos
WHERE Cod_Componentes = 4 AND Cod_Produto_Empr = 104;

DELETE FROM Componentes_Produtos
WHERE Cod_Produto_Empr = 105;


DROP TABLE IF EXISTS Componentes_RE;

CREATE TABLE IF NOT EXISTS Componentes_RE(
    Cod_Componentes INT,
    Cod_RE INT,
    PRIMARY KEY(Cod_Componentes, Cod_RE),
    CONSTRAINT FK_RE_Componentes FOREIGN KEY(Cod_Componentes)
    REFERENCES Componentes(Cod_Componentes),
    CONSTRAINT FK_Componentes_RE FOREIGN KEY(Cod_RE)
    REFERENCES Recursos_Especificos_RE(Cod_RE)
);

ALTER TABLE Componentes_RE
ADD COLUMN Data_Entrada DATE;

ALTER TABLE Componentes_RE
MODIFY COLUMN Cod_RE INT NOT NULL;

ALTER TABLE Componentes_RE
CHANGE COLUMN Cod_Componentes Cod_Componente INT NOT NULL;

ALTER TABLE Componentes_RE
DROP COLUMN Data_Entrada;

INSERT INTO Componentes_RE (Cod_Componente, Cod_RE)
VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105);

UPDATE Componentes_RE
SET Cod_RE = 110
WHERE Cod_Componente = 2 AND Cod_RE = 102;

UPDATE Componentes_RE
SET Cod_RE = 120
WHERE Cod_Componente = 3 AND Cod_RE = 103;

DELETE FROM Componentes_RE
WHERE Cod_Componente = 4 AND Cod_RE = 104;

DROP TABLE IF EXISTS Clientes_Telefone;
CREATE TABLE IF NOT EXISTS Clientes_Telefone(
    cod_Cliente INT,
    cod_Tel INT,
    PRIMARY KEY(cod_Cliente, cod_Tel),
    CONSTRAINT FK_Clientes_Telefone FOREIGN KEY(cod_Cliente)
    REFERENCES Clientes(cod_Cliente),
    CONSTRAINT FK_Telefone_Clientes FOREIGN KEY(cod_Tel)
    REFERENCES Telefone(cod_Tel)
);

ALTER TABLE Clientes_Telefone
ADD COLUMN Tipo_Telefone VARCHAR(20);

ALTER TABLE Clientes_Telefone
MODIFY COLUMN cod_Tel INT NOT NULL;

ALTER TABLE Clientes_Telefone
CHANGE COLUMN cod_Tel codigo_Telefone INT NOT NULL;

ALTER TABLE Clientes_Telefone
DROP COLUMN Tipo_Telefone;

INSERT INTO Clientes_Telefone (cod_Cliente, cod_Tel)
VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105);

UPDATE Clientes_Telefone
SET cod_Tel = 110
WHERE cod_Cliente = 2 AND cod_Tel = 102;

UPDATE Clientes_Telefone
SET cod_Tel = 115
WHERE cod_Cliente = 3 AND cod_Tel = 103;

DELETE FROM Clientes_Telefone
WHERE cod_Cliente = 4 AND cod_Tel = 104;


DROP TABLE IF EXISTS Empregados_Telefone;
CREATE TABLE IF NOT EXISTS Empregados_Telefone(
    Matricula_Empre INT,
    cod_Tel INT,
    PRIMARY KEY(Matricula_Empre, cod_Tel),
    CONSTRAINT FK_Empregados_Telefone FOREIGN KEY(Matricula_Empre)
    REFERENCES Empregados(Matricula_Empre),
    CONSTRAINT FK_Telefone_Empregados FOREIGN KEY(cod_Tel)
    REFERENCES Telefone(cod_Tel)
);

ALTER TABLE Empregados_Telefone
ADD COLUMN Tipo_Telefone VARCHAR(20);

ALTER TABLE Empregados_Telefone
MODIFY COLUMN cod_Tel INT NOT NULL;

ALTER TABLE Empregados_Telefone
CHANGE COLUMN cod_Tel codigo_Telefone INT NOT NULL;

ALTER TABLE Empregados_Telefone
DROP COLUMN Tipo_Telefone;

INSERT INTO Empregados_Telefone (Matricula_Empre, cod_Tel)
VALUES
(101, 201),
(102, 202),
(103, 203),
(104, 204),
(105, 205);

UPDATE Empregados_Telefone
SET cod_Tel = 210
WHERE Matricula_Empre = 102 AND cod_Tel = 202;

UPDATE Empregados_Telefone
SET cod_Tel = 215
WHERE Matricula_Empre = 103 AND cod_Tel = 203;

DELETE FROM Empregados_Telefone
WHERE Matricula_Empre = 104 AND cod_Tel = 204;


DROP TABLE IF EXISTS Maquinas_Produtos;
CREATE TABLE IF NOT EXISTS Maquinas_Produtos(
    Cod_Maquina INT,
    Cod_Produtos_EMPR INT,
    PRIMARY KEY(Cod_Maquina, Cod_Produtos_EMPR),
    CONSTRAINT FK_Produtos_Maquinas FOREIGN KEY(Cod_Maquina)
    REFERENCES Maquinas(Cod_Maquina),
    CONSTRAINT FK_Maquinas_Produtos FOREIGN KEY(Cod_Produtos_EMPR)
    REFERENCES Produtos(Cod_Produtos)
);
ALTER TABLE Maquinas_Produtos
ADD COLUMN Quantidade_Maquina INT NOT NULL;

ALTER TABLE Maquinas_Produtos
MODIFY COLUMN Cod_Produtos_EMPR INT NOT NULL;

ALTER TABLE Maquinas_Produtos
CHANGE COLUMN Cod_Produtos_EMPR Cod_Produto_EMPR INT NOT NULL;

ALTER TABLE Maquinas_Produtos
DROP COLUMN Quantidade_Maquina;

INSERT INTO Maquinas_Produtos (Cod_Maquina, Cod_Produtos_EMPR)
VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105);

UPDATE Maquinas_Produtos
SET Cod_Produto_EMPR = 106
WHERE Cod_Maquina = 2 AND Cod_Produto_EMPR = 102;

UPDATE Maquinas_Produtos
SET Cod_Produto_EMPR = 107
WHERE Cod_Maquina = 3 AND Cod_Produto_EMPR = 103;

DELETE FROM Maquinas_Produtos
WHERE Cod_Maquina = 4 AND Cod_Produto_EMPR = 104;
