This script was written with steps in below link
https://www.x.org/wiki/CrossCompilingXorg/


##Usage

Copy `.jhbuildrc` to `~/` and modify it if you need.

Copy and Modify `buildX.sh`.Set `CROSS_COMPILE` to your toolchain, `DISCIMAGE` to where you want to install to.

Run `./buildX.sh build_all` to build the environment.

Run `./buildX.sh build_xserver` to rebuild xserver alone.

