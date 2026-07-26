import numpy as np
import pandas as pd

# 1. Cargar el dataset original
# (Cambiá 'SBAnational.csv' por el nombre de tu archivo si es distinto)
df = pd.read_csv('SBAcase.11.13.17.csv', low_memory=False)

print("=== RESUMEN DE NULOS Y DUPLICADOS ===")
nulls_summary = pd.DataFrame({
    'Nulos': df.isnull().sum(),
    'Porcentaje_%': (df.isnull().sum() / len(df)) * 100,
})
print(nulls_summary[nulls_summary['Nulos'] > 0])
print(f"\nFilas duplicadas exactas: {df.duplicated().sum()}\n")

# 3. Tratamiento de Nulos
# Eliminamos las filas donde falta el estado del préstamo o la fecha de desembolso (solo ~3 filas)
df = df.dropna(subset=['MIS_Status', 'DisbursementDate'])

# Rellenamos nulos en Bank y BankState
df['Bank'] = df['Bank'].fillna('Desconocido')
df['BankState'] = df['BankState'].fillna('Desconocido')

# 4. Crear la variable Target (1 = Default/Impago, 0 = Pagado)
# En MIS_Status: 1 suele ser impago/ChargeOff o lo categorizamos según corresponda
df['IsDefault'] = np.where(
    df['MIS_Status'].astype(str).str.contains('CHGOFF|1', case=False), 1, 0
)

# 5. Limpieza de Monedas (Convertir texto con '$' o comas a número)
currency_cols = ['DisbursementGross', 'BalanceGross', 'ChgOffPrinGr', 'GrAppv', 'SBA_Appv']

df['DisbursementGross'] = pd.to_numeric(
    df['DisbursementGross'].astype(str).str.replace('$', '', regex=False).str.replace(',', '', regex=False), errors='coerce'
)
df['BalanceGross'] = pd.to_numeric(
    df['BalanceGross'].astype(str).str.replace('$', '', regex=False).str.replace(',', '', regex=False), errors='coerce'
)
df['ChgOffPrinGr'] = pd.to_numeric(
    df['ChgOffPrinGr'].astype(str).str.replace('$', '', regex=False).str.replace(',', '', regex=False), errors='coerce'
)
df['GrAppv'] = pd.to_numeric(
    df['GrAppv'].astype(str).str.replace('$', '', regex=False).str.replace(',', '', regex=False), errors='coerce'
)
df['SBA_Appv'] = pd.to_numeric(
    df['SBA_Appv'].astype(str).str.replace('$', '', regex=False).str.replace(',', '', regex=False), errors='coerce'
)

# 6. FEATURE ENGINEERING (Nuevas variables de negocio)

# A. Cobertura de la garantía estatal (%)
df['SBA_Guarantee_Pct'] = (df['SBA_Appv'] / df['GrAppv']) * 100

# B. Extracción del Sector Industrial (Primeros 2 dígitos del código NAICS)
df['Sector_Code'] = df['NAICS'].astype(str).str[:2]

sector_map = {
    '11': 'Agro/Caza/Pesca',
    '21': 'Minería/Petróleo',
    '22': 'Utilities (Luz/Agua)',
    '23': 'Construcción',
    '31': 'Manufactura',
    '32': 'Manufactura',
    '33': 'Manufactura',
    '42': 'Comercio Mayorista',
    '44': 'Comercio Minorista',
    '45': 'Comercio Minorista',
    '48': 'Transporte',
    '49': 'Transporte',
    '51': 'Información/Tech',
    '52': 'Finanzas/Seguros',
    '53': 'Bienes Raíces',
    '54': 'Servicios Profesionales',
    '55': 'Gestión de Empresas',
    '56': 'Servicios Administrativos',
    '61': 'Educación',
    '62': 'Salud/Asistencia Social',
    '71': 'Arte/Entretenimiento',
    '72': 'Alojamiento/Restaurantes',
    '81': 'Otros Servicios',
    '92': 'Administración Pública',
}

df['Sector'] = df['Sector_Code'].map(sector_map).fillna('Otros/No Especificado')

# C. Impacto Social Total (Suma de empleos creados y conservados)
df['CreateJob'] = df['CreateJob'].fillna(0)
df['RetainedJob'] = df['RetainedJob'].fillna(0)
df['Total_Jobs_Impacted'] = df['CreateJob'] + df['RetainedJob']

# 7. Exportar CSV Limpio para SQL
df.to_csv('SBA_Loans_Cleaned.csv', index=False)
print("\n¡Proceso finalizado con éxito! Archivo 'SBA_Loans_Cleaned.csv' guardado.")