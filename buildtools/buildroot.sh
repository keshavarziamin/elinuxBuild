#!/bin/bash

BUILDROOT_DIR=buildroot
CONFIG_FILE=${BUILDROOT_DIR}/.config

function buildroot_clone() {
    if [ ! -d ${BUILDROOT_DIR} ]; then
        echo "start cloning buildroot."
        git clone git@github.com:buildroot/buildroot.git ${BUILDROOT_DIR}

        if [ $? -ne 0 ]; then
            echo "cloning buildroot failed."
            exit 1
        fi
        echo "cloning buildroot succeed."
    fi

}

function buildroot_make() {

    cd buildroot
    echo "switch to 2022.11.2 tag "
    git checkout 2022.11.2
    if [ ! -e ${CONFIG_FILE} ]; then
        echo "making defconfig"
        debug make ${1}
        debug make -j4
    fi
}

function buildroot_build() {
    debug buildroot_clone
    debug buildroot_make $1
}
