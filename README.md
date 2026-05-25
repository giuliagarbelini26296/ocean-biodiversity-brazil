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
![Mapa](outputs/01_mapa_ocorrencias.png)

### Records by Species
![Espécies](outputs/02_registros_por_especie.png)

### Temporal Trend
![Tendência](outputs/03_tendencia_temporal.png)

### Seasonality
![Sazonalidade](outputs/04_sazonalidade.png)

---

## 🗂️ Project Structure
