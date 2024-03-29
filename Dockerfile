FROM ubuntu:18.04

# switch mirror to a closer one
RUN sed -i -e 's/archive.ubuntu.com/ubuntu.ethz.ch/g' -e 's/security.ubuntu.com/ubuntu.ethz.ch/g' /etc/apt/sources.list

# install general tools
RUN apt-get update && apt-get -y install build-essential gcc zip unzip make python cmake ca-certificates gnupg wget --no-install-recommends && \
    apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# install llvm
RUN mkdir /llvm && cd /llvm && wget http://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz && tar -xf llvm-9.0.0.src.tar.xz && \
    wget http://releases.llvm.org/9.0.0/cfe-9.0.0.src.tar.xz && tar -xf cfe-9.0.0.src.tar.xz && mv cfe-9.0.0.src llvm-9.0.0.src/tools/clang && \
    mkdir llvm-build && cd llvm-build && cmake -G "Unix Makefiles" ../llvm-9.0.0.src && make && make install && rm -rf /llvm

# install ocaml
#RUN apt-get update && apt-get install -y curl build-essential m4 zlib1g-dev libssl-dev ocaml ocaml-native-compilers opam && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
#RUN curl -OL https://github.com/ocaml/ocaml/archive/4.07.1.tar.gz && tar -zxvf 4.07.1.tar.gz && cd ocaml-4.07.1 && ./configure && make world world.opt && make install
RUN apt-get update && apt-get install -y curl build-essential m4 zlib1g-dev libssl-dev aspcud && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
RUN wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh -O - | sh -s /usr/local/bin
ENV OPAMKEEPBUILDDIR false
ENV OPAMBUILDDOC false
ENV OPAMDOWNLOADJOBS 1
RUN opam init -ay --comp=4.07.0 && opam install -y ocamlbuild menhir omake ctypes-foreign stdint ocaml-compiler-libs num && echo 'eval `opam config env`' > /root/.bashrc
# eval $(opam config env)

ENV PATH="/root/.opam/system/bin:${PATH}"

# install additional tools
RUN apt-get update && apt-get -y install nano vim emacs git subversion entr --no-install-recommends && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
# if you need additional tools, either create an image, inhereting from this one at `pascalwacker/ethz-comp-design-docker` or enter your commands below this line!

# create working directory
RUN mkdir /home/compDesign
WORKDIR /home/compDesign

# create infinity loop
RUN echo 'sleep infinity' > /bootstrap.sh && chmod +x /bootstrap.sh
CMD /bootstrap.sh
