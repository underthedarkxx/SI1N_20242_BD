-- Active: 1728688414725@@127.0.0.1@3306@est_caso_iii
#CREATE SCHEMA Est_Caso_III;
Use Est_Caso_III;
CREATE TABLE IF NOT EXISTS Clientes (
    cod_Cliente INT PRIMARY KEY,
    CNPJ_Clientes VARCHAR(18) NOT NULL,
    Razao_Social VARCHAR(30) NOT NULL,
    Data_de_Cadastramento DATE NOT NULL,
    P_Contato_Clientes VARCHAR(100),
    Num_Encomenda INT,
    Id_Enderecos INT,
    CONSTRAINT FK_Enc_Cli FOREIGN KEY(Num_Encomenda)
    REFERENCES Encomendas(Num_Encomendas),
    CONSTRAINT FK_End_Cli FOREIGN KEY(Id_Enderecos)
    REFERENCES Enderecos(ID_Enderecos)
);

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
ADD COLUMN data_Random DATE;

ALTER TABLE Encomendas
DROP COLUMN data_Random;

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
    Matricula_Emp INT,
    cod_Clientes INT,
    CONSTRAINT FK_End_Cli FOREIGN KEY (cod_Clientes)
    REFERENCES Clientes(cod_Cliente),
    CONSTRAINT FK_End_Emp FOREIGN KEY (Matricula_Emp)
    REFERENCES Empregados(Matricula_Empre)
    );

CREATE TABLE IF NOT EXISTS Empregados(
    Matricula_Empre INT PRIMARY KEY,
    Nome_Empre VARCHAR(50) NOT NULL,
    Cargo_Empre VARCHAR(30) NOT NULL,
    Salario_Empre FLOAT NOT NULL,
    Data_Adimissao_Empre DATE,
    Qualificacoes_Empre VARCHAR(30),
    ID_Endereco INT,
    CONSTRAINT FK_Empregados FOREIGN KEY(ID_Endereco)
    REFERENCES Enderecos(ID_Enderecos)
);

ALTER TABLE Empregados
MODIFY COLUMN Cargo_Empre VARCHAR(50) NOT NULL;

CREATE TABLE IF NOT EXISTS Telefone(
    cod_Tel INT PRIMARY KEY,
    Tel_Fixo VARCHAR(10),
    Tel_Cel VARCHAR(14),
    Matricula_Emp INT,
    CNPJ_Fornecedores_Tel VARCHAR(18),
    CONSTRAINT FK_Tel_Emp FOREIGN KEY(Matricula_Emp)
    REFERENCES Empregados(Matricula_Empre),
    CONSTRAINT FK_Tel_Forn FOREIGN KEY(CNPJ_Fornecedores_Tel)
    REFERENCES Empresas(CNPJ_Empresas)
);

CREATE TABLE IF NOT EXISTS Fornecedores(
    CNPJ_Fornecedores VARCHAR(18) PRIMARY KEY,
    P_Contato_Fornecedores VARCHAR(50) NOT NULL
);

ALTER TABLE Fornecedores
CHANGE COLUMN CNPJ_Fornecedores Fornecedores_CNPJ VARCHAR(18);

CREATE TABLE IF NOT EXISTS Empresas(
    CNPJ_Empresas VARCHAR(18) PRIMARY KEY,
    Razao_Social VARCHAR(50),
    P_Contato_Empresas VARCHAR(50),
    CNPJ_Fornecedores_Emp VARCHAR(18),
    CONSTRAINT FK_Emp_Forne FOREIGN KEY(CNPJ_Fornecedores_Emp)
    REFERENCES Fornecedores(CNPJ_Fornecedores)
);

CREATE TABLE IF NOT EXISTS Produtos(
    Cod_Produtos INT PRIMARY KEY,
    Nome_Produtos VARCHAR(50) NOT NULL,
    Cor_Produtos VARCHAR (20) NOT NULL,
    Dimensoes_Produtos FLOAT NOT NULL,
    Peso_Produtos FLOAT NOT NULL,
    Preco_Produtos FLOAT NOT NULL,
    Tempo_Fabri_Produtos TIME NOT NULL,
    #Perguntar ao professor sobre o desenho.
    Desenho_Produtos INT,
    Cod_RS_Prod INT,
    CONSTRAINT FK_RS_Prod FOREIGN KEY (Cod_RS_Prod)
    REFERENCES Registro_Suprimentos(Cod_RS)
);

CREATE TABLE IF NOT EXISTS Registro_Suprimentos(
    Cod_RS INT PRIMARY KEY,
    Quantidade_RS INT NOT NULL,
    Data_Necessidade_RS DATE
);

CREATE TABLE IF NOT EXISTS Componentes(
    Cod_Componentes INT PRIMARY KEY,
    Nome_Componentes VARCHAR(100) NOT NULL,
    Tipo_Componentes VARCHAR(100) NOT NULL,
    QTD_Estoque_Componentes INT NOT NULL,
    Preco_Unit_Componentes FLOAT NOT NULL,
    #Unidade_Componente O que seria?
    Unidade_Componente INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Maquinas(
    Cod_Maquina INT PRIMARY KEY,
    Temp_Vida_Maquina DATE NOT NULL,
    Data_Compra_Maquina DATE NOT NULL,
    Data_Fim_Garan_Maquina DATE NOT NULL,
    Cod_RM_Maq INT,
    CONSTRAINT FK_RM_Maq FOREIGN KEY (Cod_RM_Maq)
    REFERENCES Registro_Manutencao(Cod_RM)
);

CREATE TABLE IF NOT EXISTS Recursos_Especificos_RE(
    Cod_RE INT PRIMARY KEY,
    Quant_Necessaria INT NOT NULL,
    Unidade_RE VARCHAR(35) NOT NULL,
    Tempo_Uso TIME,
    Horas_Trabalho_RE TIME NOT NULL,
    Horas_Mao_Obra TIME NOT NULL
);

CREATE TABLE IF NOT EXISTS Registro_Manutencao(
    Cod_RM INT PRIMARY KEY,
    Data_RM DATE NOT NULL,
    Descricao_RM TEXT NOT NULL,
    Cod_Maq_RM INT,
    CONSTRAINT FK_Maq_RM FOREIGN KEY(Cod_Maq_RM)
    REFERENCES Maquinas(Cod_Maquina)
);

CREATE TABLE IF NOT EXISTS Registro_Suprimentos(
    Cod_RS INT PRIMARY KEY,
    Quantidade_RS INT NOT NULL,
    Data_Necessidade_RS DATE NOT NULL
);
DROP TABLE Registro_Suprimentos;
CREATE TABLE IF NOT EXISTS Empregados_Produtos(
    Matricula_Empre_EMPR INT,
    Cod_Produtos_EMPR INT,
    PRIMARY KEY(Matricula_Empre_EMPR, Cod_Produtos),
    CONSTRAINT FK_Empregados_Produtos FOREIGN KEY(Matricula_Empre_EMPR)
    REFERENCES Empregados(Matricula_Empre),
    CONSTRAINT FK_Produtos_Empregados FOREIGN KEY(Cod_Produtos_EMPR)
    REFERENCES Produtos(Cod_Produtos)
);

CREATE TABLE IF NOT EXISTS Clientes_Empresas(
    cod_Cliente INT,
    CNPJ_Empresas VARCHAR(18),
    PRIMARY KEY(cod_Cliente, CNPJ_Empresas),
    CONSTRAINT FK_Clientes_Empresas FOREIGN KEY(cod_Cliente)
    REFERENCES Clientes(cod_Cliente),
    CONSTRAINT FK_Empresas_Clientes FOREIGN KEY(CNPJ_Empresas)
    REFERENCES Empresas(CNPJ_Empresas)
);

CREATE TABLE IF NOT EXISTS Componentes_Fornecedores(
    Cod_Componentes INT,
    CNPJ_Fornecedores VARCHAR(18),
    PRIMARY KEY(Cod_Componentes, CNPJ_Fornecedores),
    CONSTRAINT FK_Componentes_Fornecedores FOREIGN KEY(Cod_Componentes)
    REFERENCES Componentes(Cod_Componentes),
    CONSTRAINT FK_Fornecedores_Componentes FOREIGN KEY(CNPJ_Fornecedores)
    REFERENCES Fornecedores(CNPJ_Fornecedores)
);

CREATE TABLE IF NOT EXISTS Enderecos_Empresas(
    ID_Enderecos INT,
    CNPJ_Empresas VARCHAR(18),
    PRIMARY KEY(ID_Enderecos, CNPJ_Empresas),
    CONSTRAINT FK_Enderecos_Empresas FOREIGN KEY(ID_Enderecos)
    REFERENCES Enderecos(ID_Enderecos),
    CONSTRAINT FK_Empresas_Enderecos FOREIGN KEY(CNPJ_Empresas)
    REFERENCES Empresas(CNPJ_Empresas)
);

CREATE TABLE IF NOT EXISTS Endereço_Fornecedores(
    ID_Enderecos INT,
    CNPJ_Fornecedores VARCHAR(18),
    PRIMARY KEY(ID_Enderecos, CNPJ_Fornecedores),
    CONSTRAINT FK_Endereço_Fornecedores FOREIGN KEY(CNPJ_Fornecedores)
    REFERENCES Fornecedores(CNPJ_Fornecedores),
    CONSTRAINT FK_Fornecedores_Enderecos FOREIGN KEY(ID_Enderecos)
    REFERENCES Enderecos(ID_Enderecos)
);

CREATE TABLE IF NOT EXISTS Encomendas_Produtos(
    Num_Encomendas INT,
    Cod_Produtos_EMPR INT,
    PRIMARY KEY(Num_Encomendas, Cod_Produtos_EMPR),
    CONSTRAINT FK_Encomendas_Produtos FOREIGN KEY(Num_Encomendas)
    REFERENCES Encomendas(Num_Encomendas),
    CONSTRAINT FK_Produtos_Encomendas FOREIGN KEY(Cod_Produtos_EMPR)
    REFERENCES Produtos(Cod_Produtos)
);

CREATE TABLE IF NOT EXISTS Componentes_Produtos(
    Cod_Componentes INT,
    Cod_Produtos_EMPR INT,
    PRIMARY KEY(Cod_Componentes, Cod_Produtos_EMPR),
    CONSTRAINT FK_Produtos_Componentes FOREIGN KEY(Cod_Componentes)
    REFERENCES Componentes(Cod_Componentes),
    CONSTRAINT FK_Componentes_Produtos FOREIGN KEY(Cod_Produtos_EMPR)
    REFERENCES Produtos(Cod_Produtos)
);

CREATE TABLE IF NOT EXISTS Componentes_RE(
    Cod_Componentes INT,
    Cod_RE INT,
    PRIMARY KEY(Cod_Componentes, Cod_RE),
    CONSTRAINT FK_RE_Componentes FOREIGN KEY(Cod_Componentes)
    REFERENCES Componentes(Cod_Componentes),
    CONSTRAINT FK_Componentes_RE FOREIGN KEY(Cod_RE)
    REFERENCES Recursos_Especificos_RE(Cod_RE)
);

CREATE TABLE IF NOT EXISTS Clientes_Telefone(
    cod_Cliente INT,
    cod_Tel INT,
    PRIMARY KEY(cod_Cliente, cod_Tel),
    CONSTRAINT FK_Clientes_Telefone FOREIGN KEY(cod_Cliente)
    REFERENCES Clientes(cod_Cliente),
    CONSTRAINT FK_Telefone_Clientes FOREIGN KEY(cod_Tel)
    REFERENCES Telefone(cod_Tel)
);

CREATE TABLE IF NOT EXISTS Empregados_Telefone(
    Matricula_Empre INT,
    cod_Tel INT,
    PRIMARY KEY(Matricula_Empre, cod_Tel),
    CONSTRAINT FK_Empregados_Telefone FOREIGN KEY(Matricula_Empre)
    REFERENCES Empregados(Matricula_Empre),
    CONSTRAINT FK_Telefone_Empregados FOREIGN KEY(cod_Tel)
    REFERENCES Telefone(cod_Tel)
);

CREATE TABLE IF NOT EXISTS Maquinas_Produtos(
    Cod_Maquina INT,
    Cod_Produtos_EMPR INT,
    PRIMARY KEY(Cod_Maquina, Cod_Produtos_EMPR),
    CONSTRAINT FK_Produtos_Maquinas FOREIGN KEY(Cod_Maquina)
    REFERENCES Maquinas(Cod_Maquina),
    CONSTRAINT FK_Maquinas_Produtos FOREIGN KEY(Cod_Produtos_EMPR)
    REFERENCES Produtos(Cod_Produtos)
);