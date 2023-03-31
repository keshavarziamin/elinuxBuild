#!/bin/bash
ROOT_DIR=$(pwd)
BUILDROOT_DIR=buildtools/buildroot
BUIDROOT_BOARDS_DIR=${BUILDROOT_DIR}/boards
BUILDROOT_SRC_DIR=${BUILDROOT_DIR}/src
ERROR_HANDLE_DIR=buildtools/error_handler

source ${BUIDROOT_BOARDS_DIR}/listboards.sh
source ${ERROR_HANDLE_DIR}/errhdl.sh

CONFIG_FILE=${BUILDROOT_SRC_DIR}/.config

SOURCE_TAG=2023.02

function buildroot_printList() {
    num=1
    print "\tBUILDROOT:\n"
    for board_name in ${list[@]}; do
        print "\t\t$num: $board_name\n"
        num=$(($num + 1))
    done
}

function buildroot_isBoradValid() {

    cd ${BUILDROOT_SRC_DIR}

    boards_list=$(make list-defconfigs)
    echo $boards_list
    # return error if the name of board does not exit in list or is not valid.
    grep -q "${1}" <<<$boards_list && return ${SUCCESS} || echo_return ${ERROR} "Not found the config"

    cd ${ROOT_DIR}
    # for name in ${list[@]}; do
    #     if [ $name = ${1} ]; then
    #         return ${SUCCESS} # return vaild
    #     fi
    # done

    # echo_err "Not found the board"
    # return ${ERROR}
}

function buildroot_cloneSource() {

    # update source folder and files
    print "start updating source files of buildroot\n"
    git submodule update --init --remote ${BUILDROOT_SRC_DIR} 1>&3

    # go to source folder
    cd ${BUILDROOT_SRC_DIR}

    #chang checkout to a tag version
    echo "switch buildroot source files to ${SOURCE_TAG} veriosn" 1>&3
    git checkout ${SOURCE_TAG} 1>&3

    cd ${ROOT_DIR}
}

function buildroot_makeImage() {

    cd ${BUILDROOT_SRC_DIR}

    #check config folder
    if [ ! -e ${CONFIG_FILE} ]; then

        debug make ${1} # make config

        # You do not tell make how many parallel jobs to run with a -j option:
        # Buildroot will make optimum use of your CPUs all by itself. If you want to
        # limit the number of jobs, you can run make menuconfig and look under
        # the Build options.
        debug make # make install
    fi

    cd ${ROOT_DIR}
}

function buildroot_buildKernel() {

    buildroot_cloneSource # add submodule or update submodule
    debug buildroot_makeImage $1

}
