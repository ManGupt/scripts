#!/bin/sh

export PATH=.../git-2.30.0/bin:$PATH

if [ -z ${BUILD_DATE} ]; then
    echo "ERROR: set BUILD_DATE in format YYYY-MM-DD"
    exit 1
fi
if [ -z ${BUILD_ABI} ]; then
    echo "ERROR: set BUILD_ABI 0/1"
    exit 1
fi

git checkout master
commit=$(git log --until="$BUILD_DATE 17:00:00 +0530" -n 1 --format=%H)
git checkout $commit

export _USE_ABI=$BUILD_ABI
source setup.sh

dashboard=dashboard
if [ -z ${BUILD_DASHBOARD} ]; then
    dashboard=
    echo "INFO: set BUILD_DASHBOARD 1 to build dashboard"
fi

if [ -z ${BUILD_COMMAND} ]; then
    make clean -j
    make all $dashboard -j
else
    $BUILD_COMMAND
fi

# Package now!
export CUSTOM_RELEASE_PATH=".../CUSTOM_RELEASES"
echo "############################################################"
if [ -d "installs" ]; then
    echo "INFO: Found installs directory ..."
    export folder=`date -d"$BUILD_DATE" +'%b%d'`
    echo "INFO: Creating release dir: "$folder
    mkdir $CUSTOM_RELEASE_PATH/$folder
    echo "INFO: Copying build to release dir: "$CUSTOM_RELEASE_PATH/$folder/
    cp -rf installs/* $CUSTOM_RELEASE_PATH/$folder/.
    cd $CUSTOM_RELEASE_PATH
    echo "INFO: Re-creating latest link ..."
    rm -f latest
    ln -s $folder latest
    echo "INFO: Done."
else
    echo "ERROR: install dir is missing. Couldn't create release!"
fi
echo "############################################################"

# Get complete listing of nightly commits
#now=2018-12-01
#end=$(date +%F)
#while ! [[ $now > $end ]]; do
#    commit=$(git log --until="$now 17:00:00 +0530" -n 1 --format=%H)
#    echo $now,$commit
#    now=$(date -d "$now + 1 day" +%F)
#done
