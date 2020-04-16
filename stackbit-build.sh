#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e97b3cd090c1d0019396c6b/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e97b3cd090c1d0019396c6b 
fi
curl -s -X POST https://api.stackbit.com/project/5e97b3cd090c1d0019396c6b/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://api.stackbit.com/project/5e97b3cd090c1d0019396c6b/webhook/build/publish > /dev/null
