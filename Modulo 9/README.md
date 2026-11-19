RetailPro: Proyecto de Data Analytics

Descripción del proyecto
RetailPro es un proyecto de análisis de datos sobre las ventas de una empresa comercial. Busca responder preguntas concretas del negocio: qué productos y categorías generan más ingresos, cómo se distribuyen las ventas entre clientes y ciudades y qué información puede ayudar a mejorar las decisiones comerciales.
El proyecto comprende la creación de una base de datos relacional, el desarrollo de consultas SQL y la preparación de información para su posterior análisis y visualización.

Herramientas utilizadas
•	SQL Server: creación y gestión de la base de datos Ventas_Tech_DB.
•	SQL Server Management Studio (SSMS): ejecución de scripts y consultas SQL.
•	Power BI: transformación, modelado y visualización de datos.
•	GitHub: almacenamiento y documentación de los archivos del proyecto.

Archivos SQL del proyecto
•	Módulo 3 — Ventas_Tech_DB.sql: creación de la base de datos y sus tablas, definición de relaciones y carga inicial de registros.
•	Módulo 4 — m4_consultas_negocio.sql: consultas para obtener un resumen mensual de ventas, ranking de productos, clientes recurrentes y comparación de facturación por producto.
•	Módulo 5 — m5_consultas_joins.sql: consultas con INNER JOIN y LEFT JOIN para reunir los datos de ventas, clientes, productos y categorías e identificar registros sin compras o ventas. También utiliza UNION ALL para comparar la facturación de dos períodos de marzo de 2024; estas etiquetas indican períodos, no canales de venta.

Cómo ejecutar los scripts SQL
1.	Instalar SQL Server y SQL Server Management Studio (SSMS).
2.	Abrir SSMS y conectarse al servidor SQL.
3.	Abrir y ejecutar el archivo Ventas_Tech_DB.sql del Módulo 3 para crear la base de datos y cargar los registros.
4.	Abrir los archivos m4_consultas_negocio.sql y m5_consultas_joins.sql.
5.	Verificar que esté seleccionada la base de datos Ventas_Tech_DB.
6.	Ejecutar las consultas mediante el botón Ejecutar o la tecla F5 y revisar sus resultados.
   
Validación básica de resultados
Con los datos cargados en el Módulo 3, la consulta de resumen mensual del Módulo 4 debe mostrar 10 pedidos de marzo de 2024, una facturación total de 6.444 y un ticket promedio de 644,40.
En el ranking de productos, el ID 1 debe aparecer primero, con 3 unidades vendidas y 3.600 de facturación.
Estos valores sirven como controles para detectar posibles errores al ejecutar los scripts.
Objetivo final
Integrar los datos obtenidos mediante SQL en Power BI para construir un dashboard que permita analizar indicadores comerciales, identificar patrones de ventas y contribuir a la toma de decisiones de RetailPro.

