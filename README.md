# Analog forecast tool

This repository tracks code that was used in development of this tool, and current code that is used to power the analog forecast tool.

The code in the `old/` directory is for archival/backup purposes.  Current version of the forecast tool is in `forecast.ncl`, but that code hasn't been fully reviewed or simplified yet.

## Setup & installation

 1. First, install Anaconda or [miniconda](https://docs.conda.io/en/latest/miniconda.html).
 1. Clear all caches.  `conda clean --all`
 1. Install NCL V6.6.0 (exactly that version):  `conda create -n ncl_stable -c conda-forge ncl=6.6.0`
 1. Activate the conda environment: `conda activate ncl_stable`.
 1. Test the environment per the [directions found here](https://ncl.ucar.edu/Download/conda.shtml).  **Note** the second two tests require an X11/XQuartz environment, which don't apply when installing on a server.
 1. Run `./setup_ncl_environment.sh` to get some libraries and source files copied in place.
 1. Run `./update_data.sh` to get the data updated.
