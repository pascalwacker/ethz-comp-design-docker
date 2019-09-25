FROM ubuntu:18.04

# create working directory
RUN mkdir /home/compDesign
WORKDIR /home/compDesign

# install general tools
RUN apt-get update && apt-get -y install build-essential nano vim emacs git gcc zip unzip make python cmake ca-certificates gnupg wget subversion

# install llvm
RUN mkdir /llvm && cd /llvm && wget http://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz && tar -xf llvm-9.0.0.src.tar.xz \
    && mkdir llvm-build && cd llvm-build && cmake -G "Unix Makefiles" ../llvm-9.0.0.src && make && make install && rm -rf /llvm

# install ocaml
RUN apt-get install -y ocaml ocamlbuild menhir

# clean cache
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# create infinity loop
RUN echo 'sleep infinity' > /bootstrap.sh
RUN chmod +x /bootstrap.sh
CMD /bootstrap.sh