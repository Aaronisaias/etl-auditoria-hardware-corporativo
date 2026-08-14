import logging
import pyodbc
import config
from pathlib import Path

logging.info("Iniciando proceso de Cargua")
def cargua_servidor():
    logging.info("Intentando conectar con SQL...")
    try:
        conexion = pyodbc.connect(f"""
            DRIVER={config.DRIVER};
            SERVER={config.SERVER};
            DATABASE={config.DATABASE};
            Trusted_connection={config.Trusted_connection};
            """
        )
        logging.info("SQL Conectado Correctamente")
        cursor = conexion.cursor()
        return conexion, cursor
    except ConnectionError:
        logging.warning("Falla al Hora de Carguar la conexion con SQL")
        
def consulta(columnas, placeholders):
        consulta = f"""INSERT INTO dbo.{config.TABLE}({columnas})
        VALUES({placeholders})"""
        return consulta
    
def preperar_datos(df):
    columnas = ", ".join(df.columns)
    placeholders = ", ".join(["?"] * len(df.columns))
    datos = list(df.itertuples(index=False,name=None))
    return datos, columnas, placeholders
    
def envio(consulta, datos, cursor):
    try:
       cursor.executemany(consulta, datos)
       cursor.commit()
       cursor.close()
       logging.info("Datos Enviados con Exito a SQL Server")
       return "Datos Enviados con Exito a SQL Server"
    except SystemError:
       print("Fallo al Enviar datos a SQL Server")
       logging.warning("Fallo al Enviar datos a SQL Server")
    
def enviar_carpeta(df):
    ruta = Path(config.PROCESSED_DATA)/("Datos_Limpios.csv")
    df.to_csv(ruta, index=False)