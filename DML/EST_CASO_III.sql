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

ALTER TABLE Produtos
DROP COLUMN Categoria_Produtos;


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
CHANGE COLUMN Cod_Produto_EMPR Cod_Produtos_EMPR INT NOT NULL;

ALTER TABLE Maquinas_Produtos
DROP COLUMN Quantidade_Maquina;
