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


-- INSERTS DE EXEMPLO (DML)
-- Pacientes:
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (1, 'João Silva', '1990-05-10', 'Rua A, 123, Centro, Campo Grande-MS, 79000-000');
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (2, 'Maria Oliveira', '1990-08-23', 'Av. Brasil, 456, Rio de Janeiro - RJ');
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (3, 'Carlos Souza', '1978-02-14', 'Rua XV de Novembro, 789, Curitiba - PR');
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (4, 'Ana Paula Costa', '2001-11-03', 'Rua das Flores, 101, Belo Horizonte - MG');
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (5, 'Lucas Pereira', '1995-06-30', 'Av. Independência, 2020, Porto Alegre - RS');
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (6, 'Fernanda Lima', '1982-09-18', 'Rua João Pessoa, 333, Salvador - BA');
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (7, 'Rafael Torres', '2000-01-27', 'Travessa das Palmeiras, 45, Recife - PE');
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (8, 'Juliana Mendes', '1993-12-05', 'Rua das Laranjeiras, 67, Florianópolis - SC');
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (10, 'Gabriel Rocha', '1987-07-09', 'Av. Central, 909, Goiânia - GO');
INSERT INTO Paciente (PacienteID, Nome, DataNascimento, Endereco) VALUES (9, 'Patrícia Andrade', '1975-03-21', 'Rua Dom Pedro II, 12, Manaus - AM');

-- Telefones do Paciente:
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (1, '67999990000');
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (2, '67988887777');
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (3, '(41) 98765-4321');
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (4, '(31) 99654-3210');
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (5, '(51) 91234-0000');
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (6, '(71) 93456-7890');
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (7, '(81) 94567-1234');
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (8, '(48) 98765-1111');
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (9, '(62) 95678-4321');
INSERT INTO TelefonePaciente (PacienteID, Telefone) VALUES (10, '(92) 90000-0000');

-- Emails do Paciente:
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (1, 'joao@email.com');
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (2, 'maria.oliveira@yahoo.com');
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (3, 'carlos.souza@outlook.com');
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (4, 'ana.paula@gmail.com');
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (5, 'lucas.pereira@hotmail.com');
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (6, 'fernanda.lima@uol.com.br');
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (7, 'rafael.torres@gmail.com');
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (8, 'juliana.mendes@globo.com');
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (9, 'gabriel.rocha@yahoo.com.br');
INSERT INTO EmailPaciente (PacienteID, Email) VALUES (10, 'patricia.andrade@gmail.com');

-- Médicos:
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (1, 'Dra. Tatiane Barros', 'CRM-GO-019911');
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (2, 'Dr. João Ribeiro', 'CRM-SP-001122');
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (3, 'Dra. Ana Paula Martins', 'CRM-RJ-003344');
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (4, 'Dr. Marcelo Souza', 'CRM-MG-005566');
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (5, 'Dra. Camila Andrade', 'CRM-BA-007788');
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (6, 'Dr. Bruno Lima', 'CRM-RS-009900');
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (7, 'Dra. Fernanda Costa', 'CRM-PR-011223');
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (8, 'Dr. Rafael Oliveira', 'CRM-PE-013355');
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (9, 'Dra. Juliana Rocha', 'CRM-CE-015577');
INSERT INTO Medico (MedicoID, Nome, CRM) VALUES (10, 'Dr. Guilherme Pires', 'CRM-DF-017799');

-- Especialidades:
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (1, 'Clínico Geral');
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (2, 'Ortopedia');
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (3, 'Pneumologia');
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (4, 'Gastroenterologia');
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (5, 'Dermatologia');
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (6, 'Neurologia');
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (7, 'Psiquiatria');
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (8, 'Reumatologia');
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (9, 'Hematologia');
INSERT INTO Especialidade (MedicoID, Especialidade) VALUES (10, 'Otorrinolaringologia');


-- Consultas:
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (1, 1, '2024-01-15', 'Febre e dor de cabeça', 'Virose');
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (2, 2, '2024-02-20', 'Dores nas costas', 'Hérnia de disco');
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (3, 3, '2024-03-10', 'Tosse e falta de ar', 'Bronquite');
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (4, 4, '2024-04-05', 'Dor abdominal', 'Gastrite');
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (5, 5, '2024-04-22', 'Manchas na pele', 'Dermatite');
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (6, 6, '2024-05-01', 'Dores de cabeça frequentes', 'Enxaqueca');
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (7, 7, '2024-05-10', 'Dificuldade para dormir', 'Insônia');
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (8, 8, '2024-06-02', 'Dor no joelho', 'Inflamação articular');
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (9, 9, '2024-06-15', 'Cansaço excessivo', 'Anemia');
INSERT INTO Consulta (ConsultaID, PacienteID, DataConsulta, Sintomas, Diagnostico) VALUES (10, 10, '2024-06-20', 'Tontura e náusea', 'Labirintite');

-- Tratamento:
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (1, 'Fisioterapia');
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (2, 'Antibioticoterapia');
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (3, 'Cirurgia');
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (4, 'Quimioterapia');
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (5, 'Radioterapia');
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (6, 'Terapia Ocupacional');
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (7, 'Psicoterapia');
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (8, 'Hidroterapia');
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (9, 'Terapia Hormonal');
INSERT INTO Tratamento (TratamentoID, Nome) VALUES (10, 'Acupuntura');

-- ConsultaTratamento:
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (1, 1);
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (2, 2);
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (3, 3);
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (4, 4);
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (5, 5);
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (6, 6);
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (7, 7);
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (8, 8);
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (9, 9);
INSERT INTO ConsultaTratamento (ConsultaID, TratamentoID) VALUES (10, 10);

-- ConsultaMedico:
INSERT INTO ConsultaMedico VALUES (1, 1);
INSERT INTO ConsultaMedico VALUES (2, 2);
INSERT INTO ConsultaMedico VALUES (3, 3);
INSERT INTO ConsultaMedico VALUES (4, 4);
INSERT INTO ConsultaMedico VALUES (5, 5);
INSERT INTO ConsultaMedico VALUES (6, 6);
INSERT INTO ConsultaMedico VALUES (7, 7);
INSERT INTO ConsultaMedico VALUES (8, 8);
INSERT INTO ConsultaMedico VALUES (9, 9);
INSERT INTO ConsultaMedico VALUES (10, 10);

-- Laboratorio:
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (1, 'Laboratório São Lucas', 'Rua das Flores, 123, São Paulo, SP');
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (2, 'Laboratório Vida', 'Av. Central, 456, Rio de Janeiro, RJ');
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (3, 'Lab Diagnósticos', 'Rua do Sol, 789, Belo Horizonte, MG');
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (4, 'Clínica BioLab', 'Av. Paulista, 1001, São Paulo, SP');
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (5, 'Laboratório Saúde Total', 'Rua das Palmeiras, 321, Curitiba, PR');
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (6, 'LabCheck', 'Av. Brasil, 654, Porto Alegre, RS');
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (7, 'Centro Diagnóstico Life', 'Rua das Acácias, 987, Salvador, BA');
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (8, 'Laboratório Médicos Unidos', 'Av. das Nações, 222, Fortaleza, CE');
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (9, 'Lab Exame Fácil', 'Rua do Comércio, 555, Recife, PE');
INSERT INTO Laboratorio (LaboratorioID, Nome, Endereco) VALUES (10, 'Instituto de Análises Clínicas', 'Av. Independência, 777, Brasília, DF');

-- Exames:
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (1, 1, '2024-01-16', 'Hemograma normal', 1);
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (2, 2, '2024-02-21', 'Raio-X mostra hérnia leve', 2);
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (3, 3, '2024-03-11', 'Exame de escarro negativo para bactérias', 3);
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (4, 4, '2024-04-06', 'Ultrassom abdominal sem alterações', 4);
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (5, 5, '2024-04-23', 'Exame de pele indica dermatite', 5);
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (6, 6, '2024-05-02', 'Tomografia sem sinais de AVC', 6);
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (7, 7, '2024-05-11', 'Polissonografia indica insônia leve', 7);
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (8, 8, '2024-06-03', 'Ressonância magnética do joelho normal', 8);
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (9, 9, '2024-06-16', 'Hemoglobina baixa, anemia leve', 9);
INSERT INTO Exame (ExameID, ConsultaID, DataExame, Resultado, LaboratorioID) VALUES (10, 10, '2024-06-21', 'Exame vestibular compatível com labirintite', 10);


-- Procedimento Exame:
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (1, 'Hemograma Completo');
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (2, 'Raio-X Lombar');
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (3, 'Exame de Escarro');
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (4, 'Ultrassom Abdominal');
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (5, 'Biópsia de Pele');
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (6, 'Tomografia Computadorizada');
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (7, 'Polissonografia');
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (8, 'Ressonância Magnética do Joelho');
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (9, 'Dosagem de Hemoglobina');
INSERT INTO ProcedimentoExame (ExameID, Procedimento) VALUES (10, 'Exame Vestibular');


INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (1, 1, '2024-01-15', 'Tomar dipirona a cada 6 horas por 3 dias.');
INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (2, 2, '2024-02-20', 'Uso de anti-inflamatório e repouso.');
INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (3, 3, '2024-03-10', 'Broncodilatador e evitar esforço físico.');
INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (4, 4, '2024-04-05', 'Inibidor de bomba de prótons antes das refeições.');
INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (5, 5, '2024-04-22', 'Pomada dermatológica duas vezes ao dia.');
INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (6, 6, '2024-05-01', 'Analgésico conforme necessário.');
INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (7, 7, '2024-05-10', 'Melatonina 1 hora antes de dormir.');
INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (8, 8, '2024-06-02', 'Fisioterapia e aplicação de gelo.');
INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (9, 9, '2024-06-15', 'Suplemento de ferro e dieta rica em ferro.');
INSERT INTO Receita (ReceitaID, ConsultaID, DataReceita, Observacoes) VALUES (10, 10, '2024-06-20', 'Antivertiginoso por 5 dias.');

INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Dipirona', '500 mg', 'A cada 6 horas', '3 dias');
INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Ibuprofeno', '400 mg', '2 vezes ao dia', '5 dias');
INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Salbutamol', '100 mcg', 'A cada 8 horas', '7 dias');
INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Omeprazol', '20 mg', 'Antes do café da manhã', '14 dias');
INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Cetoconazol', '2%', '2 vezes ao dia', '7 dias');
INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Paracetamol', '750 mg', 'A cada 8 horas', '5 dias');
INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Melatonina', '3 mg', '1 vez ao dia', '10 dias');
INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Sulfato Ferroso', '40 mg', '1 vez ao dia', '30 dias');
INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Betahistina', '24 mg', '2 vezes ao dia', '7 dias');
INSERT INTO Medicamento (Nome, Dosagem, Frequencia, Duracao) VALUES ('Diclofenaco', '50 mg', '3 vezes ao dia', '5 dias');

INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (1, 1);
INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (2, 2);
INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (3, 3);
INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (4, 4);
INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (5, 5);
INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (6, 6);
INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (7, 7);
INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (8, 8);
INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (9, 9);
INSERT INTO ReceitaMedicamento (ReceitaID, MedicamentoID) VALUES (10, 10);

INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (1, 1, '2024-01-15', 150.00);
INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (2, 2, '2024-02-20', 200.00);
INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (3, 3, '2024-03-10', 180.00);
INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (4, 4, '2024-04-05', 220.00);
INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (5, 5, '2024-04-22', 160.00);
INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (6, 6, '2024-05-01', 190.00);
INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (7, 7, '2024-05-10', 140.00);
INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (8, 8, '2024-06-02', 210.00);
INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (9, 9, '2024-06-15', 175.00);
INSERT INTO Pagamento (PagamentoID, ConsultaID, DataPagamento, ValorPago) VALUES (10, 10, '2024-06-20', 160.00);

INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (1, 'Cartão de Crédito', 'Visa final 1234');
INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (2, 'Dinheiro', 'Pago em espécie na recepção');
INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (3, 'Cartão de Débito', 'Mastercard final 5678');
INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (4, 'PIX', 'Transferência via PIX - chave CPF');
INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (5, 'Boleto', 'Boleto bancário gerado e pago');
INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (6, 'Cartão de Crédito', 'Elo final 9012');
INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (7, 'Dinheiro', 'Pago em espécie com troco');
INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (8, 'Cartão de Débito', 'Visa Electron final 3456');
INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (9, 'PIX', 'Pagamento via QR Code');
INSERT INTO FormaPagamento (PagamentoID, Tipo, Detalhes) VALUES (10, 'Cartão de Crédito', 'Nubank final 7788');

INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (1, 'Plano Saúde Vida', 80.00);
INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (2, 'Unimed Nacional', 90.00);
INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (3, 'Bradesco Saúde', 85.50);
INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (4, 'Amil Saúde', 75.00);
INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (5, 'SulAmérica', 88.00);
INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (6, 'NotreDame Intermédica', 70.00);
INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (7, 'Hapvida', 60.00);
INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (8, 'São Francisco Saúde', 82.00);
INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (9, 'Golden Cross', 78.25);
INSERT INTO Convenio (ConvenioID, Nome, PercentualCobertura) VALUES (10, 'Porto Saúde', 86.00);

INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (1, 1);
INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (2, 2);
INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (3, 3);
INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (4, 4);
INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (5, 5);
INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (6, 6);
INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (7, 7);
INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (8, 8);
INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (9, 9);
INSERT INTO PagamentoConvenio (PagamentoID, ConvenioID) VALUES (10, 10);

INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (1, 1);
INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (2, 2);
INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (3, 3);
INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (4, 4);
INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (5, 5);
INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (6, 6);
INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (7, 7);
INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (8, 8);
INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (9, 9);
INSERT INTO PacienteConvenio (PacienteID, ConvenioID) VALUES (10, 10);


-- CONSULTA SQL - Faturamento por especialidade por mês (2024-2025)
SELECT 
    e.Especialidade,
    EXTRACT(YEAR FROM p.DataPagamento) AS Ano,
    EXTRACT(MONTH FROM p.DataPagamento) AS Mes,
    SUM(p.ValorPago) AS FaturamentoMensal
FROM 
    Pagamento p
JOIN 
    ConsultaMedico cm ON p.ConsultaID = cm.ConsultaID
JOIN 
    Especialidade e ON cm.MedicoID = e.MedicoID
WHERE 
    EXTRACT(YEAR FROM p.DataPagamento) IN (2024, 2025)
GROUP BY 
    e.Especialidade, EXTRACT(YEAR FROM p.DataPagamento), EXTRACT(MONTH FROM p.DataPagamento)
ORDER BY 
    e.Especialidade, Ano, Mes;
