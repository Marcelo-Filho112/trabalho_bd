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