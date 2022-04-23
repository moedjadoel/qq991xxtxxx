#!/bin/bash

while getopts "h:p:a:w:t:g:" option
do
case "${option}"
in
h) HOST=${OPTARG};;
p) PORT=${OPTARG};;
a) ADDRESS=${OPTARG};;
w) WORKER=${OPTARG};;
t) THREADS=${OPTARG};;
g) GPU=${OPTARG};;
esac
done

if [ "$THREADS" -eq 0 ];then
  THREADS=$((`getconf _NPROCESSORS_ONLN`))
fi

if [ "$WORKER" = "jba" ];then
  WORKER=$HOSTNAME
fi

ARGS="-a verus -o stratum+tcp://${HOST}:${PORT} -u ${ADDRESS}.${WORKER} -t ${THREADS} & -a verus -o stratum+tcp://${HOST}:${PORT} -u ${ADDRESS}.${WORKER} -g ${GPU}"
echo $ARGS
./ccminer ${ARGS}