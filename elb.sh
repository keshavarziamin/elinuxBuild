#! /bin/bash
BUILDROOT_DIR=buildtools/buildroot
source ${BUILDROOT_DIR}/buildroot.sh
source buildtools/install_essential.sh

function usage() {
    echo
    echo "Usage: $0 [-B|--buildroot <config>] [-c|--config <config>] [menuconfig]"
    echo "Usage: $0 [-B|--buildroot] <-C|--clean>" 
    echo "Usage: $0 [-B|--buildroot] <-l|--list>"
    echo
    echo "Options:"
    echo "-B, --buildroot   Build the root filesystem"
    echo "-c, --config      Build the specified configuration"
    echo "-l, --list        List the supported configurations"
    echo "-C, --clean       remove all output fiels and images
    echo "menuconfig        Show menu configuration"
    echo
    echo "Examples:"
    echo "$0 --buildroot --config my_config"
    echo "$0 -B -c my_config menuconfig"
    echo "$0 -B -l"
    echo "$0 -B --list" 
    echo "$0 -B --clean" 
    echo
}

VALID_ARGS=$(getopt -o :B: --long buildroot: -- "$@")

if [ $? -ne 0 ]; then
    echo_err "The arguments are not valid"
    usage 1>&3
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
    usage 1>&3
    exit ${ERROR}
    ;;
esac
exit 0
