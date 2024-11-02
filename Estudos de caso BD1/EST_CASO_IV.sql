-- Active: 1728688414725@@127.0.0.1@3306@est_caso_iv
#CREATE SCHEMA Est_Caso_IV;

Use Est_Caso_IV;

CREATE TABLE IF NOT EXISTS Alunos(
    Matricula INT PRIMARY KEY,
    Data_Nasc_Aluno DATE NOT NULL,
    Modalidades_Interesse VARCHAR(30) NOT NULL,
    CPF VARCHAR(11) NOT NULL,
    Cod_Pagamento VARCHAR(35) NOT NULL,
    PT_Personalizado INT,
    CONSTRAINT FK_Pag_Alunos FOREIGN KEY (Cod_Pagamento)
    REFERENCES Pagamentos(Cod_Pagamento),
    CONSTRAINT FK_PT_Alunos FOREIGN KEY(PT_Personalizado)
    REFERENCES Plano_Treinamento(PT_Personalizado)
);

CREATE TABLE IF NOT EXISTS Pagamentos(
    Cod_Pagamento VARCHAR(50) PRIMARY KEY,
    Valor_Pagamento FLOAT NOT NULL,
    Data_Pagamento DATE NOT NULL,
    Status_Pagamento ENUM('PENDENTE','CONCLUÍDO','EM ESPERA')
);

ALTER TABLE Pagamentos
ADD COLUMN Descri_Pagamento TEXT;


ALTER TABLE Pagamentos
DROP COLUMN Descri_Pagamento;

CREATE TABLE IF NOT EXISTS Plano_Treinamento(
    PT_Personalizado INT PRIMARY KEY,
    Progresso_Aluno ENUM('Iniciante','Intermediario','Avancado') NOT NULL
);

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

CREATE TABLE IF NOT EXISTS Aulas(
    Dia_Horario_Aula DATETIME PRIMARY KEY,
    Capacidade INT NOT NULL
);

ALTER TABLE Aulas
MODIFY COLUMN Capacidade VARCHAR(100);

ALTER TABLE Aulas
MODIFY COLUMN Capacidade INT NOT NULL;

CREATE TABLE IF NOT EXISTS Modalidades(
    Modalidade_Codigo VARCHAR(30) PRIMARY KEY,
    Alunos_Matriculados INT NOT NULL
);

ALTER TABLE Modalidades
CHANGE COLUMN Modalidade_Codigo Codigo_Modalidade VARCHAR(50);

ALTER TABLE Modalidades
CHANGE COLUMN Codigo_Modalidade Modalidade_Codigo VARCHAR(50);
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
    Matricula INT,
    CONSTRAINT FK_Alunos_End FOREIGN KEY(Matricula)
    REFERENCES Alunos(Matricula)
    );

CREATE TABLE IF NOT EXISTS Alunos_Modalidade(
    Matricula INT,
    Modalidade_Codigo VARCHAR(30),
    PRIMARY KEY(Matricula, Modalidade_Codigo),
    CONSTRAINT FK_Alunos_Modalidades FOREIGN KEY(Matricula)
    REFERENCES Alunos(Matricula),
    CONSTRAINT FK_Modalidades_Alunos FOREIGN KEY(Modalidade_Codigo)
    REFERENCES Modalidades(Modalidade_Codigo)
);

DROP TABLE Modalidades;

CREATE TABLE IF NOT EXISTS Aluno_Aula(
    Matricula INT,
    Dia_Horario_Aula DATETIME,
    PRIMARY KEY(Matricula, Dia_Horario_Aula),
    CONSTRAINT FK_Aluno_Aula FOREIGN KEY(Matricula)
    REFERENCES Alunos(Matricula),
    CONSTRAINT FK_Aula_Aluno FOREIGN KEY(Dia_Horario_Aula)
    REFERENCES AulaS(Dia_Horario_Aula)
);