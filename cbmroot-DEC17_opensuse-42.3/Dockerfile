FROM pklaus/fairroot:opensuse-42.3_v-17.03a

ENV CBMSRCDIR=/cbmroot

ARG cbmroot_release=DEC17
ENV CBMROOT_RELEASE=$cbmroot_release

# not needed, already set in pklaus/fairsoft:
#ENV PATH=$SIMPATH/bin:$PATH

WORKDIR /cbmroot

RUN svn co https://subversion.gsi.de/cbmsoft/cbmroot/release/$CBMROOT_RELEASE ./

RUN echo "Setting up Cbmroot ..."

RUN if [ -d fieldmaps ]; then svn up fieldmaps; else svn co https://subversion.gsi.de/cbmsoft/cbmroot/fieldmaps fieldmaps; fi

RUN mkdir build \
 && cd build \
 && cmake \
    -DCMAKE_CXX_COMPILER=$($SIMPATH/bin/fairsoft-config --cxx) \
    -DCMAKE_C_COMPILER=$($SIMPATH/bin/fairsoft-config --cc) \
    .. \
 && nice make -j4 \
 && cd .. \
 && cd input \
 && ln -s ../../fieldmaps/* .

RUN echo done installing CbmRoot

# set all environment variables
RUN source ./build/config.sh

RUN printenv
