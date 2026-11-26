-- Taller de Base de Datos - Ejercicios practicos
-- PostgreSQL
-- Ejecutar en una base de datos nueva (empresa_db).
-- Docker ejecuta este archivo automaticamente al iniciar por primera vez.

BEGIN;

-- =====================================================
-- 1. CREACION DE LOS 5 ESQUEMAS
-- =====================================================

CREATE SCHEMA ventas;
CREATE SCHEMA inventario;
CREATE SCHEMA personal;
CREATE SCHEMA compras;
CREATE SCHEMA servicios;

-- =====================================================
-- 2. CREACION DE TABLAS (4 POR CADA ESQUEMA)
-- =====================================================

-- ESQUEMA VENTAS

CREATE TABLE ventas.clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15)
);

CREATE TABLE ventas.productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(10,2) NOT NULL CHECK (precio >= 0)
);

CREATE TABLE ventas.ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT REFERENCES ventas.clientes(id_cliente),
    id_producto INT REFERENCES ventas.productos(id_producto),
    cantidad INT NOT NULL CHECK (cantidad > 0)
);

CREATE TABLE ventas.pagos (
    id_pago INT PRIMARY KEY,
    id_venta INT REFERENCES ventas.ventas(id_venta),
    monto NUMERIC(10,2) NOT NULL CHECK (monto >= 0),
    metodo VARCHAR(30) NOT NULL
);

-- ESQUEMA INVENTARIO

CREATE TABLE inventario.categorias (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL
);

CREATE TABLE inventario.almacenes (
    id_almacen INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL
);

CREATE TABLE inventario.articulos (
    id_articulo INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_categoria INT REFERENCES inventario.categorias(id_categoria)
);

CREATE TABLE inventario.existencias (
    id_existencia INT PRIMARY KEY,
    id_articulo INT REFERENCES inventario.articulos(id_articulo),
    id_almacen INT REFERENCES inventario.almacenes(id_almacen),
    cantidad INT NOT NULL CHECK (cantidad >= 0)
);

-- ESQUEMA PERSONAL

CREATE TABLE personal.departamentos (
    id_departamento INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL
);

CREATE TABLE personal.puestos (
    id_puesto INT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL
);

CREATE TABLE personal.empleados (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_departamento INT REFERENCES personal.departamentos(id_departamento),
    id_puesto INT REFERENCES personal.puestos(id_puesto)
);

CREATE TABLE personal.horarios (
    id_horario INT PRIMARY KEY,
    id_empleado INT REFERENCES personal.empleados(id_empleado),
    entrada TIME NOT NULL,
    salida TIME NOT NULL
);

-- ESQUEMA COMPRAS

CREATE TABLE compras.proveedores (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15)
);

CREATE TABLE compras.pedidos (
    id_pedido INT PRIMARY KEY,
    id_proveedor INT REFERENCES compras.proveedores(id_proveedor),
    fecha DATE NOT NULL
);

CREATE TABLE compras.facturas (
    id_factura INT PRIMARY KEY,
    id_pedido INT REFERENCES compras.pedidos(id_pedido),
    total NUMERIC(10,2) NOT NULL CHECK (total >= 0)
);

CREATE TABLE compras.entregas (
    id_entrega INT PRIMARY KEY,
    id_pedido INT REFERENCES compras.pedidos(id_pedido),
    fecha DATE NOT NULL,
    estado VARCHAR(30) NOT NULL
);

-- ESQUEMA SERVICIOS

CREATE TABLE servicios.servicios (
    id_servicio INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    costo NUMERIC(10,2) NOT NULL CHECK (costo >= 0)
);

CREATE TABLE servicios.tecnicos (
    id_tecnico INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(80) NOT NULL
);

CREATE TABLE servicios.solicitudes (
    id_solicitud INT PRIMARY KEY,
    id_servicio INT REFERENCES servicios.servicios(id_servicio),
    id_tecnico INT REFERENCES servicios.tecnicos(id_tecnico),
    estado VARCHAR(30) NOT NULL
);

CREATE TABLE servicios.reportes (
    id_reporte INT PRIMARY KEY,
    id_solicitud INT REFERENCES servicios.solicitudes(id_solicitud),
    descripcion VARCHAR(150) NOT NULL
);

-- =====================================================
-- 3. INSERTAR 5 REGISTROS EN CADA TABLA
-- Los datos son ficticios y se usan para la practica.
-- =====================================================

-- ESQUEMA VENTAS

INSERT INTO ventas.clientes (id_cliente, nombre, telefono) VALUES
    (1, 'Ana Lopez', '0000000001'),
    (2, 'Luis Perez', '0000000002'),
    (3, 'Maria Garcia', '0000000003'),
    (4, 'Carlos Ruiz', '0000000004'),
    (5, 'Elena Torres', '0000000005');

INSERT INTO ventas.productos (id_producto, nombre, precio) VALUES
    (1, 'Cuaderno', 35.00),
    (2, 'Lapiz', 8.00),
    (3, 'Carpeta', 45.00),
    (4, 'Pluma', 12.00),
    (5, 'Regla', 15.00);

INSERT INTO ventas.ventas (id_venta, id_cliente, id_producto, cantidad) VALUES
    (1, 1, 1, 2),
    (2, 2, 2, 5),
    (3, 3, 3, 1),
    (4, 4, 4, 3),
    (5, 5, 5, 2);

INSERT INTO ventas.pagos (id_pago, id_venta, monto, metodo) VALUES
    (1, 1, 70.00, 'Efectivo'),
    (2, 2, 40.00, 'Tarjeta'),
    (3, 3, 45.00, 'Efectivo'),
    (4, 4, 36.00, 'Transferencia'),
    (5, 5, 30.00, 'Tarjeta');

-- ESQUEMA INVENTARIO

INSERT INTO inventario.categorias (id_categoria, nombre) VALUES
    (1, 'Papeleria'),
    (2, 'Limpieza'),
    (3, 'Oficina'),
    (4, 'Electronica'),
    (5, 'Empaque');

INSERT INTO inventario.almacenes (id_almacen, nombre, ubicacion) VALUES
    (1, 'Almacen A', 'Zona norte'),
    (2, 'Almacen B', 'Zona sur'),
    (3, 'Almacen C', 'Zona este'),
    (4, 'Almacen D', 'Zona oeste'),
    (5, 'Almacen E', 'Zona centro');

INSERT INTO inventario.articulos (id_articulo, nombre, id_categoria) VALUES
    (1, 'Hojas blancas', 1),
    (2, 'Jabon', 2),
    (3, 'Engrapadora', 3),
    (4, 'Cable USB', 4),
    (5, 'Caja de carton', 5);

INSERT INTO inventario.existencias (id_existencia, id_articulo, id_almacen, cantidad) VALUES
    (1, 1, 1, 100),
    (2, 2, 2, 45),
    (3, 3, 3, 20),
    (4, 4, 4, 35),
    (5, 5, 5, 60);

-- ESQUEMA PERSONAL

INSERT INTO personal.departamentos (id_departamento, nombre) VALUES
    (1, 'Ventas'),
    (2, 'Inventario'),
    (3, 'Administracion'),
    (4, 'Compras'),
    (5, 'Servicios');

INSERT INTO personal.puestos (id_puesto, nombre) VALUES
    (1, 'Cajero'),
    (2, 'Almacenista'),
    (3, 'Auxiliar administrativo'),
    (4, 'Comprador'),
    (5, 'Tecnico');

INSERT INTO personal.empleados (id_empleado, nombre, id_departamento, id_puesto) VALUES
    (1, 'Pedro Ramos', 1, 1),
    (2, 'Laura Diaz', 2, 2),
    (3, 'Miguel Vega', 3, 3),
    (4, 'Sofia Cruz', 4, 4),
    (5, 'Jorge Luna', 5, 5);

INSERT INTO personal.horarios (id_horario, id_empleado, entrada, salida) VALUES
    (1, 1, '08:00', '16:00'),
    (2, 2, '07:00', '15:00'),
    (3, 3, '09:00', '17:00'),
    (4, 4, '08:00', '16:00'),
    (5, 5, '10:00', '18:00');

-- ESQUEMA COMPRAS

INSERT INTO compras.proveedores (id_proveedor, nombre, telefono) VALUES
    (1, 'Proveedor A', '0000000011'),
    (2, 'Proveedor B', '0000000012'),
    (3, 'Proveedor C', '0000000013'),
    (4, 'Proveedor D', '0000000014'),
    (5, 'Proveedor E', '0000000015');

INSERT INTO compras.pedidos (id_pedido, id_proveedor, fecha) VALUES
    (1, 1, '2026-11-10'),
    (2, 2, '2026-11-11'),
    (3, 3, '2026-11-12'),
    (4, 4, '2026-11-13'),
    (5, 5, '2026-11-14');

INSERT INTO compras.facturas (id_factura, id_pedido, total) VALUES
    (1, 1, 1500.00),
    (2, 2, 2300.00),
    (3, 3, 875.00),
    (4, 4, 1200.00),
    (5, 5, 3100.00);

INSERT INTO compras.entregas (id_entrega, id_pedido, fecha, estado) VALUES
    (1, 1, '2026-11-15', 'Recibido'),
    (2, 2, '2026-11-16', 'Recibido'),
    (3, 3, '2026-11-17', 'Recibido'),
    (4, 4, '2026-11-18', 'Pendiente'),
    (5, 5, '2026-11-19', 'Pendiente');

-- ESQUEMA SERVICIOS

INSERT INTO servicios.servicios (id_servicio, nombre, costo) VALUES
    (1, 'Mantenimiento', 350.00),
    (2, 'Instalacion', 250.00),
    (3, 'Revision', 150.00),
    (4, 'Configuracion', 200.00),
    (5, 'Soporte', 100.00);

INSERT INTO servicios.tecnicos (id_tecnico, nombre, especialidad) VALUES
    (1, 'Daniel Soto', 'Hardware'),
    (2, 'Paola Mora', 'Instalaciones'),
    (3, 'Andres Leon', 'Diagnostico'),
    (4, 'Diana Rios', 'Software'),
    (5, 'Hugo Silva', 'Soporte tecnico');

INSERT INTO servicios.solicitudes (id_solicitud, id_servicio, id_tecnico, estado) VALUES
    (1, 1, 1, 'Finalizada'),
    (2, 2, 2, 'Pendiente'),
    (3, 3, 3, 'En proceso'),
    (4, 4, 4, 'Finalizada'),
    (5, 5, 5, 'Pendiente');

INSERT INTO servicios.reportes (id_reporte, id_solicitud, descripcion) VALUES
    (1, 1, 'Mantenimiento realizado'),
    (2, 2, 'Instalacion programada'),
    (3, 3, 'Equipo en revision'),
    (4, 4, 'Configuracion terminada'),
    (5, 5, 'Solicitud recibida');

-- =====================================================
-- 4. CREACION DE 5 USUARIOS
-- Contrasenas de ejemplo, solo para el entorno de practica.
-- =====================================================

CREATE USER usuario_ventas WITH PASSWORD 'Ventas123';
CREATE USER usuario_inventario WITH PASSWORD 'Inventario123';
CREATE USER usuario_personal WITH PASSWORD 'Personal123';
CREATE USER usuario_compras WITH PASSWORD 'Compras123';
CREATE USER usuario_servicios WITH PASSWORD 'Servicios123';

-- =====================================================
-- 5. ASIGNACION DE PERMISOS
-- USAGE permite acceder al esquema, pero no concede por si
-- solo permisos para consultar o modificar sus tablas.
-- =====================================================

-- Permisos por esquema
GRANT USAGE ON SCHEMA ventas TO usuario_ventas;
GRANT USAGE ON SCHEMA inventario TO usuario_inventario;
GRANT USAGE ON SCHEMA personal TO usuario_personal;
GRANT USAGE ON SCHEMA compras TO usuario_compras;
GRANT USAGE ON SCHEMA servicios TO usuario_servicios;

-- Permisos de consulta en las 4 tablas de cada esquema
GRANT SELECT ON ALL TABLES IN SCHEMA ventas TO usuario_ventas;
GRANT SELECT ON ALL TABLES IN SCHEMA inventario TO usuario_inventario;
GRANT SELECT ON ALL TABLES IN SCHEMA personal TO usuario_personal;
GRANT SELECT ON ALL TABLES IN SCHEMA compras TO usuario_compras;
GRANT SELECT ON ALL TABLES IN SCHEMA servicios TO usuario_servicios;

-- Permisos adicionales por tabla y por accion

-- Ventas: puede insertar clientes, ventas y pagos.
GRANT INSERT ON ventas.clientes, ventas.ventas, ventas.pagos TO usuario_ventas;

-- Inventario: puede actualizar articulos y existencias.
GRANT UPDATE ON inventario.articulos, inventario.existencias TO usuario_inventario;

-- Personal: solo tiene permiso de consulta (SELECT).

-- Compras: puede insertar pedidos y entregas, y eliminar entregas.
GRANT INSERT ON compras.pedidos, compras.entregas TO usuario_compras;
GRANT DELETE ON compras.entregas TO usuario_compras;

-- Servicios: puede insertar y actualizar solicitudes y reportes.
-- Tambien puede eliminar reportes.
GRANT INSERT, UPDATE ON servicios.solicitudes, servicios.reportes TO usuario_servicios;
GRANT DELETE ON servicios.reportes TO usuario_servicios;

COMMIT;

-- =====================================================
-- 6. CONSULTAS DE COMPROBACION (OPCIONALES)
-- Quitar los dos guiones de la consulta que quieras probar.
-- =====================================================

-- SELECT schema_name FROM information_schema.schemata
-- WHERE schema_name IN ('ventas', 'inventario', 'personal', 'compras', 'servicios');

-- SELECT table_schema, COUNT(*) AS total_tablas
-- FROM information_schema.tables
-- WHERE table_schema IN ('ventas', 'inventario', 'personal', 'compras', 'servicios')
-- AND table_type = 'BASE TABLE'
-- GROUP BY table_schema ORDER BY table_schema;

-- SELECT rolname FROM pg_roles
-- WHERE rolname IN ('usuario_ventas', 'usuario_inventario', 'usuario_personal', 'usuario_compras', 'usuario_servicios');

-- SELECT * FROM ventas.clientes;
-- SELECT * FROM inventario.existencias;
-- SELECT * FROM personal.empleados;
-- SELECT * FROM compras.pedidos;
-- SELECT * FROM servicios.reportes;

-- SELECT grantee, table_schema, table_name, privilege_type
-- FROM information_schema.role_table_grants
-- WHERE grantee IN ('usuario_ventas', 'usuario_inventario', 'usuario_personal', 'usuario_compras', 'usuario_servicios')
-- ORDER BY grantee, table_name, privilege_type;
