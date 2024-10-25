-- Active: 1728688414725@@127.0.0.1@3306@exe_fix
#CREATE SCHEMA Exe_fix

use Exe_fix;

CREATE TABLE IF NOT EXISTS Eventos(
    ID_Evento INT PRIMARY KEY,
    nome_Evento VARCHAR(100) NOT NULL,
    data_Evento DATE,
    entidade_Evento VARCHAR(100) NOT NULL,
    local_Evento INT,
    CONSTRAINT FK_LCL_EVT FOREIGN KEY (local_Evento)
    REFERENCES Locais(id_Local)
);

CREATE TABLE IF NOT Exists Locais(
    id_Local INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    log_Local_ VARCHAR(100),
    numlog_Local INT,
    bairro_Local VARCHAR(100),
    cidade_Local VARCHAR(100),
    UF_Local VARCHAR(2),
    CPF_Local VARCHAR(14) NOT NULL,
    Capacidade_Local INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Atividades(
    id_Atividade INT PRIMARY KEY,
    nome_Atv VARCHAR(100) NOT NULL,
    data_Atv DATE NOT NULL,
    hora_Atv TIME NOT NULL,
    evento_Atv INT NOT NULL,
    CONSTRAINT FK_LCL_EVT FOREIGN KEY (evento_Atv)
    REFERENCES Eventos(ID_Evento)
);

CREATE TABLE IF NOT EXISTS Participantes(
    num_Inscricao INT ,
    CPF VARCHAR(14),
    PRIMARY KEY (num_Inscricao,CPF),
    #Chave primaria composta.
    nome VARCHAR(100)NOT NULL,
    data_Nasc DATE NOT NULL,
    empresa VARCHAR(100)
);
ALTER TABLE Participantes ADD Email VARCHAR(30);
#Adicionando o email na tabela com o tipo varchar.
ALTER TABLE Participantes DROP COLUMN Email;
#Retirando da tabela a coluna adicionada.
CREATE TABLE IF NOT EXISTS Participantes_Eventos(
    PE_Inscricao INT,
    ID_Evento INT,
    PE_CPF VARCHAR(14),
    PRIMARY KEY(PE_Inscricao, ID_Evento, PE_CPF),
    CONSTRAINT FK_Participantes FOREIGN KEY(PE_Inscricao, PE_CPF)
    REFERENCES Participantes (num_Inscricao),
    CONSTRAINT FK_Eventos FOREIGN KEY(ID_Evento)
    REFERENCES Eventos (ID_Evento)
);

CREATE TABLE IF NOT EXISTS Participantes_Atividades(
    PA_Participantes INT,
    PA_Atividades INT,
    PA_CPF VARCHAR(14),
    PRIMARY KEY(PA_Participantes,PA_Atividades, PA_CPF),
    CONSTRAINT FK_Participante FOREIGN KEY(PA_Participantes, PA_CPF)
    REFERENCES Participantes (num_Inscricao),
    CONSTRAINT FK_Atividades FOREIGN KEY(PA_Atividades)
    REFERENCES Atividades(id_Atividade)
);