# Analog forecast tool

## Installing NCL

Install NCL=6.3.0 (hard version requirement, newer breaks this code) with `conda` [per recommendations](http://ncl.ucar.edu/Download/conda.shtml).
Install `imagemagick`.

If not using a `conda` environment, more of these things may be needed:

-   set `$NCARG_ROOT` to the path to the ncl-6.3.0
-   add `$NCARG_ROOT/bin` to `$PATH`

Use the `dir_setup.sh` script to prepare directories if needed and fetch initial copies of the data.

Crucial environment variables to set:
NCL_OUTPUT_DIR is where the final output files are written
^ change to EAPI?
todo : need an env var for `filedir`

<!-- make $NCARG_ROOT/lib/ncarg/data/downloads
download the data found in the dir_setup shell script to this folder, pay attention to renaming (one file has duplicate name I think)
copy $NCARG_ROOT/lib/ncarg/data/csv/parameters1.csv to something like parameters1_original.csv if you want to preserve original params. -->

remove all but one line from \$NCARG_ROOT/lib/ncarg/data/csv/parameters1.csv. This remaining line will serve as the params used when you call the .ncl script.

# Not sure if the sudo/env stuff will be necessary for you

sudo -E env "PATH=\$PATH" ncl eapi-analogs/SeaIceSelectPercents4bRMS.ncl
