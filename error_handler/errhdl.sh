#! /bin/bash
exec 3>&1 1>>log.out 2>&1

source error_handler/bash_color.sh

function debug() {
    current_clock=
    tstart=$(date +%s)
    print "run ${1} >> ${G}START TIME: ${Y}$(date +"%T")${NC}\n"
    
    func=${1}
    shift
    $func $@ #run function with other arguments
    err=$?
    tend=$(date +%s)
    tdiff=$((tend - tstart))
    print "${G}EXECUTION TIME${NC}: ${Y}$tdiff${NC} seconds."
    echo_return $err
}

echo_info() {
    print "${B}INFO${NC}" "${1}"
}

echo_err() {
    echo -e "${R}ERROR${NC}" "${1}" >&3
}

echo_failed() {
    printl "${R}FAILED${NC}" "${1}"
}

echo_warnnig() {

    print "${Y}WARNNIG${NC}" "${1}"
}

echo_success() {

    printl "${G}SUCCESS${NC}" "${1}"
}

echo_return() {
    err=${1}
    msg=${2}
    if [ ${err} != 0 ]; then
        echo_failed "${msg}\n"
        echo_err "$0:$err"
        echo_err "You can check the error in the ${Y}output.log${NC}"
        exit ${err}
    fi
    echo_success "${msg}"
}

echoc() {
    printf "${1}${2} ${NC}" >&3
}

function printl() {
    print ${1} ${2}
    printf "\n" >&3
}

function print() {

    printf "${1} " >&3
    if [ $# -eq 3 ]; then
        printf ":: ${2} " >&3
    fi
}
