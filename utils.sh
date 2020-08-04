#!/bin/bash

function fancy_echo() {
    local message="$1"; shift

    printf "$message\n" "$@"
}

function clean_run() {
    eval "$@" >> .bootstrap.log
}
