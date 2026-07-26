-- ==============================================================================
-- SBA Commercial Credit Risk & Loss Analysis
-- Author: Agustin Sanchez | Data & Risk Analyst
-- Target Dataset: sba_loans_cleaned.csv
-- Description: Core analytical SQL queries executed directly on the cleaned dataset.
-- ==============================================================================


-- ==============================================================================
-- 1. RISK ANALYSIS BY INDUSTRY SECTOR
-- Purpose: Ranks sectors by default rate, total monetary losses, and average disbursement.
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
-- ==============================================================================

SELECT 
    CASE 
        WHEN SBA_Guarantee_Pct >= 80 THEN 'Garantía Alta (>= 80%)'
        WHEN SBA_Guarantee_Pct >= 50 THEN 'Garantía Media (50% - 79%)'
        ELSE 'Garantía Baja (< 50%)'
    END AS Rango_Garantia,
    COUNT(*) AS Total_Prestamos,
    ROUND(AVG(IsDefault) * 100, 2) AS Default_Rate_Pct,
    ROUND(AVG(GrAppv), 2) AS Promedio_Monto_Aprobado
FROM sba_loans_cleaned
GROUP BY 1
ORDER BY Default_Rate_Pct DESC;


-- ==============================================================================
-- 3. VULNERABILITY SEGMENTATION BY BUSINESS SCALE (JOBS IMPACTED)
-- Purpose: Groups borrowers by job impact scale (Micro-enterprises to large firms).
-- ==============================================================================

SELECT 
    CASE 
        WHEN Total_Jobs_Impacted = 0 THEN '0 Empleos'
        WHEN Total_Jobs_Impacted BETWEEN 1 AND 5 THEN '1 - 5 Empleos'
        WHEN Total_Jobs_Impacted BETWEEN 6 AND 20 THEN '6 - 20 Empleos'
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