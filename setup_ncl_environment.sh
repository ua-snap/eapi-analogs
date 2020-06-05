#!/bin/bash
# setup the installation directory for running the analogs
# run with `sudo env "NCARG_ROOT=$NCARG_ROOT" ./dir_setup`
# TODO move some of this stuff out of here
# currently, this is copy-pasting the csm folder provided by Brian,
#   overwriting the installed csm folder (will see if this causes issues)
# copy-paste if BB_utils.ncl not present in the csm folder
TEMP_DIR=$NCARG_ROOT/lib/ncarg/nclscripts
if [[ ! -f $TEMP_DIR/csm/BB_utils.ncl ]]
then
    cp -r csm $TEMP_DIR
fi

# no need to make data make data folder, should be present
# copy-paste if no csv folder here
TEMP_DIR=$NCARG_ROOT/lib/ncarg/data
if [[ ! -d $TEMP_DIR/csv ]]
then
    cp -r csv $TEMP_DIR
fi

# make folder for downloaded data if not present
TEMP_DIR=$NCARG_ROOT/lib/ncarg/data/downloads
if [[ ! -d $TEMP_DIR ]]
then
    mkdir $TEMP_DIR
fi
