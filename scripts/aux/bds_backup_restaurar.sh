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

set -x
gzip -d $DIRBK/$ARCHIVO.backup.gz
$DIRBD/bd_app_crear.sh
psql -h $HOST -U postgres --set ON_ERROR_STOP=off $BASEDEDATOS < $DIRBK/$ARCHIVO.backup
gzip $DIRBK/$ARCHIVO.backup

gzip -d $DIRBK/$ARCHIVO_TOBA.backup.gz
$DIRBD/bd_toba_crear.sh
psql -h $HOST -U postgres --set ON_ERROR_STOP=off $BD_TOBA < $DIRBK/$ARCHIVO_TOBA.backup
gzip $DIRBK/$ARCHIVO_TOBA.backup
set +x
