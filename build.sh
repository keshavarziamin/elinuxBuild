#! /bin/bash

exec 3>&1 1>>log.out 2>&1

source buildtools/listboars.sh
source buildtools/buildroot.sh
source buildtools/install_essential.sh

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
    case $1 in
    $YP)
        echo "yocto ${2}"
        yocto_build $2
        ;;
    $BR)
        echo "buildroot ${2}"
        buildroot_build $2
        ;;
    $MB)
        echo "manualbuild ${2}"
        manual_build $2
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



echo "install essential libraries --> start" >> result.out 
install_essential 
if [ $? -ne 0 ]; then
    exit 1
fi
echo "install essential libraries --> succeeded" >> result.out

echo "building --> start" >> result.out 
build_run $BUILD_SYSTEM $BOARD
if [ $? -ne 0 ]; then
    exit 1
fi
echo "building  --> succeeded" >> result.out

exit 0
