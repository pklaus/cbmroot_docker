FROM opensuse:42.3 as builder

RUN zypper ref && zypper --non-interactive install \
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
ENV FAIRSOFT_BRANCH=$fairsoft_branch
RUN git clone https://github.com/FairRootGroup/FairSoft.git fairsoft_src
RUN cd /fairsoft_src \
 && git checkout $fairsoft_branch \
 && git show

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

RUN sed -i 's/compiler=/compiler=gcc/' automatic.conf \
 && sed -i 's/build_root6=no/build_root6=yes/' automatic.conf \
 && sed -i 's|SIMPATH_INSTALL=$PWD/installation|SIMPATH_INSTALL=/fairsoft|' automatic.conf

RUN if [ "$fairsoft_branch" = "mar17" ]; then \
    # fix known issue with flatbuffers v1.6.0 by using 1.7.1 instead
    sed -i 's/FLATBUFFERS_BRANCH=v1.6.0/FLATBUFFERS_BRANCH=v1.7.1/' /fairsoft_src/scripts/package_versions.sh; \
    sed -i 's/MSGPACK_BRANCH=cpp-2.1.1/MSGPACK_BRANCH=cpp-2.1.3/' /fairsoft_src/scripts/package_versions.sh; \
    fi

RUN cat /fairsoft_src/scripts/package_versions.sh
#RUN /bin/false

RUN ./configure.sh automatic.conf

FROM opensuse:42.3

RUN zypper ref && zypper --non-interactive install \
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

COPY --from=builder /fairsoft /fairsoft

WORKDIR /fairsoft

# prefer freshly compiled binaries like cmake
ENV PATH="/fairsoft/bin:${PATH}"

ENV SIMPATH=/fairsoft
