import datetime
import config
import logging
from pathlib import Path

def reporte(df, duplicados, nulls, errores):
    logging.info("Creando nuevo reporte...")
    estado = "Completado"
    reporte = f"""
    === Reporte Final ===
    Fecha:{datetime.datetime}
    Archivo Original:{config.DATA_FILE}
    Archivo Normalizado:{config.DATA_PROCESSED}
    Cantidad de Registros:{len(df)}
    Cantidad de Filas Eliminadas:{duplicados + nulls}
    Cantidad de Columnas:{df.shape[1]}
    Cantidad de Filas:{df.shape[0]}
    Estado:{estado}    
    === Reporte Finalizado ===
    """
    if len(errores) == 0:
        reporte += "\nNo se encontraron errores."
    else:
        reporte += "\nSe encontraron errores:"
        for err in errores:
            print(f"-{err}")
    
    ruta = Path(config.OUTPUT_DATA)/(config.DATA_OUTPUT)
    with open(ruta, "w", encoding="utf-8") as archivo:
        archivo.write(reporte)        
        logging.info("Reporte Final Finalizado")
    return ruta