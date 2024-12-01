-- Active: 1728688414725@@127.0.0.1@3306@est_caso_ii
#CREATE SCHEMA Est_Caso_II;


use Est_Caso_II;
DROP TABLE IF EXISTS Funcionarios;
CREATE TABLE IF NOT EXISTS Funcionarios (
    func_ID INT PRIMARY KEY,
    func_Funcao VARCHAR(30) NOT NULL,
    func_Nome VARCHAR(45) NOT NULL,
    func_Data_Nasc DATE NOT NULL,
    func_Tel VARCHAR(13) NOT NULL
);
ALTER TABLE Funcionarios
ADD COLUMN func_CPF VARCHAR(11) NOT NULL;
ALTER TABLE Funcionarios
CHANGE COLUMN func_Funcao func_Func VARCHAR(25) NOT NULL;
ALTER TABLE Funcionarios
CHANGE COLUMN func_Func func_Funcao VARCHAR(30) NOT NULL;
ALTER TABLE Funcionarios
DROP COLUMN func_Nome; 
ALTER TABLE Funcionarios
MODIFY COLUMN func_Data_Nasc DATETIME;


DROP TABLE IF EXISTS Aeronaves;
CREATE TABLE IF NOT EXISTS Aeronaves(
    aeronave_Prefixo VARCHAR(10) PRIMARY KEY,
    aeronave_Modelo VARCHAR(45) NOT NULL,
    aeronave_anofabri VARCHAR(45) NOT NULL,
    aeronave_capacidade VARCHAR(45) NOT NULL
);
ALTER TABLE Aeronaves
ADD COLUMN aeronave_Status VARCHAR(20) DEFAULT 'Ativa';
ALTER TABLE Aeronaves
DROP COLUMN aeronave_capacidade;
ALTER TABLE Aeronaves
MODIFY COLUMN aeronave_Modelo VARCHAR(100) NOT NULL;

ALTER TABLE Aeronaves
CHANGE COLUMN aeronave_anofabri aeronave_fabri_ano VARCHAR(50);
ALTER TABLE Aeronaves
CHANGE COLUMN aeronave_fabri_ano aeronave_anofabri  VARCHAR(45);

DROP TABLE IF EXISTS Aeroportos;
CREATE TABLE IF NOT EXISTS Aeroportos(
    aeroporto_Cod VARCHAR(3) PRIMARY KEY,
    aeroporto_Nome VARCHAR(45) NOT NULL,
    aeroporto_Local VARCHAR(50) NOT NULL,
    aeroporto_Pais VARCHAR(50) NOT NULL,
    aeroporto_Longitude FLOAT NOT NULL,
    aeroporto_Latitude FLOAT NOT NULL
);
ALTER TABLE Aeroportos
ADD COLUMN aeroporto_Codigo_ICAO VARCHAR(4) NOT NULL;

ALTER TABLE Aeroportos
CHANGE COLUMN aeroporto_Pais aeroporto_Nacao VARCHAR(100) NOT NULL;
ALTER TABLE Aeroportos
CHANGE COLUMN aeroporto_Nacao aeroporto_Pais VARCHAR(50) NOT NULL;

ALTER TABLE Aeroportos
DROP COLUMN aeroporto_Local;

ALTER TABLE Aeroportos
MODIFY COLUMN aeroporto_Longitude DECIMAL(9,6) NOT NULL;


DROP TABLE IF EXISTS Reservas;

CREATE TABLE IF NOT EXISTS Reservas (
    FK_Voo INT,
    FK_Pass VARCHAR(11),
    PRIMARY KEY (FK_Voo, FK_Pass),
    CONSTRAINT voo_fk FOREIGN KEY (FK_Voo)
    REFERENCES Voos(Voo_Codigo),
    CONSTRAINT passageros_fk FOREIGN KEY (FK_Pass)
    REFERENCES Passageiros(pass_CPF)
);

ALTER TABLE Reservas
ADD COLUMN reserva_Status ENUM('CANCELADA', 'EFETIVADA', 'ATIVA', 'NÃO COMPARECEU');

ALTER TABLE Reservas
CHANGE COLUMN reserva_Status reserva_Status_Reserva ENUM('CANCELADA', 'EFETIVADA', 'ATIVA', 'NÃO COMPARECEU');
ALTER TABLE Reservas
CHANGE COLUMN  reserva_Status_Reserva reserva_Status ENUM('CANCELADA', 'EFETIVADA', 'ATIVA', 'NÃO COMPARECEU');
ALTER TABLE Reservas
DROP COLUMN reserva_Status;
ALTER TABLE Reservas
MODIFY COLUMN reserva_Status ENUM('CANCELADA', 'PENDENTE', 'EM ESPERA', 'ATIVA');


DROP TABLE IF EXISTS Passageiros;
CREATE TABLE IF NOT EXISTS Passageiros(
    pass_CPF VARCHAR(11) PRIMARY KEY,
    pass_Nome VARCHAR(45) NOT NULL,
    pass_Tel VARCHAR(13) NOT NULL,
    pass_End VARCHAR(100) NOT NULL,
    pass_Email VARCHAR(45) NOT NULL
);

ALTER TABLE Passageiros
ADD COLUMN pass_Data_Nasc DATE;

ALTER TABLE Passageiros
CHANGE COLUMN pass_Tel pass_Telefone VARCHAR(13) NOT NULL;

ALTER TABLE Passageiros
CHANGE COLUMN pass_Telefone pass_Tel VARCHAR(13) NOT NULL;

ALTER TABLE Passageiros
DROP COLUMN pass_Email;

ALTER TABLE Passageiros
MODIFY COLUMN pass_Nome VARCHAR(100) NOT NULL;


DROP TABLE IF EXISTS Voos;
CREATE TABLE IF NOT EXISTS Voos (
    Voo_Codigo INT PRIMARY KEY,
    data_Hora_Origem DATETIME NOT NULL,
    data_Hora_Destino DATETIME NOT NULL,
    aeroporto_Origem VARCHAR(50) NOT NULL,
    aeroporto_Destino VARCHAR(50) NOT NULL,
    Aeronaves_FK VARCHAR(10),
    CONSTRAINT FK_Aeronaves FOREIGN KEY (Aeronaves_FK)
    REFERENCES Aeronaves(aeronave_Prefixo)
);
ALTER TABLE Voos
ADD COLUMN Voo_Status ENUM('CONFIRMADO', 'CANCELADO', 'PENDENTE');

ALTER TABLE Voos
CHANGE COLUMN aeroporto_Origem aeroporto_Origem_Nome VARCHAR(50) NOT NULL;

ALTER TABLE Voos
CHANGE COLUMN aeroporto_Origem_Nome aeroporto_Origem  VARCHAR(100) NOT NULL;

ALTER TABLE Voos
DROP COLUMN Voo_Status;

ALTER TABLE Voos
MODIFY COLUMN data_Hora_Origem DATETIME NOT NULL;

DROP TABLE Funcionarios;
CREATE TABLE IF NOT EXISTS Funcionarios(
    func_ID INT PRIMARY KEY,
    func_Funcao VARCHAR(30) NOT NULL,
    func_Nome VARCHAR(45) NOT NULL,
    func_Data_Nasc DATE NOT NULL,
    func_Tel VARCHAR(13) NOT NULL
);

ALTER TABLE Funcionarios
ADD COLUMN func_Email VARCHAR(50);

ALTER TABLE Funcionarios
CHANGE COLUMN func_Funcao func_Cargo VARCHAR(35);

ALTER TABLE Funcionarios
CHANGE COLUMN func_Cargo func_Funcao VARCHAR(40);

ALTER TABLE Funcionarios
DROP COLUMN func_Tel;

ALTER TABLE Funcionarios
MODIFY COLUMN func_Data_Nasc DATETIME NOT NULL;

DROP TABLE IF EXISTS Operam_Voo;
CREATE TABLE IF NOT EXISTS Operam_Voo (
    FK_func_ID INT,
    FK_Voo INT,
    CONSTRAINT FK_Funcionarios FOREIGN KEY (FK_func_ID)
    REFERENCES Funcionarios(func_ID),
    CONSTRAINT FK_Voos FOREIGN KEY (FK_Voo)
    REFERENCES Voos(Voo_Codigo)
);

ALTER TABLE Operam_Voo
ADD COLUMN Operam_Voo_Data DATE NOT NULL;

ALTER TABLE Operam_Voo
CHANGE COLUMN FK_func_ID Funcionario_ID INT NOT NULL;

ALTER TABLE Operam_Voo
CHANGE COLUMN Funcionario_ID FK_func_ID INT NOT NULL;

ALTER TABLE Operam_Voo
DROP COLUMN Operam_Voo_Data;

ALTER TABLE Operam_Voo
MODIFY COLUMN FK_Voo INT NOT NULL;

