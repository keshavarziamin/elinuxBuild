#! /bin/bash
BUILDROOT_DIR=buildtools/buildroot
source ${BUILDROOT_DIR}/buildroot.sh
source buildtools/install_essential.sh

YP="yocto"
BR="buildroot"
MB="manual"

LIST_TEXT_DIR="buildtools/list_of_boards.txt"

BUILD_SYSTEM=""
CONFIG=""
MENUCONFIG=""

function usage() {
    echo "USAGE: arguments in not valid "
}


VALID_ARGS=$(getopt -o B: --long buildroot: -- "$@")

if [ $? -ne 0 ]; then
    echo_err "the arguments are not valid"
    usage
    exit ${ERROR}
fi

eval set -- "$VALID_ARGS"

case "$1" in
-B | --buildroot)
    buildroot_run $@
    ;;
esac
exit 0
