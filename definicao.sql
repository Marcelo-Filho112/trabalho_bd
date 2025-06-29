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
    PRIMARY KEY (PacienteID, Telefone),
    FOREIGN KEY (PacienteID) REFERENCES Paciente(PacienteID) ON DELETE CASCADE
);

CREATE TABLE EmailPaciente (
    PacienteID INT,
    Email VARCHAR(255),
    PRIMARY KEY (PacienteID, Email),
    FOREIGN KEY (PacienteID) REFERENCES Paciente(PacienteID) ON DELETE CASCADE
);

CREATE TABLE Medico (
    MedicoID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    CRM VARCHAR(50)
);

CREATE TABLE Especialidade (
    MedicoID INT,
    Especialidade VARCHAR(100),
    PRIMARY KEY (MedicoID, Especialidade),
    FOREIGN KEY (MedicoID) REFERENCES Medico(MedicoID) ON DELETE CASCADE
);

CREATE TABLE Consulta (
    ConsultaID SERIAL PRIMARY KEY,
    PacienteID INT,
    DataConsulta DATE,
    Sintomas TEXT,
    Diagnostico TEXT,
    FOREIGN KEY (PacienteID) REFERENCES Paciente(PacienteID) ON DELETE CASCADE
);

CREATE TABLE Tratamento (
    TratamentoID SERIAL PRIMARY KEY,
    Nome TEXT
);

CREATE TABLE ConsultaTratamento (
    ConsultaID INT,
    TratamentoID INT,
    PRIMARY KEY (ConsultaID, TratamentoID),
    FOREIGN KEY (ConsultaID) REFERENCES Consulta(ConsultaID) ON DELETE CASCADE,
    FOREIGN KEY (TratamentoID) REFERENCES Tratamento(TratamentoID) ON DELETE CASCADE
);

CREATE TABLE ConsultaMedico (
    ConsultaID INT,
    MedicoID INT,
    PRIMARY KEY (ConsultaID, MedicoID),
    FOREIGN KEY (ConsultaID) REFERENCES Consulta(ConsultaID) ON DELETE CASCADE,
    FOREIGN KEY (MedicoID) REFERENCES Medico(MedicoID) ON DELETE CASCADE
);

CREATE TABLE Laboratorio (
    LaboratorioID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco TEXT
);

CREATE TABLE Exame (
    ExameID SERIAL PRIMARY KEY,
    ConsultaID INT,
    DataExame DATE,
    Resultado TEXT,
    LaboratorioID INT,
    FOREIGN KEY (ConsultaID) REFERENCES Consulta(ConsultaID) ON DELETE CASCADE,
    FOREIGN KEY (LaboratorioID) REFERENCES Laboratorio(LaboratorioID) ON DELETE CASCADE
);


CREATE TABLE ProcedimentoExame (
    ExameID INT,
    Procedimento VARCHAR(100),
    PRIMARY KEY (ExameID, Procedimento),
    FOREIGN KEY (ExameID) REFERENCES Exame(ExameID) ON DELETE CASCADE
);

CREATE TABLE Receita (
    ReceitaID SERIAL PRIMARY KEY,
    ConsultaID INT,
    DataReceita DATE,
    Observacoes TEXT,
    FOREIGN KEY (ConsultaID) REFERENCES Consulta(ConsultaID) ON DELETE CASCADE
);

CREATE TABLE Medicamento (
    MedicamentoID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Dosagem VARCHAR(100),
    Frequencia VARCHAR(100),
    Duracao VARCHAR(100)
);

CREATE TABLE ReceitaMedicamento (
    ReceitaID INT,
    MedicamentoID INT,
    PRIMARY KEY (ReceitaID, MedicamentoID),
    FOREIGN KEY (ReceitaID) REFERENCES Receita(ReceitaID) ON DELETE CASCADE,
    FOREIGN KEY (MedicamentoID) REFERENCES Medicamento(MedicamentoID) ON DELETE CASCADE
);

CREATE TABLE Pagamento (
    PagamentoID SERIAL PRIMARY KEY,
    ConsultaID INT,
    DataPagamento DATE,
    ValorPago DECIMAL(10, 2),
    FOREIGN KEY (ConsultaID) REFERENCES Consulta(ConsultaID) ON DELETE CASCADE
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
    PRIMARY KEY (PagamentoID, ConvenioID),
    FOREIGN KEY (PagamentoID) REFERENCES Pagamento(PagamentoID) ON DELETE CASCADE,
    FOREIGN KEY (ConvenioID) REFERENCES Convenio(ConvenioID) ON DELETE CASCADE
);

CREATE TABLE PacienteConvenio (
    PacienteID INT,
    ConvenioID INT,
    PRIMARY KEY (PacienteID, ConvenioID),
    FOREIGN KEY (PacienteID) REFERENCES Paciente(PacienteID) ON DELETE CASCADE,
    FOREIGN KEY (ConvenioID) REFERENCES Convenio(ConvenioID) ON DELETE CASCADE
);