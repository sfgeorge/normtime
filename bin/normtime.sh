#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

source $(dirname "$0")/_include_normtime.sh

normtime "$@"
