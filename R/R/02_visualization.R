# =============================================================================
# 02_visualization.R
# Visualizações de ocorrências de mamíferos marinhos no Brasil
# =============================================================================

library(tidyverse)
library(ggplot2)

# Carrega dados
dados <- read_csv("data/mamiferos_marinhos_brasil.csv", 
                  show_col_types = FALSE)

# Nomes populares para os gráficos
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
# Gráfico 1 — Mapa de ocorrências
# -----------------------------------------------------------------------------

brasil_lon <- c(-55, -28)
brasil_lat <- c(-35, 5)

p1 <- ggplot(dados, aes(x = longitude, y = latitude, 
                        colour = nome_popular)) +
  geom_point(alpha = 0.4, size = 1.2) +
  coord_fixed(xlim = brasil_lon, ylim = brasil_lat) +
  scale_colour_brewer(palette = "Set2") +
  labs(
    title    = "Ocorrências de Mamíferos Marinhos no Brasil",
    subtitle = paste("Total:", nrow(dados), "registros | Fonte: OBIS"),
    x        = "Longitude",
    y        = "Latitude",
    colour   = "Espécie"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title    = element_text(face = "bold"),
    legend.position = "bottom",
    legend.title  = element_text(face = "bold")
  ) +
  guides(colour = guide_legend(nrow = 2))

ggsave("outputs/01_mapa_ocorrencias.png", p1, 
       width = 10, height = 12, dpi = 150)
cat("Salvo: outputs/01_mapa_ocorrencias.png\n")

# -----------------------------------------------------------------------------
# Gráfico 2 — Registros por espécie
# -----------------------------------------------------------------------------

p2 <- dados %>%
  count(nome_popular) %>%
  arrange(n) %>%
  mutate(nome_popular = fct_inorder(nome_popular)) %>%
  ggplot(aes(x = n, y = nome_popular, fill = nome_popular)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = n), hjust = -0.2, size = 4) +
  scale_fill_brewer(palette = "Set2") +
  scale_x_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title    = "Registros por Espécie",
    subtitle = "Litoral brasileiro | Fonte: OBIS",
    x        = "Número de registros",
    y        = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold"))

ggsave("outputs/02_registros_por_especie.png", p2,
       width = 9, height = 5, dpi = 150)
cat("Salvo: outputs/02_registros_por_especie.png\n")

# -----------------------------------------------------------------------------
# Gráfico 3 — Tendência temporal
# -----------------------------------------------------------------------------

p3 <- dados %>%
  filter(ano >= 1980) %>%
  count(ano, nome_popular) %>%
  ggplot(aes(x = ano, y = n, colour = nome_popular)) +
  geom_line(linewidth = 0.8, alpha = 0.8) +
  geom_point(size = 1.5, alpha = 0.7) +
  scale_colour_brewer(palette = "Set2") +
  labs(
    title    = "Registros ao Longo do Tempo",
    subtitle = "Mamíferos marinhos no Brasil | Fonte: OBIS",
    x        = "Ano",
    y        = "Número de registros",
    colour   = "Espécie"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title      = element_text(face = "bold"),
    legend.position = "bottom"
  ) +
  guides(colour = guide_legend(nrow = 2))

ggsave("outputs/03_tendencia_temporal.png", p3,
       width = 11, height = 6, dpi = 150)
cat("Salvo: outputs/03_tendencia_temporal.png\n")

# -----------------------------------------------------------------------------
# Gráfico 4 — Sazonalidade
# -----------------------------------------------------------------------------

p4 <- dados %>%
  filter(!is.na(month)) %>%
  count(month, nome_popular) %>%
  mutate(mes_nome = month.abb[month]) %>%
  mutate(mes_nome = fct_reorder(mes_nome, month)) %>%
  ggplot(aes(x = mes_nome, y = n, fill = nome_popular)) +
  geom_col(position = "dodge") +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title    = "Sazonalidade das Ocorrências",
    subtitle = "Distribuição mensal | Fonte: OBIS",
    x        = "Mês",
    y        = "Número de registros",
    fill     = "Espécie"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title      = element_text(face = "bold"),
    legend.position = "bottom"
  ) +
  guides(fill = guide_legend(nrow = 2))

ggsave("outputs/04_sazonalidade.png", p4,
       width = 11, height = 6, dpi = 150)
cat("Salvo: outputs/04_sazonalidade.png\n")

cat("\nTodos os gráficos gerados em outputs/\n")
cat("Próximo passo: execute R/03_analysis.R\n")

source("R/02_visualization.R")
