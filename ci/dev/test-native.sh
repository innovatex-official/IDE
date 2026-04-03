#!/usr/bin/env bash
set -euo pipefail

help() {
  echo >&2 "  You can build the release with 'KEEP_MODULES=1 npm run release'"
  echo >&2 "  Or you can pass in a custom path."
  echo >&2 "  CODE_SERVER_PATH='/var/tmp/innovatex/innovatex-ide/bin/innovatex-ide' npm run test:integration"
}

# Make sure a innovatex-ide release works. You can pass in the path otherwise it
# will look for $RELEASE_PATH in the current directory.
#
# This is to make sure we don't have Node version errors or any other
# compilation-related errors.
main() {
  cd "$(dirname "$0")/../.."

  source ./ci/lib.sh

  local path="$RELEASE_PATH/bin/innovatex-ide"
  if [[ ! ${CODE_SERVER_PATH-} ]]; then
    echo "Set CODE_SERVER_PATH to test another build of innovatex-ide"
  else
    path="$CODE_SERVER_PATH"
  fi

  echo "Running tests with innovatex-ide binary: '$path'"

  if [[ ! -f $path ]]; then
    echo >&2 "No innovatex-ide build detected"
    echo >&2 "Looked in $path"
    help
    exit 1
  fi

  CODE_SERVER_PATH="$path" ./test/node_modules/.bin/jest "$@" --coverage=false --testRegex "./test/integration/help.test.ts"
}

main "$@"
