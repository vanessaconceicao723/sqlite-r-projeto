# ---------------------------------------------------------
# Script de Análise em R com SQLite
# ---------------------------------------------------------
# Este script conecta em um banco SQLite, faz consultas e
# calcula estatísticas simples.
# ---------------------------------------------------------

# Pacotes necessários
library(DBI)
library(RSQLite)
library(dplyr)

# Conectar ao banco SQLite (já criado a partir do CSV)
con <- dbConnect(SQLite(), "empresas.db")

# 1. Ler as primeiras linhas da tabela
cat("Primeiros registros da tabela:\n")
print(head(dbReadTable(con, "empresas"), 5))

# 2. Exemplo: valores médios por cod4
df <- dbGetQuery(con, "
  SELECT cod4,
         AVG(CAST(REPLACE(REPLACE(valor, '.', ''), ',', '.') AS REAL)) AS media_valores
  FROM empresas
  GROUP BY cod4
  ORDER BY media_valores DESC
  LIMIT 10;
")

cat("\nMédias por cod4:\n")
print(df)

# Encerrar conexão
dbDisconnect(con)
