---
title: "projeto"
output: html_document
date: "2026-05-25"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# 🐋 Ocean Biodiversity Brazil

![Language](https://img.shields.io/badge/Language-R-276DC3?style=flat&logo=r)
![Data](https://img.shields.io/badge/Data-OBIS-0072B2?style=flat)
![Topic](https://img.shields.io/badge/Topic-Marine%20Mammals-2E86AB?style=flat)
![Status](https://img.shields.io/badge/Status-Active-4CAF50?style=flat)
![License](https://img.shields.io/badge/License-MIT-yellow?style=flat)

Exploratory analysis of marine mammal occurrences along the Brazilian coast 
using open data from the **Ocean Biodiversity Information System (OBIS)**.

---

## 🐬 Species Analyzed

| Species | Common Name (PT) | Records |
|---|---|---|
| *Megaptera novaeangliae* | Baleia-jubarte | 4.684 |
| *Physeter macrocephalus* | Cachalote | 937 |
| *Sotalia guianensis* | Boto-cinza | 431 |
| *Tursiops truncatus* | Golfinho-nariz-de-garrafa | 42 |
| *Pontoporia blainvillei* | Franciscana | 4 |
| *Delphinus delphis* | Golfinho-comum | 2 |

> **Total: 6,100 occurrence records | Period: 1849–2026**

---

## 📊 Visualizations

### Occurrence Map
<img width="1500" height="1800" alt="image" src="https://github.com/user-attachments/assets/7077852a-dc6d-4511-82e1-6556b4ee6135" />


### Records by Species
<img width="1350" height="750" alt="image" src="https://github.com/user-attachments/assets/03bfa19c-2d34-4b22-94eb-02eecc78a2fa" />

### Temporal Trend
<img width="1650" height="900" alt="image" src="https://github.com/user-attachments/assets/f7d1362c-1d9b-43f5-8c33-72fcbaa582ba" />


### Seasonality
<img width="1650" height="900" alt="image" src="https://github.com/user-attachments/assets/2df00070-9cb6-4611-bf9d-0bb11230c043" />


---

## 🗂️ Project Structure

```markdown
## 🗂️ Project Structure

```
ocean-biodiversity-brazil/
├── Ocean_Biodiversity_Brazil.Rmd    # R Markdown principal
├── 01_mapa_ocorrencias.png          # Mapa de ocorrências
├── 02_registros_por_especie.png     # Registros por espécie
├── 03_tendencia_temporal.png        # Tendência temporal
├── 04_sazonalidade.png              # Sazonalidade
├── mamiferos_marinhos_brasil.csv    # Dados brutos (6.100 registros)
├── resumo_por_especie.csv           # Resumo estatístico
├── pico_mensal.csv                  # Pico mensal por espécie
├── tendencia_temporal.csv           # Tendência temporal por espécie
└── README.md
```
```


