#!/bin/bash

if [ ! $ENTORNO_SETEADO ]; then
	$(dirname $0)/bd $(basename $0)
	exit $?
fi

function ejecutar {
	POSITIVO="si"
  NETGATIVO="no"
  echo " "
  echo "Info: Ejecutando archivo $CARPETABD/$a"
  echo $COMANDO_PSQL -q -f "$CARPETABD/$a" $PARAM_NOMBREBASE && EJECUTO=$POSITIVO
  $COMANDO_PSQL -q -f "$CARPETABD/$a" $PARAM_NOMBREBASE && EJECUTO=$POSITIVO
  if [ $EJECUTO = $POSITIVO ]; then
    echo "Ok $a"
  else
    echo "ERROR! $a; ver arriba."
		exit 1
  fi
}

echo " "
echo "Creando la base de datos de la aplicación"

a=bd_app_crear.sql
PARAM_NOMBREBASE=
ejecutar

a=bd_app_crear_esquema.sql
PARAM_NOMBREBASE="$BASEDEDATOS"
ejecutar
