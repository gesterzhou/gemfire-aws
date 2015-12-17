#! /bin/bash
exec 1>&1
exec 2>&1
exec 0>&1
#set -v
#set -x
date
##
rm batterytest.log
rm oneliner.txt
rm summ*.txt

################################################################################
# edit this section as desired to choose 
#   1) java version 
#   2) checkout directory
#   3) an open or closed build

JAVA_HOME=/usr/java/jdk1.8.0_45
checkoutDir=/home/gfadmin/git/gemfire
#buildRoot=$checkoutDir    #  when build is not redirected to another location
buildRoot=$checkoutDir     #  when build is redirected 

# choose to run open or closed 
# open
#buildType=open
#GEMFIRE=$buildRoot/$buildType/gemfire-assembly/build/install/geode

# closed
buildType=closed
GEMFIRE=$buildRoot/$buildType/pivotalgf-assembly/build/install/pivotal-gemfire

################################################################################

PATH=$JAVA_HOME/bin:$PATH
JTESTS=$buildRoot/closed/gemfire-test/build/resources/test
CLASSPATH=$JTESTS:$JTESTS/../../classes/test:$GEMFIRE/lib/gemfire-core-dependencies.jar:$JTESTS/../extraJars/groovy-all-2.4.3.jar
echo $JAVA_HOME
echo $GEMFIRE
echo $JTESTS
echo $CLASSPATH

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

java -cp $CLASSPATH \
  -DRELEASE_DIR=/export/gcm/where/gemfire/releases \
  -DprovideBugReportTemplate=true \
  -DprovideRegressionSummary=true \
  -DlocalConf=$CONF \
  -DmoveRemoteDirs=true \
  -DnukeHungTest=true \
  -DJTESTS=$JTESTS \
  -DGEMFIRE=$GEMFIRE \
  -DtestFileName=$BT \
  -DnumTimesToRun=1 batterytest.BatteryTest

  #-DremovePassedTest=true \

