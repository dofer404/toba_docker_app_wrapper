#!/bin/bash

HOST="pg"
PUERTO="5432"
CARPETAPROYECTO=`dirname $0`/../
PROYECTO=`cat $CARPETAPROYECTO/NOMBRE_PROYECTO`
BASEDEDATOS=`cat $CARPETAPROYECTO/NOMBRE_BASEDEDATOS`

echo " "
if [ $3 ]; then
   CARPETAPROYECTO="$3"
   echo "Info: Definido CARPETAPROYECTO = $CARPETAPROYECTO"
else
  if [ ! -d "$CARPETAPROYECTO" ]; then
    while [ ! -d "$CARPETAPROYECTO/" ]; do
      echo "Info: no se encontró "$CARPETAPROYECTO
      echo "Para finalizar presione Ctrl+C"
      read -p "Para continuar ingrese el nombre de su carpeta de proyecto: "
      CARPETAPROYECTO="$REPLY"
    done
  fi
fi

if [ $4 ]; then
   PROYECTO="$4"
   echo "Info: Definido proyecto = $PROYECTO"
fi

if [ $1 ]; then
   HOST="$1"
   echo "Info: Definido host = $HOST"
fi

if [ $2 ]; then
   PUERTO="$2"
   echo "Info: Definido puerto = $PUERTO"
fi

echo "Info: Se asume que el proyecto se encuentra en $CARPETAPROYECTO; host=$HOST; puerto=$PUERTO; proyecto=$PROYECTO"

echo " "
echo "Info: Si postgres te pide la contraseña una y otra vez, y querés que"
echo " pare de hacerlo, creá el archivo de texto ~/.pgpass"
echo " (con el  comando: gedit ~/.pgpass)"
echo " y dentro del archivo guardá la siguiente línea de texto:"
echo " localhost:5432:*:postgres:tucontraseña"
echo " "

echo -en "\rEjecutando script...                    "
echo " "

CARPETABD=$CARPETAPROYECTO/bd/
for a in bd_toba_crear.sql
do
  POSITIVO="si"
  NETGATIVO="no"
  echo " "
  echo "Info: Ejecutando archivo $CARPETABD$a"
  echo psql -q -h "$HOST" -p "$PUERTO" -U postgres -f "$CARPETABD$a" && EJECUTO=$NETGATIVO
  psql -q -h "$HOST" -p "$PUERTO" -U postgres -f "$CARPETABD$a" && EJECUTO=$POSITIVO
  if [ $EJECUTO = $POSITIVO ]; then
    echo "Ok $a"
  else
    echo "ERROR! $a; ver arriba."
  fi
done

echo ""
echo "Fin del script. Si hay errores arriba, corregirlos."
echo ""
