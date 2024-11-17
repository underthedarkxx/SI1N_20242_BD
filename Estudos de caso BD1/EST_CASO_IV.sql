-- Active: 1728688414725@@127.0.0.1@3306@est_caso_iv
#CREATE SCHEMA Est_Caso_IV;

Use Est_Caso_IV;

DROP TABLE IF EXISTS Alunos;

CREATE TABLE IF NOT EXISTS Alunos(
    Matricula INT PRIMARY KEY,
    Data_Nasc_Aluno DATE NOT NULL,
    Modalidades_Interesse VARCHAR(30) NOT NULL,
    CPF VARCHAR(11) NOT NULL,
    Cod_Pagamento VARCHAR(50),
    PT_Personalizado INT,
    CONSTRAINT FK_Pag_Alunos FOREIGN KEY (Cod_Pagamento)
    REFERENCES Pagamentos(Cod_Pagamento),
    CONSTRAINT FK_PT_Alunos FOREIGN KEY(PT_Personalizado)
    REFERENCES Plano_Treinamento(PT_Personalizado)
);

ALTER TABLE Alunos
ADD COLUMN Email_Aluno VARCHAR(100) NOT NULL;

ALTER TABLE Alunos
CHANGE COLUMN Modalidades_Interesse Modalidades_Aluno VARCHAR(50) NOT NULL;

ALTER TABLE Alunos
CHANGE COLUMN Modalidades_Aluno Modalidades_Interesse VARCHAR(30) NOT NULL;

ALTER TABLE Alunos
MODIFY COLUMN Data_Nasc_Aluno DATETIME NOT NULL;

ALTER TABLE Alunos
DROP COLUMN Metodo_Pagamento;

INSERT INTO Alunos (Matricula, Data_Nasc_Aluno, Modalidades_Interesse, CPF, PT_Personalizado, Cod_Pagamento, Email_Aluno)
VALUES
(1001, '1992-07-15', 'Futebol, Natação', '12345678901', 1, 'PGT001', 'joao.silva@example.com'),
(1002, '1995-03-22', 'Basquete, Corrida', '23456789012', 2, 'PGT002', 'maria.oliveira@example.com'),
(1003, '1988-11-09', 'Vôlei, Pilates', '34567890123', 3, 'PGT003', 'carlos.pereira@example.com'),
(1004, '2000-01-30', 'Futsal, Yoga', '45678901234', 4, 'PGT004', 'ana.santos@example.com'),
(1005, '1993-05-12', 'Boxe, Ciclismo', '56789012345', 5, 'PGT005', 'roberto.lima@example.com');

UPDATE Alunos
SET Modalidades_Interesse = 'Jiu-Jitsu, Ciclismo' 
WHERE Matricula = 1005; 

UPDATE Alunos
SET Email_Aluno = 'ana.santos.novo@example.com'
WHERE Matricula = 1004;

DELETE FROM Alunos
WHERE Matricula = 1003;

DROP TABLE IF EXISTS Pagamentos;
CREATE TABLE IF NOT EXISTS Pagamentos(
    Cod_Pagamento VARCHAR(50) PRIMARY KEY,
    Valor_Pagamento FLOAT NOT NULL,
    Data_Pagamento DATE NOT NULL,
    Status_Pagamento ENUM('PENDENTE','CONCLUÍDO','EM ESPERA')
);

ALTER TABLE Pagamentos
ADD COLUMN Metodo_Pagamento VARCHAR(30) NOT NULL;

ALTER TABLE Pagamentos
CHANGE COLUMN Status_Pagamento Status_Transacao ENUM('PENDENTE', 'CONCLUÍDO', 'EM ESPERA', 'CANCELADO') NOT NULL;

ALTER TABLE Pagamentos
CHANGE COLUMN  Status_Transacao Status_Pagamento ENUM('PENDENTE', 'CONCLUÍDO', 'EM ESPERA', 'CANCELADO') NOT NULL;

ALTER TABLE Pagamentos
DROP COLUMN Metodo_Pagamento;

ALTER TABLE Pagamentos
MODIFY COLUMN Valor_Pagamento FLOAT NULL;

INSERT INTO Pagamentos (Cod_Pagamento, Valor_Pagamento, Data_Pagamento, Status_Pagamento)
VALUES
('PGT001', 150.50, '2024-10-01', 'PENDENTE'),
('PGT002', 200.75, '2024-10-05', 'CONCLUÍDO'),
('PGT003', 300.00, '2024-10-10', 'EM ESPERA'),
('PGT004', 450.20, '2024-10-15', 'CANCELADO'),
('PGT005', 120.00, '2024-10-20', 'PENDENTE');

UPDATE Pagamentos
SET Status_Pagamento = 'CONCLUÍDO' 
WHERE Cod_Pagamento = 'PGT001'; 

UPDATE Pagamentos
SET Status_Pagamento = 'CANCELADO'
WHERE Cod_Pagamento = 'PGT002';

DELETE FROM Pagamentos
WHERE Cod_Pagamento = 'PGT005';

DROP TABLE IF EXISTS Plano_Treinamento;
CREATE TABLE IF NOT EXISTS Plano_Treinamento(
    PT_Personalizado INT PRIMARY KEY,
    Progresso_Aluno ENUM('Iniciante','Intermediario','Avancado') NOT NULL
);

ALTER TABLE Plano_Treinamento
ADD COLUMN Data_Inicio DATE NOT NULL;

ALTER TABLE Plano_Treinamento
CHANGE COLUMN Progresso_Aluno Nivel_Progresso ENUM('Iniciante', 'Intermediario', 'Avancado', 'Expert') NOT NULL;

ALTER TABLE Plano_Treinamento
CHANGE COLUMN Nivel_Progresso Progresso_Aluno ENUM('Iniciante', 'Intermediario', 'Avancado', 'Expert') NOT NULL;

ALTER TABLE Plano_Treinamento
DROP COLUMN Data_Inicio;

ALTER TABLE Plano_Treinamento
MODIFY COLUMN Progresso_Aluno ENUM('Iniciante', 'Intermediario', 'Avancado') NULL;

INSERT INTO Plano_Treinamento (PT_Personalizado, Progresso_Aluno)
VALUES
(1, 'Iniciante'),
(2, 'Intermediario'),
(3, 'Avancado'),
(4, 'Avancado'),
(5, 'Iniciante');

UPDATE Plano_Treinamento
SET Progresso_Aluno = 'Intermediario'
WHERE PT_Personalizado = 1;

UPDATE Plano_Treinamento
SET Progresso_Aluno = 'Avancado'
WHERE PT_Personalizado = 3;

DELETE FROM Plano_Treinamento
WHERE PT_Personalizado = 4;

DROP TABLE IF EXISTS Instrutores;
CREATE TABLE IF NOT EXISTS Instrutores(
    Cod_Instrutor VARCHAR(20) PRIMARY KEY,
    Alunos_Instrutor TEXT NOT NULL,
    PT_Personalizado INT,
    Dia_Horario_Aula DATETIME,
    CONSTRAINT FK_PT_Inst FOREIGN KEY (PT_Personalizado)
    REFERENCES Plano_Treinamento(PT_Personalizado),
    CONSTRAINT FK_Aulas_Inst FOREIGN KEY (Dia_Horario_Aula)
    REFERENCES Aulas(Dia_Horario_Aula)
);

ALTER TABLE Instrutores
ADD COLUMN Email_Instrutor VARCHAR(100) NOT NULL;

ALTER TABLE Instrutores
CHANGE COLUMN Alunos_Instrutor Lista_Alunos VARCHAR(155) NOT NULL;

ALTER TABLE Instrutores
CHANGE COLUMN Lista_Alunos Alunos_Instrutor VARCHAR(255) NOT NULL;

ALTER TABLE Instrutores
DROP COLUMN Email_Instrutor;

ALTER TABLE Instrutores
MODIFY COLUMN Email_Instrutor VARCHAR(150) NULL;

INSERT INTO Instrutores (Cod_Instrutor, Alunos_Instrutor, PT_Personalizado, Dia_Horario_Aula)
VALUES
('INST001', 'João Silva, Maria Oliveira', 1, '2024-11-01 08:00:00'),
('INST002', 'Carlos Santos, Ana Souza', 2, '2024-11-01 10:00:00'),
('INST003', 'Paulo Costa, Roberto Lima', 3, '2024-11-02 14:00:00'),
('INST004', 'João Silva, Paulo Costa', 4, '2024-11-02 16:00:00'),
('INST005', 'Maria Oliveira, Carlos Santos', 5, '2024-11-03 09:00:00');

UPDATE Instrutores
SET Alunos_Instrutor = 'João Silva, Maria Oliveira, Roberto Lima'
WHERE Cod_Instrutor = 'INST001';

UPDATE Instrutores
SET Dia_Horario_Aula = '2024-11-05 10:00:00'
WHERE Cod_Instrutor = 'INST002';

DELETE FROM Instrutores
WHERE Cod_Instrutor = 'INST004';

DROP TABLE IF EXISTS Aulas;
CREATE TABLE IF NOT EXISTS Aulas(
    Dia_Horario_Aula DATETIME PRIMARY KEY,
    Capacidade INT NOT NULL
);

ALTER TABLE Aulas
ADD COLUMN Local_Aula VARCHAR(100) NOT NULL;

ALTER TABLE Aulas
CHANGE COLUMN Capacidade Limite_Alunos SMALLINT NOT NULL;

ALTER TABLE Aulas
CHANGE COLUMN  Limite_Alunos Capacidade INT NOT NULL;

ALTER TABLE Aulas
DROP COLUMN Local_Aula;

ALTER TABLE Aulas
MODIFY COLUMN Capacidade VARCHAR(100);

ALTER TABLE Aulas
MODIFY COLUMN Capacidade INT NOT NULL;

INSERT INTO Aulas (Dia_Horario_Aula, Capacidade)
VALUES
('2024-11-01 08:00:00', 30),
('2024-11-01 10:00:00', 25),
('2024-11-02 14:00:00', 20),
('2024-11-02 16:00:00', 15),
('2024-11-03 09:00:00', 35);

UPDATE Aulas
SET Capacidade = 40
WHERE Dia_Horario_Aula = '2024-11-01 08:00:00';

UPDATE Aulas
SET Dia_Horario_Aula = '2024-11-04 14:00:00'
WHERE Dia_Horario_Aula = '2024-11-02 14:00:00';

DELETE FROM Aulas
WHERE Dia_Horario_Aula = '2024-11-03 09:00:00';

DROP TABLE IF EXISTS Modalidades;
CREATE TABLE IF NOT EXISTS Modalidades(
    Modalidade_Codigo VARCHAR(30) PRIMARY KEY,
    Alunos_Matriculados INT NOT NULL
);
ALTER TABLE Modalidades
ADD COLUMN Nome_Modalidade VARCHAR(100) NOT NULL;

ALTER TABLE Modalidades
CHANGE COLUMN Modalidade_Codigo Codigo_Modalidade VARCHAR(50);
ALTER TABLE Modalidades
CHANGE COLUMN Codigo_Modalidade Modalidade_Codigo VARCHAR(50);

ALTER TABLE Modalidades
DROP COLUMN Alunos_Matriculados;

ALTER TABLE Modalidades
MODIFY COLUMN Alunos_Matriculados INT NULL;

INSERT INTO Modalidades (Modalidade_Codigo, Nome_Modalidade, Alunos_Matriculados)
VALUES
('MOD001', 'Futebol', 30),
('MOD002', 'Vôlei', 25),
('MOD003', 'Natação', 20),
('MOD004', 'Ciclismo', 15),
('MOD005', 'Corrida', 35);

UPDATE Modalidades
SET Alunos_Matriculados = 40
WHERE Modalidade_Codigo = 'MOD001';

UPDATE Modalidades
SET Nome_Modalidade = 'Mountain Bike'
WHERE Modalidade_Codigo = 'MOD004';

DELETE FROM Modalidades
WHERE Modalidade_Codigo = 'MOD005';

DROP TABLE IF EXISTS Enderecos;

CREATE TABLE IF NOT EXISTS Enderecos(
    ID_Enderecos INT PRIMARY KEY,
    Num_End INT NOT NULL,
    Tipo_End VARCHAR(20) NOT NULL,
    Logradouro_End VARCHAR(50) NOT NULL,
    Complemento VARCHAR(100),
    CEP_End INT NOT NULL,
    Bairro_End VARCHAR(50) NOT NULL,
    Estado_End VARCHAR(30) NOT NULL,
    Cidade_End VARCHAR(50) NOT NULL,
    FK_Matricula INT,
    CONSTRAINT FK_End_Alunos FOREIGN KEY (FK_Matricula)
    REFERENCES Alunos(Matricula)
    );
    

ALTER TABLE Enderecos
ADD COLUMN Pais_End VARCHAR(50);

ALTER TABLE Enderecos
CHANGE COLUMN Num_End Numero_End INT NOT NULL;

ALTER TABLE Enderecos
CHANGE COLUMN Numero_End Num_End INT NOT NULL;

ALTER TABLE Enderecos
DROP COLUMN Complemento;

ALTER TABLE Enderecos
MODIFY COLUMN CEP_End VARCHAR(10) NOT NULL;

INSERT INTO Enderecos (ID_Enderecos, Num_End, Tipo_End, Logradouro_End, CEP_End, Bairro_End, Estado_End, Cidade_End, Matricula, Pais_End)
VALUES
(1, 123, 'Residencial', 'Rua A', '12345-678', 'Centro', 'São Paulo', 'São Paulo', 1001, 'Brasil'),
(2, 456, 'Comercial', 'Avenida B', '23456-789', 'Jardim Paulista', 'Rio de Janeiro', 'Rio de Janeiro', 1002, 'Brasil'),
(3, 789, 'Residencial', 'Rua C', '34567-890', 'Vila Nova', 'Minas Gerais', 'Belo Horizonte', 1003, 'Brasil'),
(4, 101, 'Comercial', 'Avenida D', '45678-901', 'Praia Grande', 'Espírito Santo', 'Vitória', 1004, 'Brasil'),
(5, 202, 'Residencial', 'Rua E', '56789-012', 'Jardim das Flores', 'Bahia', 'Salvador', 1005, 'Brasil');

UPDATE Enderecos
SET Tipo_End = 'Comercial'
WHERE FK_Matricula = 1003;

UPDATE Enderecos
SET Cidade_End = 'São Paulo'
WHERE FK_Matricula = 1004;

DELETE FROM Enderecos
WHERE FK_Matricula = 1005;


DROP TABLE IF EXISTS Alunos_Modalidade;

CREATE TABLE IF NOT EXISTS Alunos_Modalidade(
    Matricula INT,
    FK_Modalidade_Codigo VARCHAR(30),
    PRIMARY KEY(Matricula, FK_Modalidade_Codigo),
    CONSTRAINT FK_Alunos_Modalidades FOREIGN KEY(Matricula)
    REFERENCES Alunos(Matricula),
    CONSTRAINT FK_Modalidades_Alunos FOREIGN KEY(FK_Modalidade_Codigo)
    REFERENCES Modalidades(Modalidade_Codigo)
);
ALTER TABLE Alunos_Modalidade
ADD COLUMN Data_Inscricao DATE NOT NULL;

ALTER TABLE Alunos_Modalidade
CHANGE COLUMN FK_Modalidade_Codigo Modalidade_Codigo VARCHAR(30);

ALTER TABLE Alunos_Modalidade
CHANGE COLUMN Modalidade_Codigo FK_Modalidade_Codigo VARCHAR(30);

ALTER TABLE Alunos_Modalidade
MODIFY COLUMN Data_Inscricao DATETIME NOT NULL;

ALTER TABLE Alunos_Modalidade
DROP COLUMN Data_Inscricao;

INSERT INTO Alunos_Modalidade (Matricula, FK_Modalidade_Codigo, Data_Inscricao)
VALUES
(1001, 'MOD001', '2024-11-01'),
(1002, 'MOD002', '2024-11-05'),
(1003, 'MOD003', '2024-11-10'),
(1004, 'MOD004', '2024-11-12'),
(1005, 'MOD005', '2024-11-15');

UPDATE Alunos_Modalidade
SET Data_Inscricao = '2024-11-10'
WHERE Matricula = 1002;

UPDATE Alunos_Modalidade
SET FK_Modalidade_Codigo = 'MOD003'
WHERE Matricula = 1004;

DELETE FROM Alunos_Modalidade
WHERE Matricula = 1005 AND FK_Modalidade_Codigo = 'MOD005';

DROP TABLE IF EXISTS Aluno_Aula;
CREATE TABLE IF NOT EXISTS Aluno_Aula(
    Matricula INT,
    Dia_Horario_Aula DATETIME,
    PRIMARY KEY(Matricula, Dia_Horario_Aula),
    CONSTRAINT FK_Aluno_Aula FOREIGN KEY(Matricula)
    REFERENCES Alunos(Matricula),
    CONSTRAINT FK_Aula_Aluno FOREIGN KEY(Dia_Horario_Aula)
    REFERENCES Aulas(Dia_Horario_Aula)
);
ALTER TABLE Aluno_Aula
ADD COLUMN Repeticoes DECIMAL(5.20);

ALTER TABLE Aluno_Aula
CHANGE COLUMN Matricula FK_Matricula INT;

ALTER TABLE Aluno_Aula
CHANGE COLUMN FK_Matricula Matricula INT;

ALTER TABLE Aluno_Aula
MODIFY COLUMN Repeticoes DECIMAL(3.30);

ALTER TABLE Aluno_Aula
DROP COLUMN Repeticoes;

INSERT INTO Aluno_Aula (Matricula, Dia_Horario_Aula)
VALUES
(1001, '2024-11-01 08:00:00'),
(1002, '2024-11-01 10:00:00'),
(1003, '2024-11-02 14:00:00'),
(1004, '2024-11-02 16:00:00'),
(1005, '2024-11-03 09:00:00');

UPDATE Aluno_Aula
SET Dia_Horario_Aula = '2024-11-02 10:00:00'
WHERE Matricula = 1002;

UPDATE Aluno_Aula
SET Matricula = 1006
WHERE Matricula = 1005 AND Dia_Horario_Aula = '2024-11-03 09:00:00';

DELETE FROM Aluno_Aula
WHERE Matricula = 1003 AND Dia_Horario_Aula = '2024-11-02 14:00:00';
