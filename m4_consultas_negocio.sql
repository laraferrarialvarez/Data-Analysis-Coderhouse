--- Extrayendo métricas claves de SQL a partir de consultas de negocio 

--- Utilizamos la base de datos creada en el Módulo 3
USE Ventas_Tech_DB;
--- Verificamos que la tabla Ventas, que es la que utilizaremos, se encuentre correctamente cargada
SELECT * FROM Ventas

--- Consulta 1: Resumen ejecutivo mensual 
SELECT
    MONTH(FechaVenta) AS Mes,
    SUM(Cantidad * PrecioUnitario) AS TotalFacturado,
    COUNT(*) AS CantidadPedidos,
    AVG(Cantidad * PrecioUnitario) AS TicketPromedio
FROM Ventas
GROUP BY MONTH(FechaVenta);

--- Consulta 2: Ranking de productos 
SELECT TOP 5
    IDProducto,
    SUM(Cantidad) AS UnidadesVendidas,
    SUM(Cantidad * PrecioUnitario) AS TotalFacturado
FROM Ventas
GROUP BY IDProducto
ORDER BY TotalFacturado DESC;

--- Consulta 3 — Clientes recurrentes 
SELECT
    IDCliente,
    COUNT(*) AS CantidadPedidos,
    SUM(Cantidad * PrecioUnitario) AS TotalGastado
FROM Ventas
GROUP BY IDCliente
HAVING COUNT(*) > 1
ORDER BY CantidadPedidos DESC;

--- Consulta 4: Productos por encima/por debajo del promedio

;WITH FacturacionPorProducto AS (
    SELECT
        IDProducto,
        SUM(Cantidad * PrecioUnitario) AS TotalFacturado
    FROM Ventas
    GROUP BY IDProducto
)
SELECT
    IDProducto,
    TotalFacturado,
    CASE
        WHEN TotalFacturado >= (
            SELECT AVG(TotalFacturado * 1.0)
            FROM FacturacionPorProducto
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS ComparacionPromedio
FROM FacturacionPorProducto
ORDER BY TotalFacturado DESC;


-- Hallazgos obtenidos de las consultas:

-- 1. Durante marzo de 2024 se registraron 10 pedidos,
--    con una facturación total de $6.444 y un ticket
--    promedio de $644,40. Los 5 clientes realizaron
--    2 pedidos cada uno.

-- 2. El producto con ID 1 fue el que generó la mayor
--    facturación, alcanzando $3.600, lo que representa
--    aproximadamente el 55,87% de la facturación total.

-- 3. De los 6 productos analizados, solamente 2
--    (ID 1 e ID 3) superaron el promedio de facturación
--    por producto, que fue de $1.074. Los otros 4
--    productos quedaron por debajo de ese promedio.















