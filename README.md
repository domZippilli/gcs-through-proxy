# gcs-through-proxy

Shell scripts showing use of GCS through a proxy with `curl`.

## Prerequisites for GCLB with INEG

If you're using a Google Cloud load balancer with an INEG pointed to www.googleapis.com:443, this will work with the default settings, but you need to make a couple tweaks for it to work really well.

### Increase backend timeoutSecs

Either in the UI or through CLI/API, increase the [backend timeout configuration](https://cloud.google.com/load-balancing/docs/backend-service#timeout-setting) to a large number (7200 for 2 hours, for example). This timeout is the amount of time for the server to deliver a _complete_ response, so this must be the outer bound on how long you'll allow a download or upload to take.

### Add request Host header

While you can do this on the client, it's easy to add [user-defined request headers](https://cloud.google.com/load-balancing/docs/user-defined-request-headers) to the backend either through the UI or the CLI/API. Add `Host: storage.googleapis.com` to ensure that requests from this endpoint are always routed to the correct API.

## Usage

### download_through_proxy.sh

``` shell
Usage: ./download_through_proxy.sh TOKEN PROXY BUCKET OBJECT OUTPUT
After reading an OAuth2 access token from file TOKEN, downloads an object through PROXY from gs://BUCKET/OBJECT to file OUTPUT.

Get an access token from https://developers.google.com/oauthplayground/ -- Use GCS scopes.
```

You can put the token in a file called `creds/token`. The `.gitignore` in this repo already ignores `creds/`.

### upload_through_proxy.sh

```shell
Usage: ./upload_through_proxy.sh TOKEN PROXY INPUT BUCKET OBJECT
After reading an OAuth2 access token from file TOKEN, uploads from file INPUT through PROXY to gs://BUCKET/OBJECT.

Get an access token from https://developers.google.com/oauthplayground/ -- Use GCS scopes.
```

### gsutil_proxy.sh

``` shell
Usage: ./gsutil_proxy.sh PROXY GSUTIL_ARGS...
Runs a gsutil command through a proxy. You may also need to set -oBoto:https_validate_certificates:False if your cert cannot be validated.
```

Simply treat this script as you would `gsutil` but with a first argument for your proxy.
