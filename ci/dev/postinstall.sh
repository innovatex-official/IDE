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

  install-deps test
  install-deps test/e2e/extensions/test-extension
  if [[ ! -f lib/vscode/package.json ]]; then
    echo "lib/vscode/package.json is missing; updating submodules..."
    git submodule update --init --recursive --depth 1
  fi

  # Apply patches if not already applied
  if [[ ! -f lib/vscode/.patched ]]; then
    echo "Applying patches to lib/vscode..."
    for patch in $(cat patches/series); do
      patch -p1 -d lib/vscode < "patches/$patch"
    done
    touch lib/vscode/.patched
  fi

  if [[ ! ${SKIP_SUBMODULE_DEPS-} ]]; then
    install-deps lib/vscode
  fi
}

main "$@"
