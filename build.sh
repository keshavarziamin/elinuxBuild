#! /bin/bash
source error_handler/errhdl.sh
source buildtools/listboars.sh
source buildtools/buildroot.sh
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
    if [ $# -ne 2 ]; then
        usage 1>&3
        echo_return $ERROR "The arguments are wrongs"
    fi
    case $1 in
    $BR)
        echo "buildroot ${2}"
        buildroot_build $2
        ;;
    *)
        echo_return $ERROR "please choose a correct build system"
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
        debug checkBoard $OPTARG
        BOARD=$OPTARG
        ;;
    l)
        cat $LIST_TEXT_DIR 1>&3
        echo
        exit 0
        ;;
    \?)
        echo "invalid arguments"
        exit 1
        ;;
    esac
done

debug install_essential
debug build_run $BUILD_SYSTEM $BOARD

exit 0
