#!/usr/bin/env bash

# Display function usage
function usage(){
    echo >&2
    echo "Usage: $0 TOKEN PROXY BUCKET OBJECT OUTPUT" >&2
    echo "After reading an OAuth2 access token from file TOKEN, downloads an object through PROXY from gs://BUCKET/OBJECT to file OUTPUT." >&2
    echo >&2
    echo "Get an access token from https://developers.google.com/oauthplayground/ -- Use GCS scopes." >&2
    echo >&2
}

TOKEN_FILE="${1?$(usage)}"
GCS_PROXY_HOST="${2?$(usage)}"
BUCKET="${3?$(usage)}"
OBJECT="${4?$(usage)}"
OUTPUT="${5?$(usage)}"

# Get this from https://developers.google.com/oauthplayground/ -- Use GCS scopes
OAUTH2_ACCESS_TOKEN=$(< ${TOKEN_FILE})

curl --verbose \
  -http2-prior-knowledge \
  -k \
  -H "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
  -o "${OUTPUT}" \
  "https://${GCS_PROXY_HOST}/storage/v1/b/${BUCKET}/o/${OBJECT}?alt=media"
