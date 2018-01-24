#!/bin/bash

if [ ! $ENTORNO_SETEADO ]; then
	$(dirname $0)/bd $(basename $0)
	exit $?
fi

$COMANDO_PGDUMP $BASEDEDATOS > $DIRBK/$ARCHIVO.backup
gzip $DIRBK/$ARCHIVO.backup

$COMANDO_PGDUMP $BD_TOBA > $DIRBK/$ARCHIVO_TOBA.backup
gzip $DIRBK/$ARCHIVO_TOBA.backup
