#Carpetas
FOLDER = "data/raw"
PROCESSED_DATA = "data/processed"
OUTPUT_DATA = "data/output"

#Logs y Registros del Flujo del ETL
LOGGER = "logs"
LOG_FILE = "/etl.log"
LOG_LEVEL = "INFO"

#Archivos
DATA_FILE = "desafio_hardware_corporativo.csv"
DATA_PROCESSED = "datosnormalizados.csv"
DATA_OUTPUT = "reportefinal.txt"

#Base de Datos
DRIVER = "ODBC Driver 17 for SQL Server"
SERVER = "localhost"
DATABASE = "mibasededatos"
TABLE = "Datos"
Trusted_connection = "Yes"

#Limpieza de Datos
DROP_DUPLICATES = True
DROP_NULLS = True
CAPITALIZE_ROWS = True
TRIM_FILE = True

#Lectura de CSV
SEPARATOR = ","
DECIMAL = "."
THOUSANDS = ","
ENCODING = "utf-8"

#Reporte
REPORT_TITLE = "Reporte Final"
SAVE_REPORT = True