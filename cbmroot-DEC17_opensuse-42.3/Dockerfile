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

RUN mkdir /cbmroot_DEC17

RUN cd /cbmroot_DEC17 && svn co https://subversion.gsi.de/cbmsoft/cbmroot/release/DEC17 cbmroot_svn

WORKDIR /cbmroot_DEC17/cbmroot_svn
ENV CBMSRCDIR=/cbmroot_DEC17/cbmroot_svn

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

# fix known issue with flatbuffers v1.6.0 by using 1.7.1 instead
ENV FSOFTVER=mar17 ROOTVER=6
RUN cd .. && git clone https://github.com/FairRootGroup/FairSoft fairsoft_src_${FSOFTVER}_root${ROOTVER}
RUN sed -i 's/FLATBUFFERS_BRANCH=v1.6.0/FLATBUFFERS_BRANCH=v1.7.1/' /cbmroot_DEC17/fairsoft_src_${FSOFTVER}_root${ROOTVER}/scripts/package_versions.sh

RUN ./autoinstall_framework.sh 1

# prefer freshly compiled binaries like cmake
ENV PATH="/cbmroot_DEC17/fairsoft_mar17_root6/installation/bin:${PATH}"

RUN ./autoinstall_framework.sh 0 1
RUN ./autoinstall_framework.sh 0 0 1

# set all environment variables
RUN source ./build/config.sh
ENV SIMPATH=/cbmroot_DEC17/fairsoft_mar17_root6/installation
ENV FAIRROOTPATH=/cbmroot_DEC17/fairroot_v-17.03a-fairsoft_mar17_root6
