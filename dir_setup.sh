#!/bin/bash
# setup the installation directory for running the analogs
# run with `sudo env "NCARG_ROOT=$NCARG_ROOT" ./dir_setup`

# currently, this is copy-pasting the csm folder provided by Brian,
#   overwriting the installed csm folder (will see if this causes issues)
# copy-paste if BB_utils.ncl not present in the csm folder
# csm_func = ok
#
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

# make maps folder
# TODO remove this we want this elsewhere.
TEMP_DIR=/var/www/html/maps
if [[ ! -d $TEMP_DIR ]]
then
    mkdir -p $TEMP_DIR
fi

# look for the following files in $NCARG_ROOT/lib/ncarg/data/downloads,
#   download if not present
# sst.mnmean.v5.nc
TEMP_FP=$NCARG_ROOT/lib/ncarg/data/downloads/sst.mnmean.v5.nc
if [[ ! -f $TEMP_FP ]]
then
    wget -O $TEMP_FP ftp://ftp.cdc.noaa.gov/Datasets/noaa.ersst.v5/sst.mnmean.nc
fi

# air.mon.mean.nc
TEMP_FP=$NCARG_ROOT/lib/ncarg/data/downloads/air.mon.mean.nc
if [[ ! -f $TEMP_FP ]]
then
    wget -O $TEMP_FP ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/surface/air.mon.mean.nc
fi

# hgt.mon.mean.nc
TEMP_FP=`/hgt.mon.mean.nc
if [[ ! -f $TEMP_FP ]]
then
    wget -O $TEMP_FP ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/pressure/hgt.mon.mean.nc
fi

# air.mon.mean.pres.nc (renamed from default)
TEMP_FP=$NCARG_ROOT/lib/ncarg/data/downloads/air.mon.mean.pres.nc
if [[ ! -f $TEMP_FP ]]
then
    wget -O $TEMP_FP ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/pressure/air.mon.mean.nc
fi

# icec.sfc.mon.mean.nc
TEMP_FP=$NCARG_ROOT/lib/ncarg/data/downloads/icec.sfc.mon.mean.nc
if [[ ! -f $TEMP_FP ]]
then
    wget -O $TEMP_FP ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/surface_gauss/icec.sfc.mon.mean.nc
fi

# slp.mon.mean.nc
TEMP_FP=$NCARG_ROOT/lib/ncarg/data/downloads/slp.mon.mean.nc
if [[ ! -f $TEMP_FP ]]
then
    wget -O $TEMP_FP ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/surface/slp.mon.mean.nc
fi

# precip.mon.anom.nc
TEMP_FP=$NCARG_ROOT/lib/ncarg/data/downloads/precip.mon.anom.nc
if [[ ! -f $TEMP_FP ]]
then
    wget -O $TEMP_FP ftp://ftp.cdc.noaa.gov/Datasets/prec/precip.mon.anom.nc
fi


