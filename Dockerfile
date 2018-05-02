FROM ambermd/amber-build-box

# get Amber build dependencies
#RUN yum update -y && yum install -y csh flex gcc patch zlib-devel bzip2-devel libXt-devel libXext-devel libXdmcp-devel lapack-devel blas-devel arpack-devel

# add and extract binary CMake
ADD cmake-3.9.6-manylinux-build.tar.gz /amber-builds

# get Python packages installed
RUN conda install -y nomkl scipy && pip install matplotlib

WORKDIR /amber-builds

ADD . /amber-builds

