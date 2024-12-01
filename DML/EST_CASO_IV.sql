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
