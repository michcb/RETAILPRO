--PREENTREGABLE 4

--CONSULTA 1--
SELECT 
MONTH(fecha_venta) AS MES,
COUNT(id_venta) AS Cantidad_pedidos,
SUM(cantidad * precio_unitario) AS Total_facturado,
AVG(cantidad * precio_unitario) AS Precio_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY MES ASC;

-- CONSULTA 2 --
SELECT TOP 5 id_producto,
SUM(cantidad) AS unidades_vendidas,
SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- CONSULTA 3 -- 
SELECT id_cliente,
COUNT(id_venta) AS cantidad_pedidos,
SUM(cantidad * precio_unitario) AS total_gastado
FROM  ventas
GROUP BY id_cliente
HAVING COUNT(id_venta) > 1
ORDER BY cantidad_pedidos DESC;

--CONSULTA 4--

WITH facturacion_mensual AS (
SELECT 
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY MONTH(fecha_venta)
)
SELECT mes,total_facturado,
CASE WHEN total_facturado >= (SELECT AVG(total_facturado) FROM facturacion_mensual) 
THEN 'Por encima'
ELSE 'Por debajo'
END AS rendimiento_mensual
FROM facturacion_mensual
ORDER BY mes ASC;


-- HALLAZGOS CLAVE DEL ANÁLISIS COMERCIAL:
-- 1. Concentración en producto estrella: El producto (id_producto = 1, Laptop Pro 15) 
-- lidera holgadamente el ranking de facturación, representando más del 40% del total 
-- generado en las ventas registradas gracias a su alto valor unitario.

-- 2. Fidelización de clientes: Múltiples clientes (como id_cliente = 1, 2, 3 y 5) presentan 
-- recurrencia con más de un pedido registrado, concentrando la mayor porción del 
-- volumen de transacciones del período analizado.

-- 3. Distribución mensual de facturación: Se observa estabilidad en la facturación mensual,
-- donde los picos de ventas coinciden con transacciones de productos de la categoría 
-- computación, impulsando el ticket promedio por encima de la media general.
