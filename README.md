# Analog forecast tool

This repository tracks code that was used in development of this tool, and current code that is used to power the analog forecast tool.

The code in the `old/` directory is for archival/backup purposes.  Current version of the forecast tool is in `forecast.ncl`, but that code hasn't been fully reviewed or simplified yet.

## Setup & installation

 1. Install Anaconda or [miniconda](https://docs.conda.io/en/latest/miniconda.html).
 2. Install NCL V6.6.0 (exactly and only that version) from the [directions found here](https://ncl.ucar.edu/Download/conda.shtml).  Name your NCL environment `ncl_stable`, as in the instructions.  Test the environment.
 3. Activate the conda environment: `conda activate ncl_stable`.
 4. Run `./setup_ncl_environment.sh` to get some libraries and source files copied in place.
 5. Run `./update_data.sh` to get the data updated.
