#!/usr/bin/env bash

# Display function usage
function usage(){
    echo >&2
    echo "Usage: $0 PROXY GSUTIL_ARGS..." >&2
    echo "Runs a gsutil command through a proxy. You may also need to set -oCredentials:gs_json_host_header=HOST_HEADER_VALUE if your proxy does not add this header, and/or -oBoto:https_validate_certificates:False if your cert cannot be validated." >&2
    echo >&2
}

PROXY="${1?$(usage)}"

CMD="gsutil -m -oCredentials:gs_json_host=${PROXY}"
shift
$CMD "$@"
