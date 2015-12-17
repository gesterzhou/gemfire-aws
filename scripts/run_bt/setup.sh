
# ----
# Following values are customized by redirect.pl
#JDK=/gcm/where/jdk/1.6.0_26/x86.linux
JDK=/usr/java/jdk1.8.0_45
OBJ_BASE=/home/gfadmin/linux
#OBJ_BASE=/export/aruba2/users/zhouxh/git3/gemfire/build-artifacts/linux/
#OBJ_BASE=/export/w2-gst-dev40a/users/zhouxh/git2/gemfire/build-artifacts/linux/

# ----

case $HOSTTYPE.$OSTYPE in
  i686.cygwin)
    DS=";"
    ;;
  x86_64.linux*)
    DS=":"
    ;;
  i386.linux*)
    DS=":"
    ;;
  sparc.solaris*)
    DS=":"
    ;;
  *)
    DS=":"
    #exit 1
    ;;
esac

export NO_BUILD_LOG=true

export GEMFIRE=$OBJ_BASE/product
if [ ! -d "$GEMFIRE" ]; then
  echo "GEMFIRE $GEMFIRE does not exist"
fi

export JTESTSROOT=$OBJ_BASE/tests
if [ ! -d "$JTESTSROOT" ]; then
  echo "JTESTSROOT $JTESTSROOT does not exist"
fi

export JTESTS=$JTESTSROOT/classes
if [ ! -d "$JTESTS" ]; then
  echo "JTESTS $JTESTS does not exist!"
else
  echo "JTESTS     : " $JTESTS
fi

if [ ! -d "$OBJ_BASE/product" ]; then
  echo "$GEMFIRE $OBJ_BASE/product does not exist"
fi
pushd $OBJ_BASE/product
echo pushd $PWD
#set -xv
#. ./bin/setenv.sh
#set +xv
popd
echo popd $PWD

cp=.
cp=$cp$DS$OBJ_BASE/classes
cp=$cp${DS}$JTESTS${DS}$GEMFIRE/lib/gemfire.jar${DS}$GEMFIRE/lib/griddb-dependencies.jar${DS}$OBJ_BASE/product-sqlf/lib/sqlfire.jar${DS}$GEMFIRE/lib/log4j-api-2.1.jar${DS}$GEMFIRE/lib/log4j-core-2.1.jar${DS}$GEMFIRE/lib/mx4j-tools.jar${DS}$GEMFIRE/lib/mx4j.jar${DS}$GEMFIRE/lib/mx4j-remote.jar
export CLASSPATH=$cp
echo "CLASSPATH  : $CLASSPATH"

newpath=$OBJ_BASE/hidden/lib
newpath=$newpath$DS$OBJ_BASE/product/jre/bin
export PATH=$newpath$DS$PATH
echo "PATH       : $PATH"
