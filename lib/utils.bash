#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/wren-lang/wren-cli"

fail() {
  echo -e "asdf-wren-cli: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  list_github_tags
}

download_release() {
  local version platform filename url
  platform="$1"
  version="$2"
  filename="$3"

  url=$(curl -s https://api.github.com/repos/wren-lang/wren-cli/releases | grep "browser_download_url.*" | grep "${version}" | grep "${platform}" | cut -d : -f 2,3 | tr -d \" | xargs echo -n)

  echo "* Downloading wren-cli release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-wren-cli supports release installs only"
  fi

  local platform

  case "$OSTYPE" in
    darwin*) platform="mac" ;;
    linux*) platform="linux" ;;
    *) fail "Unsupported platform" ;;
  esac

  local release_file="$install_path/wren-cli-$platform-$version.zip"
  (
    mkdir -p "$install_path/bin"
    download_release "$platform" "$version" "$release_file"
    unzip -j "$release_file" -d "$install_path/bin" || fail "Could not extract $release_file"
    rm "$release_file"

    test -x "$install_path/bin/wren_cli" || fail "Expected $install_path/bin/wren_cli to be executable."

    echo "wren-cli $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing wren-cli $version."
  )
}
