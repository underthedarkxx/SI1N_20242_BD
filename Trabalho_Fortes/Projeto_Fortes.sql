#CREATE DATABASE FortesEngenhariaDB;
USE FortesEngenhariaDB;

CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(100) NOT NULL,
    email_usuario VARCHAR(100) UNIQUE NOT NULL,
    senha_usuario VARCHAR(255) NOT NULL,
    papel_usuario ENUM('colaborador', 'donatario', 'empresa_parceira') NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    cargo_funcionario VARCHAR(50),
    email_funcionario VARCHAR(100) UNIQUE,
    telefone_funcionario VARCHAR(13),
    setor_funcionario VARCHAR(50),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE EmpresasParceiras (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nome_empresa VARCHAR(100) NOT NULL,
    email_empresa VARCHAR(100) UNIQUE,
    telefone_empresa VARCHAR(13),
    área_foco_empresa VARCHAR(100),
    mensagem_empresa TEXT
);

CREATE TABLE Projetos (
    id_projeto INT AUTO_INCREMENT PRIMARY KEY,
    nome_projeto VARCHAR(100) NOT NULL,
    descricao_projeto TEXT,
    data_inicio_projeto DATE NOT NULL,
    data_fim_projeto DATE,
    status_projeto ENUM('Planejado', 'Em andamento', 'Concluído', 'Cancelado'),
    id_responsavel INT,
    FOREIGN KEY (id_responsavel) REFERENCES Funcionarios(id_funcionario)
);

CREATE TABLE Metas (
    id_meta INT AUTO_INCREMENT PRIMARY KEY,
    descricao_meta TEXT,
    status_meta ENUM('Pendente', 'Concluído') NOT NULL,
    id_projeto INT,
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto)
);

CREATE TABLE Recursos (
    id_recurso INT AUTO_INCREMENT PRIMARY KEY,
    tipo_recurso VARCHAR(50) NOT NULL,
    quantidade_recurso INT,
    valor_recurso DECIMAL(10,2),
    status_recurso ENUM('Aprovado', 'Pendente', 'Rejeitado'),
    razao_solicitacao TEXT
);

CREATE TABLE Avaliacoes (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    nome_instituicao VARCHAR(100),
    area_foco VARCHAR(100),
    comentario TEXT,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Suporte (
    id_suporte INT AUTO_INCREMENT PRIMARY KEY,
    tipo_atendimento ENUM('Automático', 'Bate-papo') NOT NULL,
    mensagem_usuario TEXT,
    resposta_suporte TEXT,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Mensagens (
    id_mensagem INT AUTO_INCREMENT PRIMARY KEY,
    remetente VARCHAR(100),
    destinatario VARCHAR(100),
    conteudo_mensagem TEXT,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Progresso (
    id_progresso INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT,
    pessoas_atingidas INT,
    progresso_tempo INT,
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto)
);

INSERT INTO Usuarios (nome_usuario, email_usuario, senha_usuario, papel_usuario)
VALUES 
('João Silva', 'joao@fortes.com', 'senha123', 'colaborador'),
('Maria Souza', 'maria@parceira.com', 'senha456', 'empresa_parceira');

INSERT INTO Funcionarios (nome_funcionario, cargo_funcionario, email_funcionario, telefone_funcionario, setor_funcionario, id_usuario)
VALUES 
('Carlos Andrade', 'Engenheiro Civil', 'carlos@fortes.com', '11987654321', 'Engenharia', 1);

INSERT INTO Projetos (nome_projeto, descricao_projeto, data_inicio_projeto, data_fim_projeto, status_projeto, id_responsavel)
VALUES 
('Construção de Escola', 'Projeto para construir uma nova escola comunitária', '2023-01-15', '2023-12-31', 'Em andamento', 1);

INSERT INTO Recursos (tipo_recurso, quantidade_recurso, valor_recurso, status_recurso, razao_solicitacao)
VALUES 
('Dinheiro', 100000, 100000.00, 'Aprovado', 'Evento de Caridade');

INSERT INTO Suporte (tipo_atendimento, mensagem_usuario, resposta_suporte, id_usuario)
VALUES 
('Bate-papo', 'Quais são os horários de atendimento?', 'De 8h às 18h, de segunda a sexta-feira.', 1);


