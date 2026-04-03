#!/usr/bin/env bash
set -euo pipefail

# Install dependencies in $1.
install-deps() {
  local args=()
  if [[ ${CI-} ]]; then
    args+=(ci)
  else
    args+=(install)
  fi
  # If there is no package.json then npm will look upward and end up installing
  # from the root resulting in an infinite loop (this can happen if you have not
  # checked out the submodule yet for example).
  if [[ ! -f "$1/package.json" ]]; then
    echo "$1/package.json is missing; did you run git submodule update --init?"
    exit 1
  fi
  pushd "$1"
  echo "Installing dependencies for $PWD"
  npm "${args[@]}"
  popd
}

main() {
  cd "$(dirname "$0")/../.."
  source ./ci/lib.sh

  if [[ ! ${SKIP_TEST_DEPS-} ]]; then
    install-deps test
    install-deps test/e2e/extensions/test-extension
  fi
  if [[ ! -f lib/vscode/package.json ]]; then
    echo "lib/vscode/package.json is missing; updating submodules..."
    git submodule update --init --recursive --depth 1
  fi

  # Apply patches if not already applied
  if [[ ! -f lib/vscode/.patched ]]; then
    while read -r patch; do
      if [[ -n "$patch" ]]; then
        patch -p1 < "patches/$patch"
      fi
    done < patches/series
    touch lib/vscode/.patched
  fi

  if [[ ! ${SKIP_SUBMODULE_DEPS-} ]]; then
    # Fix all .ts scripts and gulp to use experimental-strip-types
    if [[ "$OS" == "macos" ]]; then
      sed -i '' 's/node \(build\/[a-zA-Z0-9\/._-]*\.ts\)/node --experimental-strip-types \1/g' lib/vscode/package.json
      sed -i '' 's/node --max-old-space-size=8192/node --experimental-strip-types --max-old-space-size=8192/g' lib/vscode/package.json
    else
      sed -i 's/node \(build\/[a-zA-Z0-9\/._-]*\.ts\)/node --experimental-strip-types \1/g' lib/vscode/package.json
      sed -i 's/node --max-old-space-size=8192/node --experimental-strip-types --max-old-space-size=8192/g' lib/vscode/package.json
    fi
    export VSCODE_SKIP_NODE_VERSION_CHECK=1
    install-deps lib/vscode
  fi
}

main "$@"
