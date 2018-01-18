FROM opensuse:42.3

RUN zypper ref

RUN zypper --non-interactive in \
  gcc-c++ git subversion

RUN mkdir /cbmroot_DEC17

RUN cd /cbmroot_DEC17 && svn co https://subversion.gsi.de/cbmsoft/cbmroot/release/DEC17 cbmroot_svn

#RUN zypper --non-interactive in python-numpy-devel

WORKDIR /cbmroot_DEC17/cbmroot_svn
ENV CBMSRCDIR=/cbmroot_DEC17/cbmroot_svn


RUN zypper --non-interactive in \
  wget curl \
  tar zlib \
  gcc-fortran \
  libX11-devel libXext-devel libXft-devel libXpm-devel \
  cmake which unzip make autoconf automake libcurl4 openssl libssl43 libtool libcurl-devel freeglut-devel libopenssl-devel patch

# Let's use gcc v6:
RUN zypper --non-interactive rm \
  gcc gcc-c++ gcc-fortran
RUN zypper --non-interactive in \
  gcc6 gcc6-c++ gcc6-fortran
ENV CC=/usr/bin/gcc-6
ENV CXX=/usr/bin/g++-6
RUN ln -s /usr/bin/gcc-6 /usr/bin/gcc \
 && ln -s /usr/bin/g++-6 /usr/bin/g++ \
 && ln -s /usr/bin/gfortran-6 /usr/bin/gfortran

RUN ./autoinstall_framework.sh 1
#./autoinstall_framework.sh 0 1
#./autoinstall_framework.sh 0 0 1
#. build/config.sh

#export SIMPATH=/local/cbmroot_DEC17/fairsoft_may16p1_root6/installation
#export FAIRROOTPATH=/local/cbmroot_DEC17/fairroot_v-16.06b-fairsoft_may16p1_root6
