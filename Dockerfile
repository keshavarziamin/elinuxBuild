FROM ubuntu:22.04
RUN apt update -y 
RUN apt upgrade -y
RUN apt install -y build-essential manpages-dev
RUN apt install -y make gcc g++ cmake git cpio
RUN apt install -y help2man libtool-bin libtool-doc
RUN apt install -y automake bison chrpath flex gperf gawk libexpat1-dev 
RUN apt install -y libncurses5-dev libsdl1.2-dev libtool python2.7-dev texinfo

COPY . /elinuxbuild
