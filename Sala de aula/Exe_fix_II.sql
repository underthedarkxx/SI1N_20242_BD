#CREATE SCHEMA Exe_fix;
use Exe_fix;

CREATE TABLE IF NOT EXISTS Usuarios(
    ID_Usuario INT PRIMARY KEY,
    nome_Usuario VARCHAR(100) NOT NULL,
    Sobrenome VARCHAR(100) NOT NULL,
    Email VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Postagens(
    ID_Post INT PRIMARY KEY,
    Texto TEXT,
    Imagem BLOB,
    data_Hora DATETIME NOT NULL,
    CE_Usuario INT,
    CONSTRAINT FK_Usuarios FOREIGN KEY (CE_Usuario)
    REFERENCES Usuarios(ID_Usuario)
);

CREATE TABLE IF NOT EXISTS Comentarios(
    ID_Comentario INT PRIMARY KEY,
    Texto TEXT,
    data_Hora DATE TIME,
    CE_Usuarios INT,
    CE_Posts INT,
    CONSTRAINT FK_Usuario FOREIGN KEY (CE_Usuarios)
    REFERENCES Usuarios(ID_Usuario),
    CONSTRAINT FK_Post FOREIGN KEY (CE_Posts)
    REFERENCES Postagens(ID_Post)
);

CREATE TABLE IF NOT EXISTS Grupos(
    ID_Grupo INT PRIMARY KEY,
    nome_Grupo VARCHAR(100),
    Descricao TEXT
);

CREATE TABLE IF NOT EXISTS usuarios_Grupos(
    FK_Usuarios INT,
    FK_Grupos INT,
    CONSTRAINT fk_usuario FOREIGN KEY (FK_Usuarios)
    REFERENCES Usuarios(ID_Usuario),
    CONSTRAINT fk_grupos FOREIGN KEY (FK_Grupos)
    REFERENCES Grupos(ID_Grupo)
);

CREATE TABLE IF NOT EXISTS Seguidores(
    seguidores INT PRIMARY KEY,
    nome_Seguidor VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS seguidores_Usuarios(
    FK_usuario INT,
    FK_Seguidor INT,
    CONSTRAINT usuario_fk FOREIGN KEY (FK_usuario)
    REFERENCES Usuario (ID_Usuario),
    CONSTRAINT seguidor_fk FOREIGN KEY (FK_Seguidor)
    REFERENCES Seguidores(seguidores)
);