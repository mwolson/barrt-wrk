#!/bin/bash

modules=$(dirname "$(caller | awk '{ print $2; }')")/node_modules

if test ! -f "$modules"/barrt/setup.sh; then echo "Error: peer dependency 'barrt' not installed"; exit 1; fi
if ! define_side_a 2>/dev/null; then echo "Error: 'barrt' was not sourced yet"; exit 1; fi

_inspect_next_wrk=
wrk_output=

function inspect_next_wrk() {
    _inspect_next_wrk=true
}

function record_wrk() {
    _reset_assertion_state
    wrk_output=$(wrk "$@")
    local status=$?
    addl_text=$wrk_output

    if test -n "$_inspect_next_wrk"; then
        _inspect_next_wrk=
        soft_fail "Inspecting wrk command invoked like:$(echo_quoted wrk "$@")"
    fi

    if test $status -ne 0; then
        fail "wrk command failed with status code $status"
    fi
}

function expect_wrk_socket_errors() {
    local dropped=$(<<< "$wrk_output" grep -i 'socket errors' | sed 's/^ +//')
    define_side_a "$dropped"
    define_side_a_text "number of socket errors counted by wrk"
    define_addl_text "wrk socket errors:\n${dropped}\n\nwrk output:\n$wrk_output"
}
