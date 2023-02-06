#! /bin/bash
source bashColor.sh
downloadDirectory="crosstool-ng"
latestTag="crosstool-ng-1.25.0"

function download_essential_packages() {

    cecho "Y" "DOWNLOADING AND INSTALLING ESSENTIAL PACKAGES STARTED."

    sudo apt install automake bison chrpath flex g++ git gperf gawk libexpat1-dev libncurses5-dev libsdl1.2-dev libtool python2.7-dev texinfo

    if [ $? != 0 ]; then
        cecho "RB" "DOWNLOADING AND INSTALLING ESSENTIAL PACKAGES FAILED."
        exit 1
    fi
    cecho "GB" "DOWNLOADING AND INSTALLING ESSENTIAL PACKAGES FINISHED."
}

function download_crosstoolsNG() {

    cecho "Y" "DOWNLOADING CROSSTOOLSNG STARTED"
    if [ ! -d ${downloadDirectory} ]; then
        git clone https://github.com/crosstool-ng/crosstool-ng.git
        if [ $? != 0 ]; then
            cecho "RB" "DOWNLOADING AND INSTALLING ESSENTIAL PACKAGES FAILED."
            exit 1
        fi
    fi
    cd crosstool-ng
    cecho "GB" "DOWNLOADING CROSSTOOLSNG SUCCEEDED"

}

function build_crosstoolNG_changeCheckout() {
    cecho "BB" "CHANIGNG CHECKOUT TO ${latestTag}"
    git checkout ${latestTag}
    if [ $? != 0 ]; then
        cecho "RB" "CHANIGNG CHECKOUT TO ${latestTag} FAILED."
        exit 1
    fi
    cecho "GB" "CHANIGNG CHECKOUT TO ${latestTag} SUCCEEDED"
}

function build_crosstoolNG_bootstrap() {
    cecho "Y" " BOOTSTRAPT STARTED"
    ./bootstrap
    if [ $? != 0 ]; then
        cecho "RB" "BOOTSTRAPT FAILED."
        exit 1
    fi
    cecho "GB" " BOOTSTRAPT SUCCEEDED"
}

function build_crosstoolNG_configure() {

    ./configure --enable-local
    if [ $? != 0 ]; then
        cecho "RB" "CONFIGURING FAILED."
        exit 1
    fi
    cecho "GB" " CONFIGURING SUCCEEDED"
}

function build_crosstoolNG_make() {
    cecho "Y" " MAKEING CROSSTOOLNG STARTED"
    sudo make
    if [ $? != 0 ]; then
        cecho "RB" "MAKEING CROSSTOOLNG FAILED."
        exit 1
    fi
    sudo make install
    if [ $? != 0 ]; then
        cecho "RB" "MAKEING CROSSTOOLNG FAILED."
        exit 1
    fi
    cecho "GB" " MAKEING CROSSTOOLNG SUCCEEDED"
}

function build_crosstoolNG() {

    cd ${downloadDirectory}
    build_crosstoolNG_changeCheckout
    build_crosstoolNG_bootstrap #bootstrap crosstool
    build_crosstoolNG_configure
    build_crosstoolNG_make #make and make indtall
}

download_essential_packages
download_crosstoolsNG # download source files from github
build_crosstoolNG
# #show version of ng
./ct-ng --version
cecho "RB" "--------LIST OF ALL SAMPLES-----------"
./ct-ng list-samples
./ct-ng distclean
./ct-ng arm-unknown-linux-gnueabi
./ct-ng menuconfig
./ct-ng build

