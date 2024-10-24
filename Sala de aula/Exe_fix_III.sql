-- Active: 1728688414725@@127.0.0.1@3306@exe_fix_iii
#CREATE SCHEMA Exe_fix_III;

USE Exe_fix;

CREATE TABLE IF NOT EXISTS Sessoes(
    ID_Sessao INT PRIMARY KEY,
    FK_Filme INT,
    FK_Sala INT,
    CONSTRAINT Filme_FK FOREIGN KEY (FK_Filme)
    REFERENCES Filmes(ID_Filme),
    CONSTRAINT Sala_FK FOREIGN KEY(FK_Sala)
    REFERENCES Salas(ID_Sala)
);

CREATE TABLE IF NOT EXISTS Filmes(
    ID_Filme INT PRIMARY KEY,
    Nome_Filme VARCHAR(100) NOT NULL,
    Distribuidor_Filme VARCHAR(100) NOT NULL,
    Tempo_Filme INT NOT NULL,
    Diretor_Filme VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Salas(
    ID_Sala INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Capacidade INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Ingressos(
    ID_Ingresso INT PRIMARY KEY,
    Data_Ing DATE NOT NULL,
    Hora_Ing TIME NOT NULL,
    CE_Sessoes INT,
    CE_Espectadores INT,
    CONSTRAINT FK_Sessoes FOREIGN KEY (CE_Sessoes)
    REFERENCES Sessoes(ID_Sessao),
    CONSTRAINT FK_Espectadores FOREIGN KEY (CE_Espectadores)
    REFERENCES Espectadores(ID_Espec)
);

CREATE TABLE IF NOT EXISTS Espectadores(
    ID_Espec INT PRIMARY KEY,
    Tel_Espec VARCHAR(20),
    Email_Espec VARCHAR(50),
    Nome_Espec VARCHAR(100),
    Data_Nasc DATE
);