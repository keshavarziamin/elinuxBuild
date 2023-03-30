#! /bin/bash

while getopts ":b:d:" option; do
    case $option in
    b)
        echo "stating building with $OPTARG"
        ;;
    d)
        echo "your device is $OPTARG"
        ;;
    \?)
        echo "invalid arguments"
        exit 1
        ;;
    esac
done
exit 0
