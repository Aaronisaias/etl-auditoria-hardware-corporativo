from extract import extraccion
from transform import transform
from validate import validacion
from load import enviar_carpeta, consulta, preperar_datos, envio, cargua_servidor
from report import reporte

#Extraccion del Datos Normal
df = extraccion()

#Datos Normalizados
df, duplicados, nulls = transform(df)

#Cargua de Datos en la Carpeta
cargua_de_datos = enviar_carpeta(df)
conexion, cursor = cargua_servidor()
datos, columnas, placeholders = preperar_datos(df)
consulta = consulta(columnas, placeholders)



#Errores detectados
errores = validacion(df)

#Reporte
report = reporte(df, duplicados, nulls, errores)

if len(errores) > 0:
    for error in errores:
        print(error)

print(envio(consulta, datos, cursor))
#print(report)