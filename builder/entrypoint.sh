#!/bin/bash
if [[ "${1}" == /bin/bash || "${1}" == "bash" ]]; then
    shift
    if (( $# )); then
        exec bash "${@}"
    else
        exec bash
    fi
else
    set -vx
    #exec debos "${@}"
    chmod a+rwX /artifacts
    exec /usr/local/bin/debos "${@}"
fi
