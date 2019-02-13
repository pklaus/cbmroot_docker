FROM opensuse/leap:15.1 as base
# -----------------------------------------------
#  Base image containing the dependencies we need
# -----------------------------------------------

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

# Now let's compile FairSoft
FROM base as fairsoft_builder
# ----------------------------------------
#  Intermediate(!) image to build FairSoft
# ----------------------------------------

ARG fairsoft_branch=oct17p1
ENV FAIRSOFT_BRANCH=$fairsoft_branch
RUN git clone https://github.com/FairRootGroup/FairSoft.git fairsoft_src
RUN cd /fairsoft_src \
 && git checkout $fairsoft_branch -b $fairsoft_branch \
 && git show

WORKDIR /fairsoft_src

RUN sed -i 's/compiler=/compiler=gcc/' automatic.conf \
 && sed -i 's/build_root6=no/build_root6=yes/' automatic.conf \
 && sed -i 's|SIMPATH_INSTALL=$PWD/installation|SIMPATH_INSTALL=/fairsoft|' automatic.conf

RUN cat /fairsoft_src/scripts/package_versions.sh

RUN ./configure.sh automatic.conf

# Now we have a compiled version of FairSoft in /fairsoft and the
# sources which are most likely not needed anymore in /fairsoft_src.
# To get rid of the /fairsoft_src folder (almost 20G big) we start
# from scratch and carry only the compiled output in /fairsoft with us:
# This makes use of the new multi stage build feature of Docker >= 17.05
# https://docs.docker.com/engine/userguide/eng-image/multistage-build/
# The alternatives would be to:
# * run all commands in one big RUN instruction
#   (bad as Docker couldn't cache intermediate results)
# * Separate `RUN rm -r /fairsoft_src` instruction (this would require to build
#   the image with the experimental --squash argument to save storage space)
FROM base as fairsoft
# -----------------------------------------------------
#  Final FairSoft Image !!!
# 
#  we throw away /fairsoft_src and only carry /fairsoft
# -----------------------------------------------------

COPY --from=fairsoft_builder /fairsoft /fairsoft

WORKDIR /fairsoft

# prefer freshly compiled binaries like cmake
ENV PATH="/fairsoft/bin:${PATH}"

ENV SIMPATH=/fairsoft

FROM fairsoft as fairroot_builder
# ----------------------------------------
#  Intermediate(!) image to build FairRoot
# ----------------------------------------

ARG fairroot_branch=v-17.10c
ENV FAIRROOT_BRANCH=$fairroot_branch

RUN echo "Setting up FairRoot ..."

RUN git clone https://github.com/FairRootGroup/FairRoot.git /fairroot_src

WORKDIR /fairroot_src

RUN git tag -l \
 && git checkout -b $fairroot_branch $fairroot_branch \
 && git status
RUN mkdir build \
 && cd build \
 && cmake \
    -DCMAKE_CXX_COMPILER=$($SIMPATH/bin/fairsoft-config --cxx) \
    -DCMAKE_C_COMPILER=$($SIMPATH/bin/fairsoft-config --cc) \
    -DCMAKE_INSTALL_PREFIX=/fairroot \
    .. \
 && nice make install -j8 \
 && echo done installing FairRoot

FROM fairsoft as fairroot
# ----------------------------------
#  Final FairRoot Image !!!
# 
#  we throw away /fairroot_src and only carry /fairroot
# ----------------------------------

ENV FAIRROOT_BRANCH=$fairroot_branch

COPY --from=fairroot_builder /fairroot /fairroot

WORKDIR /fairroot

ENV FAIRROOTPATH=/fairroot

FROM fairroot as cbmroot
# ----------------------------------
#  Final CbmRoot Image !!!
# ----------------------------------

ENV CBMSRCDIR=/cbmroot

ARG cbmroot_release=OCT18
ENV CBMROOT_RELEASE=$cbmroot_release

WORKDIR /

RUN svn co https://subversion.gsi.de/cbmsoft/cbmroot/release/$CBMROOT_RELEASE /cbmroot

RUN if [ -d fieldmaps ]; then svn up fieldmaps; else svn co https://subversion.gsi.de/cbmsoft/cbmroot/fieldmaps fieldmaps; fi

WORKDIR /cbmroot/build

RUN cmake \
    -DCMAKE_CXX_COMPILER=$($SIMPATH/bin/fairsoft-config --cxx) \
    -DCMAKE_C_COMPILER=$($SIMPATH/bin/fairsoft-config --cc) \
    .. \
 && nice make -j8 \
 && cd /cbmroot/input \
 && ln -s /fieldmaps/* .

# nicer and Docker-aware prompt in container:
RUN zypper ref && zypper --non-interactive in ncurses-utils
ENV TERM xterm-256color
RUN echo 'PS1="\[$(tput setaf 4)$(tput bold)[\]cbmroot@\\h$:\\w]#\[$(tput sgr0) \]"' >> /root/.bashrc \
 #  source the CbmRoot Environment on startup:
 && echo 'source /cbmroot/build/config.sh' >> /root/.bashrc
RUN ["/bin/bash", "-c", "source $HOME/.bashrc; printenv"]
ENTRYPOINT ["/bin/bash", "-c"]

# Default command: start bash. Requires -it as params for `docker run`
CMD /bin/bash
