#!/bin/bash

if [ ! $ENTORNO_SETEADO ]; then
	$(dirname $0)/bd $(basename $0)
	exit $?
fi

if [ -f "$ARCHIVO_BACKUP.gz" ];
then
  set -x
  gzip -d "$ARCHIVO_BACKUP.gz"
  $CARPETABD/bd_app_crear.sh
  $COMANDO_PSQL --set ON_ERROR_STOP=off $BASEDEDATOS < $ARCHIVO_BACKUP
  gzip $ARCHIVO_BACKUP
  set +x
fi

if [ -f "$ARCHIVO_BACKUP_TOBA.gz" ];
then
  set -x
  gzip -d "$ARCHIVO_BACKUP_TOBA.gz"
  $CARPETABD/bd_toba_crear.sh
  $COMANDO_PSQL --set ON_ERROR_STOP=off $BD_TOBA < $ARCHIVO_BACKUP_TOBA
  gzip $ARCHIVO_BACKUP_TOBA
  set +x
fi
