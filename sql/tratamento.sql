-- Criação de tabela a partir do CSV importado
CREATE TABLE empresas (
    id TEXT,
    nome_razao TEXT,
    cod3 INTEGER,
    cod4 INTEGER,
    valor TEXT,
    cod6 INTEGER,
    observacao TEXT
);

-- Index para acelerar consultas por código
CREATE INDEX idx_empresas_cod3 ON empresas (cod3);

-- Consulta exemplo: somar valores por cod3
SELECT 
    cod3,
    SUM(CAST(REPLACE(REPLACE(valor, '.', ''), ',', '.') AS REAL)) AS soma_valores
FROM empresas
GROUP BY cod3
ORDER BY soma_valores DESC
LIMIT 10;
