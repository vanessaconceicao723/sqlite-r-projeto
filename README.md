📊 Projeto de Análise com SQLite e R
📌 Descrição

Este projeto demonstra um fluxo completo de tratamento de dados com SQL e análise em R, utilizando como base uma amostra de 5% de um dataset original com mais de 1 milhão de registros.

O objetivo é mostrar:

Como estruturar uma tabela em SQLite a partir de um CSV.

Como executar queries SQL de tratamento e agregação.

Como conectar o R ao banco SQLite e rodar estatísticas descritivas.

## 📂 Estrutura do Repositório
sql/

 └── tratamento.sql        # Script SQL de criação de tabela e consultas
R/

 └── analise.R             # Script em R para análise com SQLite
data/

 └── K3241_amostra5.csv    # Amostra de 5% do dataset original
 
README.md                  # Documentação do projeto


1. Tratamento com SQL

Exemplo criação de tabela

CREATE TABLE empresas (id TEXT, nome_razao TEXT, cod3 INTEGER, cod4 INTEGER, valor TEXT, cod6 INTEGER, observacao TEXT);

Exemplo de consulta de agregação

SELECT 
    cod3,
    SUM(CAST(REPLACE(REPLACE(valor, '.', ''), ',', '.') AS REAL)) AS soma_valores
FROM empresas
GROUP BY cod3
ORDER BY soma_valores DESC
LIMIT 10;

2. Análise com R

   O script analise.R
 conecta-se ao banco SQLite gerado, faz consultas e calcula estatísticas descritivas.

Passos principais:

Conectar ao banco SQLite (empresas.db).

Ler os primeiros registros da tabela empresas.

Calcular a média dos valores por cod4.

Encerrar a conexão.

Trecho do código em R

# Conectar ao banco SQLite
con <- dbConnect(SQLite(), "empresas.db")

# Ler primeiras linhas
head(dbReadTable(con, "empresas"), 5)

# Exemplo: médias por cod4
dbGetQuery(con, "
  SELECT cod4,
         AVG(CAST(REPLACE(REPLACE(valor, '.', ''), ',', '.') AS REAL)) AS media_valores
  FROM empresas
  GROUP BY cod4
  ORDER BY media_valores DESC
  LIMIT 10;
")

# Encerrar conexão
dbDisconnect(con)

Como Reproduzir
1. Criar o banco SQLite

sqlite3 empresas.db < sql/tratamento.sql

2. Carregar a amostra de dados

Importar data/K3241_amostra5.csv para a tabela empresas:

sqlite3 empresas.db
.mode csv
.import data/K3241_amostra5.csv empresas


3. Rodar análise no R

   source("R/analise.R")

🔎 Fonte dos Dados

Os dados utilizados neste repositório são públicos e foram retirados dos microdados disponibilizados pela Receita Federal do Brasil.

O uso neste projeto tem caráter exclusivamente técnico, acadêmico e demonstrativo, sem qualquer alteração de conteúdo original ou divulgação de informações sigilosas.
