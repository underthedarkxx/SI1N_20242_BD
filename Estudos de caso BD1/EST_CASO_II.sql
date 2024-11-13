-- Active: 1728688414725@@127.0.0.1@3306@est_caso_ii
#CREATE SCHEMA Est_Caso_II;


use Est_Caso_II;

CREATE TABLE IF NOT EXISTS Voos(
    Voo_Codigo INT PRIMARY KEY,
    data_Hora_Origem DATETIME NOT NULL,
    data_Hora_Destino DATETIME NOT NULL,
    aeroporto_Origem VARCHAR(50) NOT NULL,
    aeroporto_Destino VARCHAR(50) NOT NULL,
    aeronave_Prefixo VARCHAR(5),
    CONSTRAINT Aeronave_FK FOREIGN KEY(Aeronave_Prefixo)
    REFERENCES Aeronaves(aeronave_Prefixo)
);

INSERT into Voos(Voo_Codigo, data_Hora_Origem, data_Hora_Destino, aeroporto_Origem, aeroporto_Destino, aeronave_Prefixo)
VALUES
(100, ),
(),
(),
(),
();

CREATE TABLE IF NOT EXISTS Aeronaves(
    aeronave_Prefixo VARCHAR(10) PRIMARY KEY,
    aeronave_Modelo VARCHAR(45) NOT NULL,
    aeronave_anofabri VARCHAR(45) NOT NULL,
    aeronave_capacidade VARCHAR(45) NOT NULL,
    aeronave_Fabricante VARCHAR(45) NOT NULL
);
ALTER TABLE Aeronaves
CHANGE COLUMN aeronave_anofabri aeronave_fabriano VARCHAR(50);
CREATE TABLE IF NOT EXISTS Aeroportos(
    aeroporto_Cod VARCHAR(3) PRIMARY KEY,
    aeroporto_Nome VARCHAR(45) NOT NULL,
    aeroporto_Local VARCHAR(50) NOT NULL,
    aeroporto_Pais VARCHAR(50) NOT NULL,
    aeroporto_Longitude FLOAT NOT NULL,
    aeroporto_Latitude FLOAT NOT NULL
);
ALTER TABLE Aeroportos
MODIFY COLUMN aeroporto_Cod VARCHAR(5);
CREATE TABLE IF NOT EXISTS Reservas(
    FK_Voo INT,
    FK_Pass VARCHAR(11),
    CONSTRAINT voo_fk FOREIGN KEY (FK_Voo)
    REFERENCES Voos(Voo_Codigo),
    CONSTRAINT passageros_fk FOREIGN KEY(FK_Pass)
    REFERENCES Passageiros(pass_CPF)
);

ALTER TABLE Reservas
ADD COLUMN Assento VARCHAR(2);

ALTER TABLE Reservas
DROP COLUMN Assento;

CREATE TABLE IF NOT EXISTS Passageiros(
    pass_CPF VARCHAR(11) PRIMARY KEY,
    pass_Nome VARCHAR(45) NOT NULL,
    pass_Tel VARCHAR(13) NOT NULL,
    pass_End VARCHAR(100) NOT NULL,
    pass_Email VARCHAR(45) NOT NULL
);
CREATE TABLE IF NOT EXISTS Passageiros_II(
    pass_CPF VARCHAR(11) PRIMARY KEY,
    pass_Nome VARCHAR(45) NOT NULL,
    pass_Tel VARCHAR(13) NOT NULL,
    pass_End VARCHAR(100) NOT NULL,
    pass_Email VARCHAR(45) NOT NULL
);
DROP TABLE Passageiros_II;
CREATE TABLE IF NOT EXISTS Funcionarios(
    func_ID INT PRIMARY KEY,
    func_Funcao VARCHAR(30) NOT NULL,
    func_Nome VARCHAR(45) NOT NULL,
    func_Data_Nasc DATE NOT NULL,
    func_Tel VARCHAR(13) NOT NULL
);
CREATE TABLE IF NOT EXISTS Operam_Voo(
    Func_FK INT,
    Voos_FK INT,
    CONSTRAINT funcionarios_FK FOREIGN KEY(Func_FK)
    REFERENCES Funcionarios(func_ID),
    CONSTRAINT voos_FK FOREIGN KEY(Voos_FK)
    REFERENCES Voos(Voo_Codigo)
);