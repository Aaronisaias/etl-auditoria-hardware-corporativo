'Creacion de la Tabla Principal'
CREATE TABLE Datos (
ID_Transaccion INT,
Sucursal_ID INT,
Nombre_Sucursal VARCHAR(20),
Tipo_Equipo VARCHAR(30),
Precio_Unitario VARCHAR(20),
Unidades_Vendidas FLOAT,
Metodo_Pago VARCHAR(40),
Fecha_Factura VARCHAR(20),
Descuento_Aplicado FLOAT
)

'Modificando Tabla con los Datos Ingresados'
WITH NumerosOrdenados AS (
SELECT ID_Transaccion,Row_Number() OVER(ORDER BY(SELECT NULL)) AS Filas
FROM dbo.Datos
)

UPDATE NumerosOrdenados
SET ID_Transaccion = Filas

ALTER TABLE dbo.Datos
ADD CONSTRAINT PK_transaccion PRIMARY KEY (ID_Transaccion);

UPDATE dbo.Datos
SET Precio_Unitario = '500000.0'
WHERE Precio_Unitario = '$500000.0'

UPDATE dbo.Datos
SET Precio_Unitario = '15000.99'
WHERE Precio_Unitario = '$15000.99'

UPDATE dbo.Datos
SET Precio_Unitario = '200'
WHERE Precio_Unitario = '-200'

UPDATE dbo.Datos
SET Precio_Unitario = '1200.50'
WHERE Precio_Unitario = '$1,200.50'

UPDATE dbo.Datos
SET Unidades_Vendidas = '5'
WHERE Unidades_Vendidas = '5000'

UPDATE dbo.Datos
SET Unidades_Vendidas = '5'
WHERE Unidades_Vendidas = '-5'

UPDATE dbo.Datos
SET Descuento_Aplicado = 0.1
WHERE Descuento_Aplicado = 0.15

UPDATE dbo.Datos
SET Descuento_Aplicado = 1.0
WHERE Descuento_Aplicado = 1.5

UPDATE dbo.Datos
SET Descuento_Aplicado = 0.2
WHERE Descuento_Aplicado = -0.2

UPDATE dbo.Datos
SET Fecha_Factura = '15/05/2026'
WHERE Fecha_Factura = '2026-05-15'

UPDATE dbo.Datos
SET Fecha_Factura = '01/05/2026'
WHERE Fecha_Factura = '2026-05-01'

ALTER TABLE dbo.Datos
ALTER COLUMN Sucursal_ID INT

ALTER TABLE dbo.Datos
ALTER COLUMN Precio_Unitario FLOAT

ALTER TABLE dbo.Datos
ALTER COLUMN Unidades_Vendidas INT

ALTER TABLE dbo.Datos
ALTER COLUMN Descuento_Aplicado FLOAT

'Creacion de Tablas para Dividir Datos y Columnas'
CREATE TABLE Sucursal (
Sucursal_ID INT,
Nombre_Sucursal VARCHAR(25)
)

CREATE TABLE Equipamiento (
ID_Equipamiento INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Tipo VARCHAR(50),
Unidades INT
)

CREATE TABLE Precio (
ID_Precio INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Precio FLOAT,
Descuento FLOAT
)

CREATE TABLE Metodo_de_Pago (
ID_Metodo INT PRIMARY KEY NOT NULL IDENTITY(1,1),
Metodo VARCHAR(50),
Fecha_Factura VARCHAR(20)
)

'Ingresando Datos a las Tablas Divididas (Cada una, donde corresponde)'
INSERT INTO dbo.Equipamiento (Tipo, Unidades)
SELECT Tipo_Equipo, Unidades_Vendidas
FROM dbo.Datos

INSERT INTO dbo.Metodo_de_Pago (Metodo, Fecha_Factura)
SELECT Metodo_Pago, Fecha_Factura
FROM dbo.Datos

INSERT INTO dbo.Precio (Precio, Descuento)
SELECT Precio_Unitario, Descuento_Aplicado
FROM dbo.Datos

INSERT INTO dbo.Sucursal (Sucursal_ID, Nombre_Sucursal)
SELECT Sucursal_ID, Nombre_Sucursal
FROM dbo.Datos

ALTER TABLE dbo.Equipamiento
ADD Sucursal_ID INT;

ALTER TABLE dbo.Metodo_de_Pago
ADD Sucursal_ID INT;

ALTER TABLE dbo.Precio
ADD Sucursal_ID INT;

WITH Datos_de_otra_Tabla AS (
SELECT Sucursal_ID
FROM dbo.Datos
)

UPDATE dbo.Equipamiento
SET Sucursal_ID = dt.Sucursal_ID
FROM Datos_de_otra_Tabla dt

WITH Datos_de_otra_Tabla AS (
SELECT Sucursal_ID
FROM dbo.Datos
)

UPDATE dbo.Metodo_de_Pago
SET Sucursal_ID = dt.Sucursal_ID
FROM Datos_de_otra_Tabla dt

WITH Datos_de_otra_Tabla AS (
SELECT Sucursal_ID
FROM dbo.Datos
)

UPDATE dbo.Precio
SET Sucursal_ID = dt.Sucursal_ID
FROM Datos_de_otra_Tabla dt

USE mibasededatos;
GO

WITH NumerosOrdenados AS (
SELECT Sucursal_ID, ROW_NUMBER() OVER(ORDER BY(SELECT NULL)) AS Filas
FROM dbo.Sucursal
)

UPDATE NumerosOrdenados
SET Sucursal_ID = Filas

USE mibasededatos;
GO

WITH NumerosOrdenados AS (
SELECT Sucursal_ID, ROW_NUMBER() OVER(ORDER BY(SELECT NULL)) AS Filas
FROM dbo.Equipamiento
)

UPDATE NumerosOrdenados
SET Sucursal_ID = Filas

USE mibasededatos;
GO

WITH NumerosOrdenados AS (
SELECT Sucursal_ID, ROW_NUMBER() OVER(ORDER BY(SELECT NULL)) AS Filas
FROM dbo.Precio
)

UPDATE NumerosOrdenados
SET Sucursal_ID = Filas

USE mibasededatos;
GO

WITH NumerosOrdenados AS (
SELECT Sucursal_ID, ROW_NUMBER() OVER(ORDER BY(SELECT NULL)) AS Filas
FROM dbo.Metodo_de_Pago
)

UPDATE NumerosOrdenados
SET Sucursal_ID = Filas

USE mibasededatos;
GO

WITH NumerosOrdenados AS (
SELECT Sucursal_ID, ROW_NUMBER() OVER(ORDER BY(SELECT NULL)) AS Filas
FROM dbo.Datos
)

UPDATE NumerosOrdenados
SET Sucursal_ID = Filas

-- 1. Primero, obligamos a la columna a que no acepte nulos
ALTER TABLE dbo.Sucursal 
ALTER COLUMN Sucursal_ID INT NOT NULL;
GO

-- 2. Ahora sí, le agregamos la Llave Primaria sin errores
ALTER TABLE dbo.Sucursal
ADD CONSTRAINT PK_sucursal PRIMARY KEY (Sucursal_ID);

ALTER TABLE dbo.Equipamiento
ADD CONSTRAINT FK_sucursal_id
FOREIGN KEY (Sucursal_ID) REFERENCES dbo.Sucursal(Sucursal_ID)

ALTER TABLE dbo.Metodo_de_Pago
ADD CONSTRAINT FK_sucursal_idd
FOREIGN KEY (Sucursal_ID) REFERENCES dbo.Sucursal(Sucursal_ID)

ALTER TABLE dbo.Precio
ADD CONSTRAINT FK_sucursal_iddd
FOREIGN KEY (Sucursal_ID) REFERENCES dbo.Sucursal(Sucursal_ID)


'Analisis'
'Ingresos Netos Totales: 
¿Cuál es la facturación total real de la empresa aplicando 
correctamente los descuentos y descartando los outliers?'
WITH VentasCalculadas AS (
    SELECT 
        -- Cálculo real: (Unidades * Precio) por el porcentaje restante tras el descuento
        (e.Unidades * p.Precio) * (1 - p.Descuento) AS FacturacionReal
    FROM dbo.Equipamiento AS e
    JOIN dbo.Precio AS p ON e.Sucursal_ID = p.Sucursal_ID -- (Asegúrate de unir por el ID del producto o el campo relacional correcto)
    WHERE p.Precio BETWEEN 10 AND 5000 -- ⚠️ Filtro básico para descartar "outliers" (ajusta los rangos a tus datos)
)
SELECT 
    SUM(FacturacionReal) AS Ingresos_Totales_Reales
FROM VentasCalculadas;

'
Ingresos_Totales_Reales
80535,15
'

'Sucursal Líder: ¿Cuál es la sucursal corporativa que genera el mayor volumen de ingresos netos?'
SELECT s.Nombre_Sucursal, SUM(p.Precio*e.Unidades) AS Ingresos_Totales
FROM dbo.Sucursal s
JOIN dbo.Precio p ON s.Sucursal_ID = p.Sucursal_ID
JOIN dbo.Equipamiento e ON s.Sucursal_ID = e.Sucursal_ID
GROUP BY s.Nombre_Sucursal
ORDER BY Ingresos_Totales DESC

'
Nombre_Sucursal	   Ingresos_Totales
Sucursal centro	   7631306,93
Sucursal sur	   5053399,15
Sucursal norte	   3167839,9
Sucursal oeste	   163013,4
Sucursal este	   161429,9
'


'Producto Estrella: ¿Qué tipo de equipo informático es el más demandado por las empresas?'
SELECT Tipo, SUM(Unidades) AS Mas_Vendidos
FROM dbo.Equipamiento
GROUP BY Tipo
ORDER BY Mas_Vendidos DESC

'
Tipo	             Mas_Vendidos
Notebook enterprise	    129
Servidor blade	        72
Workstation pro	        39
Switch core	            32
'