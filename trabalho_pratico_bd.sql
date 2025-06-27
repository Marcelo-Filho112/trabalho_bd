-- CRIAÇÃO DAS TABELAS (DDL)
CREATE TABLE Paciente (
    PacienteID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    DataNascimento DATE,
    Endereco TEXT
);

CREATE TABLE TelefonePaciente (
    PacienteID INT,
    Telefone VARCHAR(20),
    PRIMARY KEY (PacienteID, Telefone)
);

CREATE TABLE EmailPaciente (
    PacienteID INT,
    Email VARCHAR(255),
    PRIMARY KEY (PacienteID, Email)
);

CREATE TABLE Medico (
    MedicoID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    CRM VARCHAR(50)
);

CREATE TABLE Especialidade (
    MedicoID INT,
    Especialidade VARCHAR(100),
    PRIMARY KEY (MedicoID, Especialidade)
);

CREATE TABLE Consulta (
    ConsultaID SERIAL PRIMARY KEY,
    PacienteID INT,
    DataConsulta DATE,
    Sintomas TEXT,
    Diagnostico TEXT,
    Tratamento TEXT,
);

-- CREATE TABLE Tratamento (
--     TratamentoID SERIAL PRIMARY KEY,
--     Nome TEXT,
-- )

CREATE TABLE ConsultaTratamento (
    ConsultaID INT,
    TratamentoID INT,
    PRIMARY KEY (ConsultaID, TratamentoID)
)

CREATE TABLE ConsultaMedico (
    ConsultaID INT,
    MedicoID INT,
    PRIMARY KEY (ConsultaID, MedicoID)
);

CREATE TABLE Exame (
    ExameID SERIAL PRIMARY KEY,
    ConsultaID INT,
    DataExame DATE,
    Resultado TEXT,
    LaboratorioID INT
);

CREATE TABLE ProcedimentoExame (
    ExameID INT,
    Procedimento VARCHAR(100),
    PRIMARY KEY (ExameID, Procedimento)
);

CREATE TABLE Laboratorio (
    LaboratorioID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco TEXT
);

CREATE TABLE Receita (
    ReceitaID SERIAL PRIMARY KEY,
    ConsultaID INT,
    DataReceita DATE,
    Observacoes TEXT
);

CREATE TABLE Medicamento (
    ReceitaID INT,
    Nome VARCHAR(255),
    Dosagem VARCHAR(100),
    Frequencia VARCHAR(100),
    Duracao VARCHAR(100),
    PRIMARY KEY (ReceitaID, Nome)
);

-- CREATE TABLE ReceitaMedicamento (
--     ReceitaID INT,
--     MedicamentoID INT,
--     PRIMARY KEY (ReceitaID, MedicamentoID)
-- )

CREATE TABLE Pagamento (
    PagamentoID SERIAL PRIMARY KEY,
    ConsultaID INT,
    DataPagamento DATE,
    ValorPago DECIMAL(10, 2)
);

CREATE TABLE FormaPagamento (
    PagamentoID INT,
    Tipo VARCHAR(50),
    Detalhes TEXT,
    PRIMARY KEY (PagamentoID, Tipo)
);

CREATE TABLE Convenio (
    ConvenioID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    PercentualCobertura DECIMAL(5, 2)
);

CREATE TABLE PagamentoConvenio (
    PagamentoID INT,
    ConvenioID INT,
    PRIMARY KEY (PagamentoID, ConvenioID)
);

CREATE TABLE PacienteConvenio (
    PacienteID INT,
    ConvenioID INT,
    PRIMARY KEY (PacienteID, ConvenioID)
);


-- INSERTS DE EXEMPLO (DML)
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco)
VALUES (1, 'João Silva', '1990-05-10', 'Rua A, 123, Centro, Campo Grande-MS, 79000-000');

INSERT INTO TelefonePaciente VALUES (1, '67999990000');
INSERT INTO TelefonePaciente VALUES (1, '67988887777');
INSERT INTO EmailPaciente VALUES (1, 'joao@email.com');

INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (1, 'Dra. Ana Costa', '123456-MS');
INSERT INTO Especialidade VALUES (1, 'Clínica Geral');
INSERT INTO Especialidade VALUES (1, 'Geriatria');

INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico, Tratamento)
VALUES (1, 1, '2024-03-15', 'Febre, dor de cabeça', 'Virose', 'Repouso, hidratação');

INSERT INTO ConsultaMedico VALUES (1, 1);

INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes)
VALUES (1, 1, '2024-03-15', 'Tomar com alimentos');

INSERT INTO Medicamento VALUES 
(1, 'Paracetamol 500mg', '1 comprimido', '3x ao dia', '5 dias');

INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco)
VALUES (1, 'LabVida', 'Av. Saúde, 500, Campo Grande-MS');

INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID)
VALUES (1, 1, '2024-03-16', 'Exame de sangue normal', 1);

INSERT INTO ProcedimentoExame VALUES (1, 'Hemograma completo');

INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago)
VALUES (1, 1, '2024-03-15', 150.00);

INSERT INTO FormaPagamento VALUES 
(1, 'Cartão', 'MasterCard final 1234');

INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura)
VALUES (1, 'Unimed', 70.00);

INSERT INTO PacienteConvenio VALUES (1, 1);
INSERT INTO PagamentoConvenio VALUES (1, 1);


-- CONSULTA SQL - Faturamento por especialidade por mês (2024-2025)
SELECT 
    e.Especialidade,
    DATE_TRUNC('month', c.DataConsulta) AS Mes,
    SUM(p.ValorPago) AS FaturamentoTotal
FROM 
    Consulta c
JOIN 
    ConsultaMedico cm ON c.ConsultaID = cm.ConsultaID
JOIN 
    Medico m ON cm.MedicoID = m.MedicoID
JOIN 
    Especialidade e ON m.MedicoID = e.MedicoID
JOIN 
    Pagamento p ON c.ConsultaID = p.ConsultaID
WHERE 
    EXTRACT(YEAR FROM c.DataConsulta) IN (2024, 2025)
GROUP BY 
    e.Especialidade, DATE_TRUNC('month', c.DataConsulta)
ORDER BY 
    Mes, e.Especialidade;
