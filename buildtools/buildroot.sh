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
        make ${1}
    fi
}

function buildroot_build() {
    buildroot_clone
    ret=$?
    if [$ret != 0 ]; then
        exit 1
    fi

    buildroot_make $1
    ret=$?
    if [$ret != 0 ]; then
        exit 1
    fi
    exit 0 
}
