#! /bin/sh
exec 1>&1
exec 2>&1
exec 0>&1
set -v
set -x
date

################################################################################
# edit this section as desired to choose 
#   1) java version 
#   2) checkout directory
#   3) an open or closed build

JAVA_HOME=/export/gcm/where/jdk/1.7.0_72/x86_64.linux/bin
checkoutDir=/export/shared_build_wdc/users/lynn/opengem_dev_Jan15_editThis
#buildRoot=$checkoutDir                                  #  when build is not redirected to another location
buildRoot=/home/lynn/gemfireBuild/opengem_dev_Jan15_editThis    #  when build is redirected 

# choose to run open or closed 
# open
#buildType=open
#GEMFIRE=$buildRoot/$buildType/gemfire-assembly/build/install/gemfire

# closed
buildType=closed
GEMFIRE=$buildRoot/$buildType/pivotalgf-assembly/build/install/pivotal-gemfire

################################################################################


currDir=`pwd`
JTESTS=$buildRoot/closed/gemfire-test/build/resources/test  # tests are always closed
CLASSPATH=$JTESTS:$JTESTS/../../classes/test:$GEMFIRE/lib/gemfire-core-dependencies.jar
echo $GEMFIRE
echo $JTESTS
echo $CLASSPATH

# $1 (required) is the relative path to the bt file to run (example: "parReg/tx")
# $2 (required) is the name of the bt without the ".bt" extenstion (example" "prTx") 
# $3 (optional) is the specification for a local.conf (example: -Dlocal.conf=$currDir/local.conf)
runBT() {
   mkdir $2
   cp $3 $2/local.conf
   cd $2
   $JAVA_HOME/java -cp $CLASSPATH -DremovePassedTest=true -DprovideBugReportTemplate=true -DprovideRegressionSummary=true -DnukeHungTest=true -DJTESTS=$JTESTS -DGEMFIRE=$GEMFIRE -Dlocal.conf=$3 -DtestFileName=$JTESTS/$1/$2.bt -DnumTimesToRun=1 batterytest.BatteryTest
   cd $currDir
}

       
################################################################################
# Edit this section to choose bts and local.confs to run

#runBT "parReg/tx" "prTx" "$currDir/local.example.conf"
#runBT "parReg" "parRegPersist" 
runBT "pdx" "pdx" 

################################################################################
