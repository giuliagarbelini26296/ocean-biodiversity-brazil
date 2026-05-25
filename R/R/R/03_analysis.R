# =============================================================================
# 03_analysis.R
# Análise estatística — mamíferos marinhos no Brasil
# =============================================================================

library(tidyverse)

dados <- read_csv("data/mamiferos_marinhos_brasil.csv",
                  show_col_types = FALSE)

nomes_populares <- c(
  "Megaptera novaeangliae" = "Baleia-jubarte",
  "Tursiops truncatus"     = "Golfinho-nariz-de-garrafa",
  "Sotalia guianensis"     = "Boto-cinza",
  "Pontoporia blainvillei" = "Franciscana",
  "Delphinus delphis"      = "Golfinho-comum",
  "Physeter macrocephalus" = "Cachalote"
)

dados <- dados %>%
  mutate(nome_popular = recode(especie, !!!nomes_populares))

# -----------------------------------------------------------------------------
# Tabela resumo por espécie
# -----------------------------------------------------------------------------

resumo <- dados %>%
  group_by(nome_popular) %>%
  summarise(
    registros   = n(),
    ano_min     = min(ano, na.rm = TRUE),
    ano_max     = max(ano, na.rm = TRUE),
    lat_media   = round(mean(latitude,  na.rm = TRUE), 2),
    lon_media   = round(mean(longitude, na.rm = TRUE), 2),
    .groups = "drop"
  ) %>%
  arrange(desc(registros))

cat("=== Resumo por espécie ===\n")
print(resumo)

write_csv(resumo, "outputs/resumo_por_especie.csv")

# -----------------------------------------------------------------------------
# Tendência temporal — regressão linear por espécie
# -----------------------------------------------------------------------------

cat("\n=== Tendência temporal (registros por ano) ===\n")

tendencia <- dados %>%
  filter(ano >= 1980 & ano <= 2025) %>%
  count(ano, nome_popular) %>%
  group_by(nome_popular) %>%
  summarise(
    slope     = round(coef(lm(n ~ ano))[2], 3),
    tendencia = ifelse(coef(lm(n ~ ano))[2] > 0,
                       "↑ Crescente", "↓ Decrescente"),
    .groups = "drop"
  )

print(tendencia)
write_csv(tendencia, "outputs/tendencia_temporal.csv")

# -----------------------------------------------------------------------------
# Mês com mais registros por espécie
# -----------------------------------------------------------------------------

cat("\n=== Mês de pico por espécie ===\n")

pico_mensal <- dados %>%
  filter(!is.na(month)) %>%
  count(nome_popular, month) %>%
  group_by(nome_popular) %>%
  slice_max(n, n = 1) %>%
  mutate(mes_nome = month.name[month]) %>%
  select(nome_popular, mes_nome, registros = n)

print(pico_mensal)
write_csv(pico_mensal, "outputs/pico_mensal.csv")

cat("\nAnálises salvas em outputs/\n")
cat("Projeto concluído! Hora do git push 🚀\n")
