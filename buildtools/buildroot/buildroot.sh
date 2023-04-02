#!/bin/bash
ROOT_DIR=$(pwd)
BUILDROOT_DIR=buildtools/buildroot
# BUIDROOT_BOARDS_DIR=${BUILDROOT_DIR}/boards
BUILDROOT_SRC_DIR=${BUILDROOT_DIR}/src
ERROR_HANDLE_DIR=buildtools/error_handler

# source ${BUIDROOT_BOARDS_DIR}/listboards.sh
source ${ERROR_HANDLE_DIR}/errhdl.sh

CONFIG_FILE=${BUILDROOT_SRC_DIR}/.config

SOURCE_TAG=2023.02

CLEAN_FLAG=""
LIST_FLAG=""
BUILD_FLAG=""

BUILDROOT_CONFIG=""
BUILDROOT_MENU=""

function buildroot_cleanImage() {

    if [ -d output ]; then
        rm -rf output/target
        find output/ -name ".stamp_target_installed" -delete
        rm -f output/build/host-gcc-final-*/.stamp_host_installed
        rm -rf output/*
    fi
}

function buildroot_printList() {

    # get list on boards config from buildroot
    print "\tBUILDROOT:\n"
    make list-defconfigs 1>&3
}

function buildroot_isConfigValid() {

    # get list on boards config from buildroot
    config_list=$(make list-defconfigs)

    # search name of config in the list and return status
    # w is used to sereach whole word
    grep -qw "$1" <<<$config_list && return ${SUCCESS} || echo_return ${ERROR} "Not found the config"

}

function buildroot_cloneSource() {

    # update source folder and files
    print "start updating source files of buildroot\n"
    git submodule update --init --remote ${BUILDROOT_SRC_DIR} 1>&3

    #chang checkout to a tag version
    echo "switch buildroot source files to ${SOURCE_TAG} veriosn" 1>&3
    git checkout ${SOURCE_TAG} 1>&3

}

function buildroot_makeImage() {

    #check config folder

    if [ ! -e ${CONFIG_FILE} ]; then

        echo_info "start making config"

        debug make $1 # make config according to config

        # start menuconfig
        if [ $2 = true ]; then
            echo_info "run menuconfig to set new configuration."
            make menuconfig 1>&3 # open menu config in teminal
            echo_info "save new configuration."
        fi

        # You do not tell make how many parallel jobs to run with a -j option:
        # Buildroot will make optimum use of your CPUs all by itself. If you want to
        # limit the number of jobs, you can run make menuconfig and look under
        # the Build options.

        debug make
    fi

}

function buildroot_buildKernel() {

    buildroot_cloneSource # add submodule or update submodule
    debug buildroot_makeImage $1 $2

}

function buildroot_getopts() {

    # get arguments
    BR_VALID_ARGS=$(getopt -o lc:C --long list,config,clean: -- "$@")

    if [ $? -ne 0 ]; then
        echo_err "buildroot: the arguments are not valid"
        usage
        exit ${ERROR}
    fi

    while [ $# -ne 0 ]; do
        case $1 in

        --) ;; #ignore this argumnet

        -l | --list) # print list of configs
            LIST_FLAG=true
            ;;
        -C | --clean)
            CLEAN_FLAG=true
            ;;

        -c | --config) #select config accordings to list
            shift
            while [ $# -ne 0 ]; do

                case $1 in

                --) ;; #ignore this argumnet

                menuconfig)
                    BUILDROOT_MENU=true
                    print "start; $BUILDROOT_MENU\n"
                    ;;

                *)
                    if [ $1 != "" ]; then

                        BUILDROOT_CONFIG=$1
                        BUILD_FLAG=true

                    fi
                    ;;

                : | \?)
                    echo_err "Buildroot: The arguments are not valid"
                    exit ${ERROR}
                    ;;
                esac
                shift
            done
            ;;

        : | *)
            echo_err "Buildroot: The arguments are not valid"
            exit ${ERROR}
            ;;

        esac
        shift
    done

}

function buildroot_run() {

    # get arguments
    buildroot_getopts

    # goto to buildroot source code path
    cd ${BUILDROOT_SRC_DIR}

    if $CLEAN_FLAG; then
        echo_info "start removing images files"
        debug buildroot_cleanImage
        exit $SUCCESS
    fi

    # print list on board and device configs that are supported with buildroot
    if $LIST_FLAG; then

        buildroot_printList
        exit ${SUCCESS}

    fi

    if $BUILD_FLAG; then

        debug buildroot_isConfigValid $BUILDROOT_CONFIG
        echo_info "starting building image with buildroot"
        debug buildroot_buildKernel $BUILDROOT_CONFIG $BUILDROOT_MENU

    fi

    # return to project path
    cd ${ROOT_DIR}

}
