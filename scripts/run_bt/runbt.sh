#! /bin/bash 
#set -e

# ----
# Following values are customized by redirect.pl
# ----

. ./setup.sh

BT=batt.bt
if [ "$1" != "" ]; then
  BT="$1"
fi
echo "BT=$BT"
CONF=./local.conf
if [ "$2" != "" ]; then
  CONF="$2"
fi
echo "local.conf=$CONF"

TEST_BASE=$OBJ_BASE/tests
TOP=$TEST_BASE/results

exec 1>&1
exec 2>&1
exec 0>&1
#set -v
#set -x
date

nuke=-DnukeHungTest=true

rm -f oneliner.txt
rm -f batterytest.log
$JDK/bin/java \
  $nuke \
  -Djava.library.path=$OBJ_BASE/hidden/lib \
  -DlocalConf=$CONF \
  -DJTESTS=$JTESTS \
  -DGEMFIRE=$GEMFIRE \
  -DtestFileName=$BT \
  -DmoveRemoteDirs=true \
  -Dtests.results.dir=$OBJ_BASE/tests/results \
  -Dbt.result.dir=$OBJ_BASE/tests/results \
  -DnumTimesToRun=1 batterytest.BatteryTest

  #-DremovePassedTest=true \
