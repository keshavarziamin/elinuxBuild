#! /bin/bash
BUILDROOT_DIR=buildtools/buildroot
source ${BUILDROOT_DIR}/buildroot.sh
source buildtools/install_essential.sh

function usage() {
    echo "USAGE: arguments in not valid "
}

VALID_ARGS=$(getopt -o :B: --long buildroot: -- "$@")

if [ $? -ne 0 ]; then
    echo_err "the arguments are not valid"
    usage
    exit ${ERROR}
fi

eval set -- "$VALID_ARGS"

case "$1" in
-B | --buildroot)
    shift
    buildroot_run $@
    ;;
: | * | \?)
    echo_err "The arguments are not valid"
    usage
    exit ${ERROR}
    ;;
esac
exit 0
