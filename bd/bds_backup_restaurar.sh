#!/bin/bash

if [ ! $ENTORNO_SETEADO ]; then
	$(dirname $0)/bd $(basename $0)
	exit $?
fi

if [ -f "$ARCHIVO_BACKUP_GZ" ];
then
  set -x
  gzip -d "$ARCHIVO_BACKUP_GZ"
  $CARPETABD/bd_app_crear.sh
  $COMANDO_PSQL --set ON_ERROR_STOP=off $BASEDEDATOS < $ARCHIVO_BACKUP_SUFIJO
  gzip $ARCHIVO_BACKUP_SUFIJO
  set +x
else
	echo "No existe $ARCHIVO_BACKUP_GZ"
fi

if [ -f "$ARCHIVO_BACKUP_TOBA_GZ" ];
then
  set -x
  gzip -d "$ARCHIVO_BACKUP_TOBA_GZ"
  $CARPETABD/bd_toba_crear.sh
  $COMANDO_PSQL --set ON_ERROR_STOP=off $BD_TOBA < $ARCHIVO_BACKUP_TOBA_SUFIJO
  gzip $ARCHIVO_BACKUP_TOBA_SUFIJO
  set +x
else
	echo "No existe $ARCHIVO_BACKUP_TOBA_GZ"
fi
