# 🖥️ ETL | Auditoría de Ventas de Hardware Corporativo

## 📌 Descripción

Este proyecto implementa un proceso ETL completo para auditar, limpiar, validar y analizar información de ventas de hardware corporativo.

El dataset contiene transacciones con diferentes problemas de calidad de datos que deben ser detectados y tratados antes de realizar cualquier análisis de negocio.

Los principales desafíos incluyen:

- Precios almacenados como texto monetario.
- Símbolos de moneda y separadores de miles.
- Valores negativos o desproporcionados.
- Descuentos lógicamente inválidos.
- Cantidades vendidas negativas o extremadamente elevadas.
- Inconsistencias en nombres de sucursales.
- Inconsistencias en tipos de equipos.
- Fechas almacenadas en múltiples formatos.
- Registros con fechas corruptas.

El objetivo es convertir estos datos desordenados en información confiable y preparada para análisis y almacenamiento en SQL Server.

---

# 🎯 Objetivo

Construir un pipeline ETL profesional capaz de:

1. Extraer los datos originales.
2. Auditar la calidad de la información.
3. Limpiar y transformar los datos.
4. Detectar valores inválidos y outliers.
5. Validar la información procesada.
6. Cargar los datos limpios en SQL Server.
7. Generar métricas de negocio.

---

# 🔄 Arquitectura ETL

```text
                    CSV ORIGINAL
                         │
                         ▼
                  ┌─────────────┐
                  │   EXTRACT   │
                  └──────┬──────┘
                         │
                         ▼
                  ┌─────────────┐
                  │  TRANSFORM  │
                  └──────┬──────┘
                         │
                         ▼
                  ┌─────────────┐
                  │  VALIDATE   │
                  └──────┬──────┘
                         │
                ┌────────┴────────┐
                │                 │
             VÁLIDO             ERROR
                │                 │
                ▼                 ▼
              LOAD              LOGS
                │
                ▼
             REPORT
                │
                ▼
       MÉTRICAS DE NEGOCIO



Proyecto_ETL/
│
├── data/
│   ├── raw/
│   │   └── desafio_hardware_corporativo.csv
│   │
│   ├── processed/
│   │   └── Datos_limpios.csv
│   │
│   └── output/
│       └── reporte.txt
│
├── logs/
│   └── etl.log
│
├── config.py
├── logger.py
├── extract.py
├── transform.py
├── validate.py
├── load.py
├── report.py
├── utils.py
├── main.py
│
├── requirements.txt
└── README.md
