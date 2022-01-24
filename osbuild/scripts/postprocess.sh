#!/bin/bash
set -e
set -vx
echo "Running postprocess script" 1>&2

echo "RECIPEDIR=${RECIPEDIR}" 1>&2
echo "ARTIFACTDIR=${ARTIFACTDIR}" 1>&2
echo "PWD=${PWD}" 1>&2

ls -al "${ARTIFACTDIR}"

echo "Completed ${0##*/}" 1>&2
