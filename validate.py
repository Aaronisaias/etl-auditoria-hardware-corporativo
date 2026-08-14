import logging
import config

logging.info("Iniciando Validacion...")
def validacion(df):
    errores = []
    columnas_obligatorias = ["Nombre completo", "Nombre", "Apellido", "Edad", "ID"]
    
    #¿Existen esas Columnas?
    for colm in columnas_obligatorias:
        if colm not in df.columns:
            errores.append(f"La Columna '{colm}' no se encuentra en la Tabla")
            logging.warning(f"No se Encontro la Columna '{colm}' en la Tabla")
    
    #Validar Edades
    if "Edad" in df.columns:
        if (df["Edad"] <= 0):
            errores.append("Se encontro una Edad Erronea en la Columna de 'Edad'")
            logging.warning("Se encontro una Edad Erronea en la Columna de 'Edad'")
    
    #Validar Valores NULLOS
    if config.DROP_NULLS == False:
        if df.isnull().sum() > 0:
            errores.append("Se encontro Valores Nulos en la Tabla")
            logging.warning("Se encontraron Valores Nulos dentro de la Tabla")
    return errores

logging.info("Ha finalizado el Proceso de Validacion de Datos")