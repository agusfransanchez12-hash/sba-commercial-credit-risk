# 📊 SBA Commercial Credit Risk: Estrategia de Mitigación y Análisis de Pérdidas

Proyecto End-to-End de Riesgo Crediticio y Finanzas (SQL, Python, Power BI y Presentación Ejecutiva)

📌 Read this in English / Leer esto en Inglés: [README.md](README.md)

---

## Resumen Ejecutivo

Este proyecto realiza una evaluación cuantitativa del riesgo de crédito sobre la cartera de préstamos comerciales de la Administración de Pequeños Negocios de EE. UU. (SBA). Mediante el análisis del comportamiento histórico de morosidad y castigos de cartera, el estudio identifica vulnerabilidades en la suscripción, cuantifica la exposición monetaria a pérdidas y propone una estrategia de mitigación de riesgos para entidades financieras.

* **Impacto Financiero:** **$42.1M en pérdidas totales por castigo**, con **$38.5M (91.4%)** concentrados en créditos de baja garantía estatal (<50% cobertura SBA).
* **Vulnerabilidad por Plazo:** Los préstamos a corto plazo (<5 años) registran un **pico crítico de mora del ~86%**, impulsado por esquemas de pago agresivos.
* **Riesgo por Escala de Empresa:** Las microempresas (1 a 5 empleados) representan la mayor concentración de impago con un **38.3%**.

---

## 📊 Hallazgos Clave e Insights Visuales

### 1. El Pico de Morosidad en Corto Plazo
Los créditos estructurados a menos de 60 meses enfrentan una alta presión sobre el flujo de caja, generando la mayor tasa de mora de la cartera (~86%).

### 2. Brecha de Cobertura de Garantía
La baja cobertura de garantía estatal (<50%) constituye la principal fuente de erosión de capital, absorbiendo más de $38.5M en pérdidas acumuladas.

### 3. Exposición por Tamaño de Empresa
Las microempresas carecen de los amortiguadores de liquidez necesarios para resistir shocks macroeconómicos, alcanzando una mora del 38.3% frente a la estabilidad de empresas medianas (>20 empleados).

---

## 🎯 Recomendaciones Estratégicas y ROI Objetivo

* **Pilar 1 | Política de Suscripción (Reestructuración de Plazos):** Establecer plazos mínimos obligatorios (o periodos de gracia iniciales) para créditos comerciales a corto plazo para alinear el servicio de deuda con la estabilización del flujo de caja.
  * **ROI Objetivo:** Reduce la mora en corto plazo entre un **15% y 20%**, protegiendo las reservas de capital.
* **Pilar 2 | Gestión de Riesgo (Cobertura de Garantía Dinámica):** Exigir una mayor cobertura de garantía estatal (≥80%) para perfiles de alto riesgo (microempresas y créditos sin colateral comercial sólido).
  * **ROI Objetivo:** Mitiga hasta **+$25M** en exposición a pérdidas no respaldadas.
* **Pilar 3 | Scoring Crediticio (Pruebas de Estrés DSCR):** Implementar evaluaciones automatizadas de la Cobertura del Servicio de la Deuda (DSCR) durante la originación para sectores vulnerables.
  * **ROI Objetivo:** Previene la entrada en mora temprana y optimiza la provisión de cartera.

---

## 🛠️ Stack Tecnológico y Metodología

* **SQL:** Creación de tablas (DDL), agregaciones de cartera, cálculo de tasas de mora y consultas de distribución de pérdidas.
* **Python (Pandas / Pipeline de Datos):** Procesamiento ETL, limpieza de datos, ingeniería de variables (`SBA_Guarantee_Pct`, `Sector`, `Total_Jobs_Impacted`) y exportación del dataset.
* **Power BI y PowerPoint:** Reporte interactivo de riesgo, tablero de salud de cartera y presentación ejecutiva bilingüe.

---

## 📂 Estructura del Repositorio

```text
sba-commercial-credit-risk/
│
├── data/                  # Dataset procesado (SBA_Loans_Cleaned.csv)
├── docs/                  # PDFs de la Presentación Ejecutiva (EN y ES)
├── notebooks/             # Scripts de limpieza y ETL en Python (SBA.PY)
├── power_bi/              # Tablero interactivo en Power BI (.pbix)
├── sql/                   # Consultas DDL y analíticas en SQL (risk_queries.sql)
├── .gitignore             # Reglas para ignorar archivos en Git
├── README.md              # Versión en Inglés (Principal)
└── README_ES.md           # Versión en Español

👤 Autor: Agustín Sanchez | Analista de Datos y Riesgo Crediticio

🔗 LinkedIn: https://www.linkedin.com/in/agustin-f-sanchez-20a9202a2/
