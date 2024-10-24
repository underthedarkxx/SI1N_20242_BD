CREATE SCHEMA EmpresaPassagemAereas;


use EmpresaPassagemAereas;

CREATE TABLE IF NOT EXISTS VOOS(
    voo_Codigo INT PRIMARY KEY,
    aeroporto_Origem VARCHAR(30) NOT NULL,
    aeroporto_Destino VARCHAR(30) NOT NULL,
    aeroporto_Prefixo VARCHAR(10) NOT NULL,
    CONSTRAINT FK_AERONAVES FOREIGN KEY(aeroporto_Prefixo)
    REFERENCES AERONAVES(aeronave_Prefixo),
    data_Hora_Origem DATETIME NOT NULL,
    data_Hora_Destino DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS AERONAVES(
    aeronave_Prefixo VARCHAR(10) PRIMARY KEY,
    aeronave_Modelo VARCHAR(45) NOT NULL,
    aeronave_anofabri VARCHAR(45) NOT NULL,
    aeronave_capacidade VARCHAR(45) NOT NULL,
    aeronave_Fabricante VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS AEROPORTOS(
    aeroporto_Cod VARCHAR(3) PRIMARY KEY,
    aeroporto_Nome VARCHAR(45) NOT NULL,
    
);