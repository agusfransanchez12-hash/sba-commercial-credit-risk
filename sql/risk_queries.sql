-- ==============================================================================
-- SBA Commercial Credit Risk & Loss Analysis
-- Author: Agustin Sanchez | Data & Risk Analyst
-- Target Dataset: sba_loans_cleaned.csv
-- Description: Core analytical SQL queries executed directly on the cleaned dataset.
-- ==============================================================================


-- ==============================================================================
-- 1. RISK ANALYSIS BY INDUSTRY SECTOR
-- Purpose: Ranks sectors by default rate, total monetary losses, and average disbursement.
-- NOTE: every loan in this dataset belongs to NAICS 53 (Real Estate), so this query
-- returns a single row. It is kept as a data check, not as a sector comparison.
-- ==============================================================================

SELECT 
    Sector,
    COUNT(*) AS Total_Prestamos,
    SUM(IsDefault) AS Cantidad_Defaults,
    ROUND(AVG(IsDefault) * 100, 2) AS Default_Rate_Pct,
    ROUND(SUM(ChgOffPrinGr), 2) AS Perdida_Total_USD,
    ROUND(AVG(DisbursementGross), 2) AS Promedio_Monto_Prestado
FROM sba_loans_cleaned
GROUP BY Sector
ORDER BY Default_Rate_Pct DESC;


-- ==============================================================================
-- 2. CREDIT RISK BY SBA STATE GUARANTEE COVERAGE BANDS
-- Purpose: Segments loans into High (>=80%), Medium (50-79%), and Low (<50%) guarantee.
-- NOTE: always read Total_Prestamos next to Perdida_Total_USD. The Low band holds
-- only 3 loans, so the losses concentrate in the Medium band.
-- ==============================================================================

SELECT 
    CASE 
        WHEN SBA_Guarantee_Pct >= 80 THEN 'Garantía Alta (>= 80%)'
        WHEN SBA_Guarantee_Pct >= 50 THEN 'Garantía Media (50% - 79%)'
        ELSE 'Garantía Baja (< 50%)'
    END AS Rango_Garantia,
    COUNT(*) AS Total_Prestamos,
    ROUND(AVG(IsDefault) * 100, 2) AS Default_Rate_Pct,
    ROUND(SUM(ChgOffPrinGr), 2) AS Perdida_Total_USD,
    ROUND(AVG(GrAppv), 2) AS Promedio_Monto_Aprobado
FROM sba_loans_cleaned
GROUP BY 1
ORDER BY Default_Rate_Pct DESC;


-- ==============================================================================
-- 3. VULNERABILITY SEGMENTATION BY BUSINESS SIZE (NUMBER OF EMPLOYEES)
-- Purpose: Groups borrowers by the company's own headcount (NoEmp), from micro-enterprises to large firms.
-- Note: Total_Jobs_Impacted (jobs created + retained by the loan) is NOT a size measure.
-- ==============================================================================

SELECT 
    CASE 
        WHEN NoEmp = 0 THEN '0 Empleos'
        WHEN NoEmp BETWEEN 1 AND 5 THEN '1 - 5 Empleos'
        WHEN NoEmp BETWEEN 6 AND 20 THEN '6 - 20 Empleos'
        ELSE 'Más de 20 Empleos'
    END AS Segmento_Empleos,
    COUNT(*) AS Total_Prestamos,
    ROUND(AVG(IsDefault) * 100, 2) AS Default_Rate_Pct,
    ROUND(SUM(Total_Jobs_Impacted), 0) AS Total_Empleos_Generados
FROM sba_loans_cleaned
GROUP BY 1
ORDER BY Default_Rate_Pct DESC;

-- ==============================================================================
-- 4. LOAN TERM VULNERABILITY ANALYSIS (MATURITY RISK)
-- Purpose: Groups loans by maturity duration (<5 yrs, 5-15 yrs, >15 yrs).
-- NOTE: Term is expressed in MONTHS (60 = 5 years, 180 = 15 years).
-- ==============================================================================

SELECT 
    CASE 
        WHEN Term < 60 THEN 'Corto Plazo (< 5 Años)'
        WHEN Term BETWEEN 60 AND 180 THEN 'Mediano Plazo (5 - 15 Años)'
        ELSE 'Largo Plazo (> 15 Años)'
    END AS Categoria_Plazo,
    COUNT(*) AS Total_Prestamos,
    ROUND(AVG(IsDefault) * 100, 2) AS Default_Rate_Pct,
    ROUND(SUM(ChgOffPrinGr), 2) AS Perdida_Acumulada_USD
FROM sba_loans_cleaned
GROUP BY 1
ORDER BY Default_Rate_Pct DESC;