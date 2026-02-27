#!/bin/bash

# Ejercicio 6: Docker Compose
# 1. Ejecuta un contenedor de Nginx limitando su memoria a 128MB
# 2. Ejecuta otro contenedor limitando CPU (0.5 cores) y memoria (256MB)
# 3. Prueba a forzar el límite de memoria ejecutando un contenedor que duplique una cadena de texto
# continuamente hasta quedarse sin memoria
# 4. Prueba a crear un contenedor que consuma CPU continuamente con el límite de 0.5 cores y observa su
# uso con docker stats
# 5. Monitoriza el uso de recursos en tiempo real
# 6. Ejecuta un contenedor que se reinicie automáticamente si falla (usa --restart=always)
# 7. Observa el reinicio automático del contenedor anterior
# 8. Inspecciona la configuración del contenedor


#  Tarea 1: Ejecuta un contenedor de Nginx limitando su memoria a 128MB

TIMEOUT=10

echo "TAREA 1: MEMORIA LIMITADA A 128MB"
echo ""

docker run --name nginx-limited -d --memory=128m -p 8080:80 nginx:1.29.5-alpine

echo "Nginx se está ejecutando con memoria limitada a 128MB. Accede a http://localhost:8080 para verificar, tienes $TIMEOUT segundos."


while [ $TIMEOUT -gt 0 ]; do
    echo -n "Tiempo restante: $TIMEOUT segundos..." $'\r'
    sleep 1
    ((TIMEOUT--))
done

echo "Tiempo agotado. Deteniendo y eliminando el contenedor de Nginx."

docker stop nginx-limited 1> /dev/null 2> /dev/null
docker rm nginx-limited 1> /dev/null 2> /dev/null
echo "Contenedor de Nginx detenido y eliminado."

echo ""

#  Tarea 2: Ejecuta otro contenedor limitando CPU (0.5 cores) y memoria (256MB)

TIMEOUT=12

echo "TAREA 2: CPU LIMITADA A 0.5 CORES Y MEMORIA LIMITADA A 256MB"
echo ""

docker run --name nginx-cpu-mem-limited --rm -d --cpus="0.5" --memory=256m -p 8080:80 nginx:1.29.5-alpine

echo "Nginx se está ejecutando con CPU limitada a 0.5 cores y memoria limitada a 256MB. Accede a http://localhost:8080 para verificar, tienes $TIMEOUT segundos."

while [ $TIMEOUT -gt 0 ]; do
    echo -n "Tiempo restante: $TIMEOUT segundos..." $'\r'
    sleep 1
    ((TIMEOUT--))
done

echo "Tiempo agotado. Deteniendo y eliminando el contenedor de Nginx."

docker stop nginx-cpu-mem-limited 1> /dev/null 2> /dev/null
echo "Contenedor de Nginx detenido y eliminado."
echo ""

#  Tarea 3: Forzar el límite de memoria ejecutando un contenedor que duplique una cadena de texto continuamente hasta quedarse sin memoria

echo "TAREA 3: FORZAR LÍMITE DE MEMORIA"
echo ""

docker run --name memory-tester --rm --memory=100m --memory-swap=100m busybox sh -c "i=0; a='x'; while true; do a=\$a\$a; i=\$((i+1)); echo Iter \$i; done"

docker wait memory-tester

echo "Contenedor de prueba de memoria ha terminado debido a la limitación de memoria."
sleep 8

echo ""

#  Tarea 4 y 5: Crear un contenedor que consuma CPU continuamente con el límite de 0.5 cores y observar su uso con docker stats

TIMEOUT=30

echo "TAREA 4 y 5: CONSUMO DE CPU CON LÍMITE DE 0.5 CORES"
echo ""

docker run --name cpu-tester -d --rm --cpus=0.5 busybox sh -c "while true; do :; done"

timeout 8 docker stats

docker stop cpu-tester 1> /dev/null 2> /dev/null
echo "Contenedor de prueba de CPU detenido."
echo ""

#  Tarea 6 y 7: Ejecutar un contenedor que se reinicie automáticamente si falla (usa --restart=always) y observar el reinicio automático

TIMEOUT=12

echo "TAREA 6 y 7: REINICIO AUTOMÁTICO DE CONTENEDOR"
echo ""

docker run -d --name test-restart --restart=always busybox sh -c "sleep 5 && exit 1"

while [ $TIMEOUT -gt 0 ]; do
    clear
    echo "Estado del contenedor test-restart:"
    docker ps -a --filter "name=test-restart"
    echo ""
    sleep 1
    ((TIMEOUT--))
done

#  Tarea 8: Inspeccionar la configuración del contenedor
clear
echo "TAREA 8: INSPECCIONAR CONFIGURACIÓN DEL CONTENEDOR"
echo ""

docker inspect test-restart

echo ""

docker stop test-restart 1> /dev/null 2> /dev/null
docker rm test-restart 1> /dev/null 2> /dev/null
echo "Contenedor de prueba de reinicio detenido."
echo ""

echo "Todas las tareas completadas."