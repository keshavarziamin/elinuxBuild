#! /bin/bash
BUILDROOT_DIR=buildtools/buildroot
source ${BUILDROOT_DIR}/buildroot.sh
source buildtools/install_essential.sh

YP="yocto"
BR="buildroot"
MB="manual"


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
        print "build system: buildroot\n"
        print "board : ${2}\n"
        buildroot_buildKernel $2
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
            debug buildroot_isBoradValid $OPTARG
            BOARD=$OPTARG
            ;;
        l)
            print "The list of baords suppoeted\n" 
            buildroot_printList
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
