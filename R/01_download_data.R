# =============================================================================
# 01_download_data.R
# Download de mamíferos marinhos via API do OBIS (sem pacote robis)
# =============================================================================

library(httr)
library(jsonlite)
library(tidyverse)

if (!dir.exists("data"))    dir.create("data")
if (!dir.exists("outputs")) dir.create("outputs")

# -----------------------------------------------------------------------------
# Função para buscar ocorrências na API do OBIS
# -----------------------------------------------------------------------------

buscar_obis <- function(especie, limite = 5000) {
  cat("Baixando:", especie, "...\n")
  
  url <- "https://api.obis.org/v3/occurrence"
  
  resposta <- GET(url, query = list(
    scientificname = especie,
    geometry       = "POLYGON((-53 -35,-28 -35,-28 5,-53 5,-53 -35))",
    size           = limite
  ))
  
  if (status_code(resposta) != 200) {
    cat("  → Erro na requisição\n")
    return(NULL)
  }
  
  conteudo <- fromJSON(rawToChar(resposta$content))
  
  if (is.null(conteudo$results) || nrow(conteudo$results) == 0) {
    cat("  → Nenhum registro\n")
    return(NULL)
  }
  
  cat("  →", nrow(conteudo$results), "registros\n")
  return(conteudo$results)
}

# -----------------------------------------------------------------------------
# Espécies de interesse
# -----------------------------------------------------------------------------

especies <- c(
  "Megaptera novaeangliae",  # Baleia-jubarte
  "Tursiops truncatus",      # Golfinho-nariz-de-garrafa
  "Sotalia guianensis",      # Boto-cinza
  "Pontoporia blainvillei",  # Franciscana
  "Delphinus delphis",       # Golfinho-comum
  "Physeter macrocephalus"   # Cachalote
)

# -----------------------------------------------------------------------------
# Baixa todas as espécies
# -----------------------------------------------------------------------------

dados_lista <- map(especies, buscar_obis)
names(dados_lista) <- especies

# -----------------------------------------------------------------------------
# Combina e limpa
# -----------------------------------------------------------------------------

colunas_uteis <- c(
  "scientificName", "decimalLatitude", "decimalLongitude",
  "date_year", "month", "institutionCode", "basisOfRecord"
)

dados_todos <- dados_lista %>%
  keep(~ !is.null(.x)) %>%
  map(~ select(.x, any_of(colunas_uteis))) %>%
  bind_rows() %>%
  filter(
    !is.na(decimalLatitude),
    !is.na(decimalLongitude),
    !is.na(date_year)
  ) %>%
  rename(
    especie   = scientificName,
    latitude  = decimalLatitude,
    longitude = decimalLongitude,
    ano       = date_year
  )

# -----------------------------------------------------------------------------
# Resumo
# -----------------------------------
cat("\n=== Resumo ===\n")
cat("Total de registros:", nrow(dados_todos), "\n")
cat("Período           :", min(dados_todos$ano), "–", max(dados_todos$ano), "\n")
cat("Espécies:\n")
print(table(dados_todos$especie))

# -----------------------------------------------------------------------------
# Salva
# -----------------------------------------------------------------------------

write_csv(dados_todos, "data/mamiferos_marinhos_brasil.csv")
cat("\nSalvo em: data/mamiferos_marinhos_brasil.csv\n")
cat("Próximo passo: execute R/02_visualization.R\n")
