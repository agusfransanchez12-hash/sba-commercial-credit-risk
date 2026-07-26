# 📊 SBA Commercial Credit Risk: Portfolio Loss & Underwriting Strategy

End-to-End Financial & Credit Risk Project (SQL, Python, Power BI & Executive Presentation)

📌 Read this in Spanish / Leer esto en Español: [README_ES.md](README_ES.md)

---

## Executive Summary

This project conducts a quantitative credit risk assessment on the U.S. Small Business Administration (SBA) commercial loan portfolio. By processing historical default rates and capital charge-offs, the analysis identifies structural underwriting vulnerabilities, quantifies net monetary loss exposure, and delivers an actionable risk mitigation strategy for commercial lenders.

* **Financial Impact:** **$42.1M in total charge-off losses**, with **$38.5M (91.4%)** concentrated in unbacked low-guarantee loans (<50% SBA coverage).
* **Maturity Vulnerability:** Short-term loans (<5 years) exhibit a critical **~86% default rate**, driven by aggressive debt service structures.
* **Borrower Scale Risk:** Micro-enterprises (1 to 5 employees) show the highest default concentration at **38.3%**.

---

## 📊 Key Findings & Visual Insights

### 1. The Short-Term Maturity Spike
Loans structured under 60 months face severe cash-flow pressure, driving the portfolio's highest default concentration (~86%).

### 2. Guarantee Coverage Gap
Low SBA guarantee coverage (<50%) represents the primary source of capital erosion, absorbing over $38.5M in cumulative loss exposure.

### 3. Business Scale Exposure
Micro-enterprises lack the liquidity buffers needed to absorb macroeconomic shocks, resulting in a 38.3% default rate compared to stable mid-sized firms (>20 employees).

---

## 🎯 Strategic Recommendations & Target ROI

* **Pillar 1 | Underwriting Policy (Maturity Restructuring):** Establish mandatory minimum term lengths (or initial grace periods) for short-term commercial loans to align debt service with cash-flow stabilization.
  * **Target ROI:** Reduces short-term default rates by **15–20%**, protecting capital reserves.
* **Pillar 2 | Risk Management (Dynamic Guarantee Thresholds):** Mandate higher SBA guarantee coverage (≥80%) for high-risk borrower profiles (micro-enterprises and unsecured commercial loans).
  * **Target ROI:** Mitigates up to **$25M+** in unbacked loss exposure.
* **Pillar 3 | Credit Scoring (DSCR Stress-Testing):** Implement automated Debt Service Coverage Ratio (DSCR) stress-testing during originations for vulnerable sectors like Micro-Enterprises.
  * **Target ROI:** Prevents premature default entry and optimizes loan provisioning.

---

## 🛠️ Tech Stack & Methodology

* **SQL:** Database schema creation (DDL), portfolio aggregation, default rate calculations, and loss distribution queries.
* **Python (Pandas / Data Pipeline):** ETL processing, data cleaning, feature engineering (`SBA_Guarantee_Pct`, `Sector`, `Total_Jobs_Impacted`), and dataset export.
* **Power BI & PowerPoint:** Interactive risk reporting, portfolio health dashboarding, and bilingual executive presentation.

---

## 📂 Repository Structure

```text
sba-commercial-credit-risk/
│
├── data/                  # Cleaned dataset (SBA_Loans_Cleaned.csv)
├── docs/                  # Executive Presentation PDFs (EN & ES)
├── notebooks/             # Python ETL & cleaning scripts (SBA.PY)
├── power_bi/              # Interactive Power BI Dashboard (.pbix)
├── sql/                   # DDL and analytical SQL queries (risk_queries.sql)
├── .gitignore             # Git exclusion rules
├── README.md              # English Version (Main)
└── README_ES.md           # Spanish Version

👤 Author: Agustin Sanchez | Data & Risk Analyst

🔗 LinkedIn: (https://www.linkedin.com/in/agustin-f-sanchez-20a9202a2/)

