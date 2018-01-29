#!/bin/bash

if [ ! $ENTORNO_SETEADO ]; then
	$(dirname $0)/bd $(basename $0)
	exit $?
fi

for a in bd_toba_crear.sql
do
  POSITIVO="si"
  NETGATIVO="no"
  echo " "
  echo "Info: Ejecutando archivo $CARPETABD$a"
  echo $COMANDO_PSQL -q -f "$CARPETABD$a" && EJECUTO=$NETGATIVO
  $COMANDO_PSQL -q -f "$CARPETABD$a" && EJECUTO=$POSITIVO
  if [ $EJECUTO = $POSITIVO ]; then
    echo "Ok $a"
  else
    echo "ERROR! $a; ver arriba."
  fi
done

echo ""
echo "Fin del script. Si hay errores arriba, corregirlos."
echo ""
