#!/bin/bash

# path to Amber source directory relative to Dockerfile
amber_src_dir=./amber18

export PATH=/amber-builds/cmake-3.9.6/bin:$PATH

mkdir -p build
cd build
cmake ../amber18 -DCMAKE_INSTALL_PREFIX=/opt/amber -DPRINT_PACKAGING_REPORT=TRUE -DCOMPILER=GNU -DDOWNLOAD_MINICONDA=FALSE -DPACKAGE_TYPE=ARCHIVE -DARCHIVE_FORMAT=TGZ -DARCHIVE_MONOLITHIC=FALSE -DINSTALL_TESTS=TRUE -DUNINITIALIZED_WARNINGS=FALSE "-DFORCE_INTERNAL_LIBS=arpack;readline" -DFORCE_DISABLE_LIBS=mkl
#NOTE: -DFORCE_INTERNAL_LIBS=readline is needed to work around an issue in this verion of Anaconda where libreadline does not declare its dependency on libtinfo

make -j4

# install to container (for testing)
mkdir -p /opt/amber
make -j4 install

# make separated package
make -j4 package

# make monolithic package
cmake ../amber18 -DARCHIVE_MONOLITHIC=TRUE
make -j4 package

# copy artifacts
mkdir -p /artifacts
cp *.tar.gz /artifacts/

# run tests
source /opt/amber/amber.sh
cd /opt/amber
make test.serial
