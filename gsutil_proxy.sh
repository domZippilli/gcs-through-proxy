#!/usr/bin/env bash

# Display function usage
function usage(){
    echo >&2
    echo "Usage: $0 PROXY GSUTIL_ARGS..." >&2
    echo "Runs a gsutil command through a proxy. You may also need to set -oBoto:https_validate_certificates:False if your cert cannot be validated." >&2
    echo >&2
}

PROXY="${1?$(usage)}"

CMD="gsutil -m -oCredentials:gs_json_host_header=storage.googleapis.com -oCredentials:gs_host_header=storage.googleapis.com -oCredentials:gs_json_host=${PROXY} -oCredentials:gs_host=${PROXY}"
shift
$CMD "$@"
