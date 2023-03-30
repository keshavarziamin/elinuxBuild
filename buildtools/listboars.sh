#!/bin/bash
list=("qemu_aarch64_virt_defconfig")

function checkBoard() {
    for name in ${list[@]}; do
        if [ $name = ${1} ]; then
            return 0
        fi
    done
    return 1
}


