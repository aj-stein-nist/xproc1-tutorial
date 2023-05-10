#!/usr/bin/env bash

# Fail early if an error occurs
set -Eeuo pipefail

usage() {
    cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") CATALOG_XML RESULT_PDF [ADDITIONAL_ARGS]

Transforms and formats an OSCAL XML Catalog into PDF using Saxon, FOP and XML Calabash invoked from Maven.
Please install Maven first.

Additional arguments should be specified in the `key=value` format.
EOF
}

if ! [ -x "$(command -v mvn)" ]; then
  echo 'Error: Maven (mvn) is not in the PATH, is it installed?' >&2
  exit 1
fi

[[ -z "${1-}" ]] && { echo "Error: No XProc pipeline given"; usage; exit 1; }
PIPELINE=$1

ADDITIONAL_ARGS=$(shift 1; echo ${*// /\\ })

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
POM_FILE="${SCRIPT_DIR}/pom.xml"

MAIN_CLASS="com.xmlcalabash.drivers.Main" # XML Calabash

mvn \
    -f "$POM_FILE" \
    exec:java \
    -Dexec.mainClass="$MAIN_CLASS" \
    -Dcom.xmlcalabash.fo-processor="com.xmlcalabash.util.FoFOP" \
    -Dexec.args="$ADDITIONAL_ARGS \"$PIPELINE\""
