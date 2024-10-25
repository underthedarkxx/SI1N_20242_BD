-- Active: 1728688414725@@127.0.0.1@3306@est_caso_ii
#CREATE SCHEMA Est_Caso_II;


use Est_Caso_II;

CREATE TABLE IF NOT EXISTS VOOS(
    voo_Codigo INT PRIMARY KEY,
    data_Hora_Origem DATETIME NOT NULL,
    data_Hora_Destino DATETIME NOT NULL,
    aeroporto_Origem VARCHAR(30) NOT NULL,
    aeroporto_Destino VARCHAR(30) NOT NULL,
    aeronave_FK VARCHAR(10),
    CONSTRAINT CE_Aeronaves FOREIGN KEY(aeronave_FK)
    REFERENCES Aeronaves(aeronave_Prefixo)
);
#id_pedido INT PRIMARY KEY,
    #id_cliente VARCHAR(100),
    #valor DECIMAL(10, 2),
    #CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)

CREATE TABLE IF NOT EXISTS Aeronaves(
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