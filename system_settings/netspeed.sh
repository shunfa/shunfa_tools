#!/bin/ksh
# SCRIPT:
INTERFACE=$1
while true
do
  integer AVG=0
  integer INITTRR=`cat /proc/net/dev|grep ${INTERFACE}|awk '{print $1}'|awk -F":" '{print $2}'`
  sleep 5
  integer ENDTRR=`cat /proc/net/dev|grep ${INTERFACE}|awk '{print $1}'|awk -F":" '{print $2}'`
  integer AVG=${ENDTRR}-${INITTRR}
  integer RESULT=$AVG/5/1024
  echo $RESULT KB/s
done
