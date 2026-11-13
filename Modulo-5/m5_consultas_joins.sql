-- Módulo 5 - Consultas con JOINs para el proyecto
-- Base de datos: Ventas_Tech_DB
-- Motor: SQL Server
-- Fuente: modelo del Módulo 3 (Categorias, Clientes, Productos y Ventas)

USE Ventas_Tech_DB;

-- ============================================================
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Propósito: reunir en cada venta los datos del cliente,
-- producto, categoría y ciudad para el futuro dashboard.
-- ============================================================
SELECT
    v.IDVenta,
    v.FechaVenta,
    c.IDCliente,
    c.Nombre AS Cliente,
    c.Ciudad,
    p.IDProducto,
    p.NombreProducto AS Producto,
    ct.NombreCategoria AS Categoria,
    v.Cantidad,
    v.PrecioUnitario,
    v.Cantidad * v.PrecioUnitario AS TotalVenta
FROM dbo.Ventas AS v
INNER JOIN dbo.Clientes AS c
    ON v.IDCliente = c.IDCliente
INNER JOIN dbo.Productos AS p
    ON v.IDProducto = p.IDProducto
INNER JOIN dbo.Categorias AS ct
    ON p.IDCategoria = ct.IDCategoria
ORDER BY v.FechaVenta, v.IDVenta;

-- Hallazgo: Computación genera 4950 de los 6444 facturados (76,82%).
-- Es la categoría de mayor peso en las ventas registradas.


-- ============================================================
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Propósito: identificar clientes registrados sin compras
-- para que el área de CRM evalúe acciones de contacto.
-- ============================================================
SELECT
    c.Nombre AS Cliente,
    c.Email,
    c.FechaRegistro
FROM dbo.Clientes AS c
LEFT JOIN dbo.Ventas AS v
    ON c.IDCliente = v.IDCliente
WHERE v.IDVenta IS NULL;

-- Hallazgo: 0 de los 5 clientes registrados están sin compras.
-- CRM no identifica clientes a contactar por falta de una primera compra.


-- ============================================================
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Propósito: detectar productos del catálogo sin movimiento
-- para que el área de producto revise su comercialización.
-- ============================================================
SELECT
    p.NombreProducto AS Producto,
    ct.NombreCategoria AS Categoria,
    p.Precio
FROM dbo.Productos AS p
INNER JOIN dbo.Categorias AS ct
    ON p.IDCategoria = ct.IDCategoria
LEFT JOIN dbo.Ventas AS v
    ON p.IDProducto = v.IDProducto
WHERE v.IDVenta IS NULL;

-- Hallazgo: 0 de los 6 productos del catálogo están sin ventas.
-- El área de producto no detecta artículos sin movimiento en estos registros.


-- ============================================================
-- Consulta 4: Consolidado por origen (UNION ALL)
-- Propósito: comparar las ventas de dos períodos, creando
-- una etiqueta fija de origen en cada SELECT.
-- Nota: la columna Canal no existe en Ventas; sus valores
-- aquí identifican períodos, no canales comerciales reales.
-- ============================================================
SELECT
    Canal,
    SUM(Total) AS TotalCanal
FROM (
    SELECT
        v.FechaVenta,
        v.Cantidad * v.PrecioUnitario AS Total,
        '05 al 10 de marzo' AS Canal
    FROM dbo.Ventas AS v
    WHERE v.FechaVenta BETWEEN '2024-03-05' AND '2024-03-10'

    UNION ALL

    SELECT
        v.FechaVenta,
        v.Cantidad * v.PrecioUnitario AS Total,
        '11 al 15 de marzo' AS Canal
    FROM dbo.Ventas AS v
    WHERE v.FechaVenta BETWEEN '2024-03-11' AND '2024-03-15'
) AS Consolidado
GROUP BY Canal
ORDER BY TotalCanal DESC;

-- Hallazgo: Del 5 al 10 de marzo se facturaron 3620, frente a
-- 2824 del 11 al 15. El primer período tuvo mayor facturación.
