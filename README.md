# Analog forecast tool

## Experimental Arctic Prediction Initiative

Codebase for running the Analog forecast tool.

When deployed, the process running PHP needs to have these env vars available:

 * `NCL_HOME` - absolute path, no trailing slash, to the folder containing the `ncl-6.3.0` folder.

### Setup

System changes for setting up VM to run NCL.

NCL installation:
1. run `ncl_install` script from $HOME
2. `sudo apt-get install libssh2-1`
3. `sudo apt-get install libfontconfig` (`y` at prompt)
4. `sudo apt-get install libxrender1`
5. `sudo apt-get install libgfortran3` (`y` at prompt)
6. `sudo apt-get install libgomp1`
7. `sudo apt-get install imagemagick` (`y` at prompt)

