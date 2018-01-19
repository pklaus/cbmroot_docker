FROM opensuse:42.3

RUN zypper ref

RUN zypper --non-interactive install \
    # List from https://github.com/FairRootGroup/FairSoft/blob/master/DEPENDENCIES
    cmake gcc gcc-c++ gcc-fortran make patch sed \
    libX11-devel libXft-devel libXpm-devel libXext-devel \
    libXmu-devel Mesa-libGL-devel freeglut-devel ncurses-devel \
    curl libcurl-devel bzip2 libbz2-devel gzip unzip tar \
    libexpat-devel subversion git flex bison makedepend lsb-release python-devel \
    libxml2-devel libopenssl-devel krb5-devel wget \
    libcurl-devel automake autoconf libtool which \
    # further dependencies
    zlib

ARG fairsoft_branch=master
ENV FAIRSOFT_BRANCH=$branch
RUN git clone https://github.com/FairRootGroup/FairSoft.git fairsoft_src \
 && cd /fairsoft_src \
 && git checkout $fairsoft_branch

WORKDIR /fairsoft_src

## Let's use gcc v7:
RUN zypper --non-interactive rm \
  gcc gcc-c++ gcc-fortran
RUN zypper --non-interactive in \
  gcc7 gcc7-c++ gcc7-fortran
ENV CC=/usr/bin/gcc-7
ENV CXX=/usr/bin/g++-7
RUN ln -s /usr/bin/gcc-7 /usr/bin/gcc \
 && ln -s /usr/bin/g++-7 /usr/bin/g++ \
 && ln -s /usr/bin/gfortran-7 /usr/bin/gfortran

## If you need to overwrite a specific package version, do:
#ENV FLATBUFFERS_BRANCH=v1.7.1

RUN sed -i 's/compiler=/compiler=gcc/' automatic.conf \
 && sed -i 's/build_root6=no/build_root6=yes/' automatic.conf \
 && sed -i 's|SIMPATH_INSTALL=$PWD/installation|SIMPATH_INSTALL=/fairsoft|' automatic.conf

RUN ./configure.sh automatic.conf

WORKDIR /fairsoft

# prefer freshly compiled binaries like cmake
ENV PATH="/fairsoft/bin:${PATH}"
