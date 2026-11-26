# Ejercicios prácticos de PostgreSQL

**Alumno:** Rafael Azamar Mendoza  
**Materia:** Taller de Base de Datos

## Descripción

En esta práctica se crea una base de datos de una empresa utilizando PostgreSQL. Se trabaja con esquemas, tablas, registros, usuarios y permisos de acceso.

- 5 esquemas: compras, inventario, personal, servicios y ventas.
- 4 tablas por esquema (20 tablas en total).
- 5 registros por tabla (100 registros en total).
- 5 usuarios con permisos de consulta, inserción, actualización y eliminación según sus funciones.

## Archivos

- `ejercicios_practicos.sql`: script que contiene todos los ejercicios.
- `docker-compose.yml`: configuración para crear la base de datos en Docker.

## Ejecución

1. Tener Docker Desktop o Docker con Compose instalado y en funcionamiento.
2. Abrir una terminal en la carpeta donde se encuentran los dos archivos.
3. Ejecutar:

   ```bash
   docker compose up -d
   ```

4. Comprobar que el contenedor está funcionando:

   ```bash
   docker compose ps
   ```

El script SQL se ejecuta automáticamente durante la primera inicialización de la base de datos con un volumen nuevo. No es necesario ejecutarlo otra vez desde DBeaver.

## Conexión en DBeaver

| Dato | Valor |
| --- | --- |
| Motor | PostgreSQL 16 |
| Host | localhost |
| Puerto | 55432 |
| Base de datos | empresa_db |
| Usuario | postgres |
| Contraseña | Practica123 |

Las contraseñas incluidas son únicamente para este entorno de práctica local. No deben reutilizarse en sistemas reales.

## Comprobación

El proyecto se probó con Docker Desktop y DBeaver. Se comprobó la creación de los cinco esquemas, las veinte tablas, los cien registros y los cinco usuarios, así como los permisos de acceso y las operaciones SELECT, INSERT, UPDATE y DELETE.

Para detener el contenedor sin borrar los datos:

```bash
docker compose down
```
