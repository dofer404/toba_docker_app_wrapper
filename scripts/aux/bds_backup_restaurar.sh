#!/bin/bash

DIRBD=`dirname $0`;
CARPETAPROYECTO=$DIRBD/../
DIRBK=$DIRBD/backup/

PROYECTO=`cat $CARPETAPROYECTO/NOMBRE_PROYECTO`
BASEDEDATOS=`cat $CARPETAPROYECTO/NOMBRE_BASEDEDATOS`
BD_TOBA="<NOMBRE BASEDEDATOSTOBA>";
HOST="pg";

ARCHIVO="backup"
ARCHIVO_TOBA="backup_toba"

ARCHIVO_BACKUP=$DIRBK/$ARCHIVO.backup
ARCHIVO_BACKUP_TOBA=$DIRBK/$ARCHIVO_TOBA.backup

if [ -f "$ARCHIVO_BACKUP.gz" ];
then
  set -x
  gzip -d "$ARCHIVO_BACKUP.gz"
  $DIRBD/bd_app_crear.sh
  psql -h $HOST -U postgres --set ON_ERROR_STOP=off $BASEDEDATOS < $ARCHIVO_BACKUP
  gzip $ARCHIVO_BACKUP
  set +x
fi

if [ -f "$ARCHIVO_BACKUP_TOBA.gz" ];
then
  set -x
  gzip -d "$ARCHIVO_BACKUP_TOBA.gz"
  $DIRBD/bd_toba_crear.sh
  psql -h $HOST -U postgres --set ON_ERROR_STOP=off $BD_TOBA < $ARCHIVO_BACKUP_TOBA
  gzip $ARCHIVO_BACKUP_TOBA
  set +x
fi
