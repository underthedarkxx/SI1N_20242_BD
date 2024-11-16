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

INSERT INTO Funcionarios (
    func_ID, func_Funcao, func_Data_Nasc, func_Tel, func_CPF
) VALUES
(100, 'Gerente', '1990-01-01 00:00:00', '27-99999-8888', '12345678901'),
(101, 'Analista', '1991-02-02 00:00:00', '27-99999-8887', '12345678902'),
(102, 'Supervisor', '1992-03-03 00:00:00', '27-99999-8886', '12345678903'),
(103, 'Diretor', '1993-04-04 00:00:00', '27-99999-8885', '12345678904'),
(104, 'Assistente', '1994-05-05 00:00:00', '27-99999-8884', '12345678905');
UPDATE Funcionarios
SET func_Tel = '27-99999-0000', func_Cargo = 'Coordenador'
WHERE func_ID = 101;
UPDATE Funcionarios
SET func_Data_Nasc = '1995-06-15 00:00:00'
WHERE func_CPF = '12345678903';
DELETE FROM Funcionarios
WHERE func_CPF = '12345678905';

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
INSERT INTO Aeronaves (aeronave_Prefixo, aeronave_Modelo, aeronave_anofabri, aeronave_Status, aeronave_capacidade) VALUES
('PR-A01', 'Boeing 737', '2015', 'Ativa', 50),
('PR-A02', 'Airbus A320', '2018', 'Ativa', 51),
('PR-A03', 'Embraer E190', '2020', 'Manutenção', 52),
('PR-A04', 'Cessna 172', '2012', 'Ativa', 53),
('PR-A05', 'Gulfstream G650', '2019', 'Inativa', 54);

UPDATE Aeronaves
SET aeronave_Status = 'Inativa'
WHERE aeronave_anofabri < '2015';

UPDATE Aeronaves
SET aeronave_Status = 'Ativa'
WHERE aeronave_Prefixo IN ('PR-A01', 'PR-A02', 'PR-A04');

DELETE FROM Aeronaves
WHERE aeronave_Prefixo = 'PR-A05';

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

INSERT INTO Aeroportos (aeroporto_Cod, aeroporto_Nome, aeroporto_Pais, aeroporto_Longitude, aeroporto_Latitude, aeroporto_Codigo_ICAO)
VALUES
('GRU', 'Aeroporto Internacional_1', 'Brasil', -46.4747, -23.4356, 'SBGR'),
('GIG', 'Aeroporto Internacional_2', 'Brasil', -43.2436, -22.8083, 'SBGL'),
('CGH', 'Aeroporto Internacional_3', 'Brasil', -46.6351, -23.6263, 'SBSP'),
('LHR', 'Aeroporto Internacional_4', 'Reino Unido', -0.4543, 51.4700, 'EGLL'),
('JFK', 'Aeroporto Internacional_5', 'Estados Unidos', -73.7781, 40.6413, 'KJFK');

UPDATE Aeroportos
SET aeroporto_Nome = 'Aeroporto Internacional_6'
WHERE aeroporto_Cod = 'GIG';

UPDATE Aeroportos
SET aeroporto_Pais = 'Brasil'
WHERE aeroporto_Cod IN ('LHR', 'JFK');

DELETE FROM Aeroportos
WHERE aeroporto_Cod = 'CGH';

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

INSERT INTO Reservas (FK_Voo, FK_Pass, reserva_Status)
VALUES
(201, '12345678901', 'ATIVA'),
(202, '23456789012', 'ATIVA'),
(203, '34567890123', 'CANCELADA'),
(204, '45678901234', 'PENDENTE'),
(205, '56789012345', 'EM ESPERA');

UPDATE Reservas
SET reserva_Status = 'PENDENTE'
WHERE FK_Voo = 201 AND FK_Pass = '12345678901';

UPDATE Reservas
SET reserva_Status = 'EM ESPERA'
WHERE FK_Voo = 202 AND FK_Pass = '12345678902';

DELETE FROM Reservas
WHERE FK_Voo = 205 AND FK_Pass = '12345678905';

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

INSERT INTO Passageiros (pass_CPF, pass_Nome, pass_Tel, pass_End, pass_Data_Nasc)
VALUES
('12345678901', 'João Silva', '2799998888', 'Rua A, 123, Bairro X', '1990-05-15'),
('23456789012', 'Maria Oliveira', '2798887777', 'Rua B, 456, Bairro Y', '1985-11-20'),
('34567890123', 'Carlos Santos', '2797776666', 'Rua C, 789, Bairro Z', '1992-08-25'),
('45678901234', 'Ana Souza', '2796665555', 'Rua D, 1011, Bairro W', '1995-12-30'),
('56789012345', 'Paulo Costa', '2795554444', 'Rua E, 1213, Bairro V', '1988-03-10');

UPDATE Passageiros
SET pass_Nome = 'João da Silva'
WHERE pass_CPF = '12345678901';

UPDATE Passageiros
SET pass_Tel = '2795554444'
WHERE pass_CPF = '45678901234';

DELETE FROM Reservas
WHERE FK_Voo = 205 AND FK_Pass = '12345678905';


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

INSERT INTO Voos (Voo_Codigo, Aeronaves_FK, data_Hora_Origem, data_Hora_Destino, aeroporto_Origem, aeroporto_Destino) 
VALUES
(201,  'PR-A01', '2024-11-20 10:00:00', '2024-11-20 12:00:00', 'Aeroporto A', 'Aeroporto B'),
(202,  'PR-A02', '2024-11-20 14:00:00', '2024-11-20 16:00:00', 'Aeroporto C', 'Aeroporto D'),
(203, 'PR-A03', '2024-11-21 09:00:00', '2024-11-21 11:00:00', 'Aeroporto E', 'Aeroporto F'),
(204, 'PR-A04', '2024-11-21 09:00:00', '2024-11-21 11:00:00', 'Aeroporto O', 'Aeroporto H'),
(205, 'PR-A05', '2024-11-21 09:00:00', '2024-11-21 11:00:00', 'Aeroporto T', 'Aeroporto K');

UPDATE Voos
SET aeroporto_Destino = 'Aeroporto Z'
WHERE Voo_Codigo = 204;

UPDATE Voos
SET aeroporto_Destino = 'Aeroporto Y'
WHERE Voo_Codigo = 203;

DELETE FROM Voos
WHERE Voo_Codigo = 205;

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

INSERT INTO Funcionarios (func_ID, func_Funcao, func_Nome, func_Data_Nasc, func_Tel)
VALUES
(1, 'Gerente', 'João Silva', '1985-06-15', '27999999999'),
(2, 'Analista', 'Maria Oliveira', '1990-03-22', '27988888888'),
(3, 'Desenvolvedor', 'Carlos Santos', '1992-07-30', '27977777777'),
(4, 'Designer', 'Ana Souza', '1995-11-11', '27966666666'),
(5, 'Suporte Técnico', 'Paulo Costa', '1988-01-25', '27955555555');

UPDATE Funcionarios
SET func_Funcao = 'Supervisor', func_Tel = '27944444444'
WHERE func_ID = 3;

UPDATE Funcionarios
SET func_Funcao = 'Analista', func_Tel = '27933333333'
WHERE func_ID = 4;

DELETE FROM Funcionarios
WHERE func_ID = 5;

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

INSERT INTO Operam_Voo (FK_func_ID, FK_Voo)
VALUES
(100, 201),
(101, 202),
(102, 203),
(103, 204),
(104, 205);

UPDATE Operam_Voo
SET Operam_Voo_Data = '2024-12-01'
WHERE FK_func_ID = 102 AND FK_Voo = 203;

UPDATE Operam_Voo
SET Operam_Voo_Data = '2024-12-10'
WHERE FK_func_ID = 103 AND FK_Voo = 204;

DELETE FROM Operam_Voo
WHERE FK_func_ID = 101 AND FK_Voo = 202;
