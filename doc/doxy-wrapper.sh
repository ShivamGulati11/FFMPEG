#!/bin/sh

set -eu

OUT_DIR="${1}"
SRC_DIR="${2}"
DOXYFILE="${3}"
DOXYGEN="${4}"

shift 4

cd "${SRC_DIR}"

if [ -e "VERSION" ]; then
    VERSION=`cat "VERSION"`
else
    VERSION=`git describe`
fi

# Variables in heredoc are used for Doxygen config format, not shell expansion
# $@ intentionally unquoted to expand to space-separated paths for INPUT field
"${DOXYGEN}" - <<EOF
@INCLUDE        = ${DOXYFILE}
INPUT           = $@
HTML_TIMESTAMP  = NO
PROJECT_NUMBER  = ${VERSION}
OUTPUT_DIRECTORY = ${OUT_DIR}
EOF
