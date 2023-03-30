#! /bin/bash

source buildtools/listboars.sh
source buildtools/buildroot.sh

YP="yocto"
BR="buildroot"
MB="manual"
LIST_TEXT_DIR="buildtools/list_of_boards.txt"

BUILD_SYSTEM=""
BOARD=""

function usage() {
    echo "arguments in not valid "

}

function build_run() {
    if [ $# -ne 2 ]; then
        usage
        exit 1
    fi
    echo $1
    echo $2
    case $1 in
    $YP)
        yocto_build $2
        echo "yocto ${2}"
        ;;
    $BR)
        buildroot_build $2
        echo "buildroot ${2}"
        ;;
    $MB)
        manual_build $2
        echo "manualbuild ${2}"
        ;;
    esac

}

while getopts ":b:d:l" option; do
    case $option in
    b)
        if [ $OPTARG != $YP ] && [ $OPTARG != $BR ] && [ $OPTARG != $MB ]; then
            usage
            exit 1
        fi
        BUILD_SYSTEM=$OPTARG
        ;;
    d)
        checkBoard $OPTARG
        ret=$?
        if [ $ret != '0' ]; then
            echo "the name of board is wrong."
            cat $LIST_TEXT_DIR
            exit 1
        fi
        BOARD=$OPTARG
        ;;
    l)
        cat $LIST_TEXT_DIR
        echo
        exit 0
        ;;
    \?)
        echo "invalid arguments"
        exit 1
        ;;
    esac
done

build_run $BUILD_SYSTEM $BOARD

exit 0
