FROM pklaus/fairsoft:opensuse-42.3_mar17 as builder

#RUN zypper ref && zypper --non-interactive install \
#    htop

ENV SIMPATH=/fairsoft

RUN echo "Setting up FairRoot ..."

ARG fairroot_branch=v-17.03a
ENV FAIRROOT_BRANCH=$fairroot_branch

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
 && nice make install -j4 \
 && echo done installing FairRoot

# now we start from scratch and carry only the compiled output with us
FROM pklaus/fairsoft:opensuse-42.3_mar17

ENV FAIRROOT_BRANCH=$fairroot_branch

COPY --from=builder /fairroot /fairroot

WORKDIR /fairroot

ENV FAIRROOTPATH=/fairroot
