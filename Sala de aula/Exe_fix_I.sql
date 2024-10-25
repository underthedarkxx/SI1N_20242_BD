-- Active: 1728688414725@@127.0.0.1@3306@banquinho
#CREATE SCHEMA Exe_fix

use Exe_fix;

CREATE TABLE IF NOT EXISTS Eventos(
    ID_Evento INT PRIMARY KEY,
    nome_Evento VARCHAR(100) NOT NULL,
    data_Evento DATE,
    entidade_Evento VARCHAR(100) NOT NULL,
    local_Evento INT
);

CREATE TABLE IF NOT Exists Locais(
    id_Local INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    log_Local_ VARCHAR(100),
    numlog_Local INT,
    bairro_Local VARCHAR(100),
    cidade VARCHAR(100),
    UF VARCHAR(2)
)

CREATE TABLE IF NOT EXISTS Atividades(
    id_Atividade INT PRIMARY KEY,
    nome_Atv VARCHAR(100) NOT NULL,
    data_Atv DATE NOT NULL,
    hora_Atv TIME NOT NULL,
    evento_Atv INT 
);

CREATE TABLE IF NOT EXISTS Participantes(
    num_Inscricao INT PRIMARY KEY,
    #CPF VARCHAR(11),
    nome VARCHAR(100)NOT NULL,
    data_Nasc DATE NOT NULL,
    empresa VARCHAR(100)
);
#perguntar ao gustavo como essa tabela tem 2 chaves primarias

CREATE TABLE IF NOT EXISTS Participantes_Eventos(
    PE_Inscricao INT,
    ID_Evento INT,
    CONSTRAINT FK_Participantes FOREIGN KEY(PE_Inscricao)
    REFERENCES Participantes (num_Inscricao),
    CONSTRAINT FK_Eventos FOREIGN KEY(ID_Evento)
    REFERENCES Eventos (ID_Evento)
);

CREATE TABLE IF NOT EXISTS Participantes_Atividades(
    PA_Participantes INT,
    PA_Atividades INT,
    CONSTRAINT FK_Participante FOREIGN KEY(PA_Participantes)
    REFERENCES Participantes (num_Inscricao),
    CONSTRAINT FK_Atividades FOREIGN KEY(PA_Atividades)
    REFERENCES Atividades(id_Atividade)
);