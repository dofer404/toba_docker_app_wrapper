#!/bin/bash

if [ ! $ENTORNO_SETEADO ]; then
	$(dirname $0)/bd $(basename $0)
	exit $?
fi

LISTA_ARCHIVOS_INDIRECTO=$(cat $ARCHIVOS_INDIRECTO)
for la in $LISTA_ARCHIVOS_INDIRECTO; do
	LISTA_ARCHIVOS=$(cat $CARPETABD/$la)
	CARPETA_ARCHIVO=$(dirname $CARPETABD/$la)
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
done
