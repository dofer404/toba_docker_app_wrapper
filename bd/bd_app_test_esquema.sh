#!/bin/bash

if [ ! $ENTORNO_SETEADO ]; then
	$(dirname $0)/bd $(basename $0)
	exit $?
fi

INDARC="$CARPETABD/sql/test_esquema"
LISTA_ARCHIVOS=$(cat $INDARC)
CARPETA_ARCHIVO=$(dirname $INDARC)
for a in $LISTA_ARCHIVOS; do
	echo " "
	echo "Info: Ejecutando archivo $CARPETA_ARCHIVO/$a"
	EJECUTO="no"
	$COMANDO_PSQL -q -d $BASEDEDATOS -f "$CARPETA_ARCHIVO/$a" && EJECUTO="si"
	if [ $EJECUTO = "no" ]; then
		echo "ERROR! $CARPETA_ARCHIVO/$a; ver arriba."
	else
		echo "Ok $CARPETA_ARCHIVO/$a"
	fi
done
