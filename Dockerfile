FROM ubuntu:18.04

# switch mirror to a closer one
RUN sed -i -e 's/archive.ubuntu.com/ubuntu.ethz.ch/g' -e 's/security.ubuntu.com/ubuntu.ethz.ch/g' /etc/apt/sources.list

# install general tools
RUN apt-get update && apt-get -y install build-essential gcc zip unzip make python cmake ca-certificates gnupg wget --no-install-recommends && \
    apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# install llvm
RUN mkdir /llvm && cd /llvm && wget http://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz && tar -xf llvm-9.0.0.src.tar.xz \
    && mkdir llvm-build && cd llvm-build && cmake -G "Unix Makefiles" ../llvm-9.0.0.src && make && make install && rm -rf /llvm

# install ocaml
RUN apt-get update && apt-get install -y ocaml ocamlbuild menhir --no-install-recommends && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# install additional tools
RUN apt-get update && apt-get -y install nano vim emacs git subversion --no-install-recommends && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
# if you need additional tools, either create an image, inhereting from this one at `pascalwacker/ethz-comp-design-docker` or enter your commands below this line!

# create working directory
RUN mkdir /home/compDesign
WORKDIR /home/compDesign

# create infinity loop
RUN echo 'sleep infinity' > /bootstrap.sh && chmod +x /bootstrap.sh
CMD /bootstrap.sh
