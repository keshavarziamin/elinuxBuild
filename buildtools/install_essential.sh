#! /bin/bash
function install_essential()
{
    sudo apt update -y 
    sudo apt upgrade -y
    sudo apt install -y build-essential manpages-dev
    sudo apt install -y make gcc g++ cmake git cpio
    sudo apt install -y help2man libtool-bin libtool-doc
    sudo apt install -y automake bison chrpath flex gperf gawk libexpat1-dev 
    suod apt install -y libncurses5-dev libsdl1.2-dev libtool python2.7-dev texinfo
}