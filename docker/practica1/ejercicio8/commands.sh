#!/bin/bash

# EJERCICIO 8: Variables de entorno
# 1. Construye la imagen
# 2. Ejecuta el contenedor SIN variables de entorno
# 3. Observa el error en los logs
# 4. Ejecuta correctamente el contenedor pasando las variables de entorno necesarias
# 5. Verifica que funciona

#  Tarea 1: Construye la imagen

echo "TAREA 1: CONSTRUIR LA IMAGEN"
echo ""

docker build -t alraro/ips-pr1-ej8:1.0.0 --push .

echo ""

#  Tarea 2 y 3: Ejecuta el contenedor SIN variables de entorno

echo "TAREA 2 y 3: EJECUTAR EL CONTENEDOR SIN VARIABLES DE ENTORNO"
echo ""

docker run --name env-test-no-vars -d --rm alraro/ips-pr1-ej8:1.0.0

timeout 5 docker logs -f env-test-no-vars

docker stop env-test-no-vars 1> /dev/null 2> /dev/null
echo "Contenedor de prueba sin variables de entorno detenido."
echo ""

# Tarea 3 y 4: Ejecuta correctamente el contenedor pasando las variables de entorno necesarias

echo "TAREA 3 y 4: EJECUTAR EL CONTENEDOR CON VARIABLES DE ENTORNO"
echo ""

docker run --name ev-test-with-vars -d --rm -e "DB_HOST=localhost" -e "DB_USER=foo" -e "DB_PASSWORD=bar" -e "DB_PORT=5432" alraro/ips-pr1-ej8:1.0.0

timeout 5 docker logs -f ev-test-with-vars

docker stop ev-test-with-vars 1> /dev/null 2> /dev/null
echo "Contenedor de prueba con variables de entorno detenido."
echo ""

echo "Todas las tareas completadas."