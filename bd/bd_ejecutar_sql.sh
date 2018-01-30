#!/bin/bash

if [ ! $ENTORNO_SETEADO ]; then
	$(dirname $0)/bd $(basename $0) "" "" "$1" "$2"
	exit $?
fi

function ejecutar {
	POSITIVO="si"
  NETGATIVO="no"
  echo "Info: Ejecutando '$a' contra bd '$PARAM_NOMBREBASE'"
  echo "$COMANDO_PSQL -q -f '$a' $PARAM_NOMBREBASE"
	echo ""
  $COMANDO_PSQL -q -f "$a" $PARAM_NOMBREBASE && EJECUTO=$POSITIVO
	echo ""
  if [ $EJECUTO = $POSITIVO ]; then
    echo "Ok $a"
  else
    echo "ERROR! $a; ver arriba."
		exit 1
  fi
}

PARAM_NOMBREBASE=$1
a=$2
ejecutar
exit $?
