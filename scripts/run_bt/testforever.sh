#!/bin/bash
testfile=$1
testcase=$2
greppattern=$3
if [ "$testcase" = "" ]; then
    echo "Usage: testforever.sh testX.bt testcase greppattern"
    exit 1
fi
while [ 1 -eq 1 ]
do
./runbt.sh ${testfile}

num=`ls ${testcase}*/errors.txt | wc -l`
if [ $num -ne 0 ]; then
  date >> merged_errors.txt
  cat ${testcase}*/errors.txt >> merged_errors.txt
  if [ "$greppattern" != "" ]; then
    #grep "${greppattern}" ${testcase}*/errors.txt
    grep "${greppattern}" ${testcase}*/*.log ${testcase}*/*/*.log
    if [ $? -eq 0 ]; then
      ${testcase}*/nukerun.sh
      break
    else
      ${testcase}*/nukerun.sh
      grep GGG ${testcase}*/*/*.log > a1; wc -l a1
      echo "deleting..."
      sleep 40
      rm -rf ${testcase}*
    fi
  else
    ${testcase}*/nukerun.sh
    break
  fi
else
    ${testcase}*/nukerun.sh
    echo "deleting..."
    grep "processChunk is aborted for region" ${testcase}*/*.log >> merged_errors.txt
    sleep 20
    rm -rf ${testcase}*
fi
done
