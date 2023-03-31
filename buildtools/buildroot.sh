#!/bin/bash

BUILDROOT_DIR=buildroot
CONFIG_FILE=${BUILDROOT_DIR}/.config

function buildroot_clone() {
    if [ ! -d ${BUILDROOT_DIR} ]; then
        echo "start cloning buildroot." 1>&3
        debug git clone git@github.com:buildroot/buildroot.git ${BUILDROOT_DIR}
        echo "cloning buildroot succeed."
    fi
    echo_info "start updating submodles"
    debug git submodule update --init --remote ${BUILDROOT_DIR}
}   

function buildroot_make() {

    cd buildroot
    echo "switch to 2022.11.2 tag"
    git checkout 2022.11.2
    if [ ! -e ${CONFIG_FILE} ]; then
        echo "making defconfig"
        debug make ${1}
        debug make -j12
    fi
}

function buildroot_build() {
    debug buildroot_clone
    debug buildroot_make $1
}
