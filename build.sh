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
        print "CONFIG : ${2}\n"
        cd ${BUILDROOT_SRC_DIR}
        buildroot_buildKernel $2
        cd ${ROOT_DIR}
        ;;
    *)
        echo_return $ERROR "please choose a correct build system"
        ;;
    esac
}

function get_options() {

    while getopts ":b:c:l:" option; do

        set -f;
        listarg=($2) #get list of arguments

        case $option in

        b) # build
            if [ $OPTARG != $YP ] && [ $OPTARG != $BR ] && [ $OPTARG != $MB ]; then
                usage
                exit 1
            fi
            BUILD_SYSTEM=$OPTARG
            ;;

        c) # config
            # debug buildroot_isBoradValid "\${$((OPTIND))}"
            CONFIG=$((OPTIND))
            # shift
            # MENUCONFIG=$OPTARG
            # for i in $OPTARG;do
            # printl $i
            # done
            printl "${$CONFIG}\n"
            exit 0
            ;;

        l) # list of configs
            print "The list of baords suppoeted\n"

            case $OPTARG in

            $BR)
                cd ${BUILDROOT_SRC_DIR}
                buildroot_printList
                cd ${ROOT_DIR}
                exit 0
                ;;

            *)
                echo_err "invalid arguments"
                usage
                exit 1
                ;;
            esac
            ;;

        * | :)
            echo_err "invalid arguments"
            usage
            exit 1
            ;;
        esac
    done

}

get_options $@
# debug install_essential
# cd ${BUILDROOT_SRC_DIR}
# debug build_run $BUILD_SYSTEM $CONFIG $MENUCONFIG
# cd ${ROOT_DIR}
exit 0
