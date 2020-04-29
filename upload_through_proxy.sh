#!/usr/bin/env bash

# Display function usage
function usage(){
    echo >&2
    echo "Usage: $0 TOKEN PROXY INPUT BUCKET OBJECT" >&2
    echo "After reading an OAuth2 access token from file TOKEN, uploads from file INPUT through PROXY to gs://BUCKET/OBJECT." >&2
    echo >&2
    echo "Get an access token from https://developers.google.com/oauthplayground/ -- Use GCS scopes." >&2
    echo >&2
}

TOKEN_FILE="${1?$(usage)}"
GCS_PROXY_HOST="${2?$(usage)}"
INPUT="${3?$(usage)}"
BUCKET="${4?$(usage)}"
OBJECT="${5?$(usage)}"

# Get this from https://developers.google.com/oauthplayground/ -- Use GCS scopes
OAUTH2_ACCESS_TOKEN=$(< ${TOKEN_FILE})

curl \
  -k \
  -X POST \
  --data-binary @"${INPUT}" \
  -H "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
  -H "Host: storage.googleapis.com" \
  "https://${GCS_PROXY_HOST}/upload/storage/v1/b/${BUCKET}/o?uploadType=media&name=${OBJECT}"
