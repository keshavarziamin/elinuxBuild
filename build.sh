#! /bin/bash

source error_handler/errhdl.sh
source buildtools/buildroot/buildroot.sh
source buildtools/install_essential.sh

YP="yocto"
BR="buildroot"
MB="manual"

ERROR=1
SUCCESS=0

LIST_TEXT_DIR="buildtools/list_of_boards.txt"

BUILD_SYSTEM=""
BOARD=""

function usage() {
    echo "USAGE: arguments in not valid "
}

function build_run() {

    # exit error if arguments are not valid
    if [ $# -ne 2 ]; then
        usage 1>&3
        echo_return $ERROR "The arguments are wrongs"
    fi

    #select build system
    case $1 in
    $BR)
        echo "buildroot ${2}"
        buildroot_build $2
        ;;
    *)
        echo_return $ERROR "please choose a correct build system"
        ;;
    esac
}

function get_options() {

    while getopts "b:d:l" option; do

        case $option in
        b)
            if [ $OPTARG != $YP ] && [ $OPTARG != $BR ] && [ $OPTARG != $MB ]; then
                usage
                exit 1
            fi
            BUILD_SYSTEM=$OPTARG
            ;;
        d)
            debug checkBoard $OPTARG
            BOARD=$OPTARG
            ;;
        l)
            cat $LIST_TEXT_DIR 1>&3
            exit 0
            ;;
        *)
            echo_err "invalid arguments"
            usage
            exit 1
            ;;
        esac
    done

}

get_options $@

# debug install_essential
debug build_run $BUILD_SYSTEM $BOARD

exit 0
