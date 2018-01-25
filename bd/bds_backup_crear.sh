#!/bin/bash

if [ ! $ENTORNO_SETEADO ]; then
	$(dirname $0)/bd $(basename $0)
	exit $?
fi

if [ ! -d "$DIRBK" ]; then
	echo "set -x"
	set -x
	mkdir "$DIRBK"
	set +x
fi

echo "Creando backups:"
echo " $ARCHIVO_BACKUP_GZ"
$COMANDO_PGDUMP $BASEDEDATOS > $ARCHIVO_BACKUP_SUFIJO
gzip $ARCHIVO_BACKUP_SUFIJO

echo " $ARCHIVO_BACKUP_TOBA_GZ"
$COMANDO_PGDUMP $BD_TOBA > $ARCHIVO_BACKUP_TOBA_SUFIJO
gzip $ARCHIVO_BACKUP_TOBA_SUFIJO
echo ""
