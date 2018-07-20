#!/bin/bash

build_test() {
  printf "** %s **\n" "$1"
  cargo clean
  which "${RUBY:-ruby}"
  ${RUBY:-ruby} -v
  ${RUBY:-ruby} -e 'puts "ENABLE_SHARED = " + RbConfig::CONFIG["ENABLE_SHARED"] '
  cargo run --quiet --example eval 'puts "Success to build"'
  if cat target/debug/build/rutie-*/output | grep 'use ruby_pc' > /dev/null; then
      echo "build with pkg-config"
  else
      echo "build without pkg-config"
  fi
  sleep 1
  echo
}

RUBY=/usr/bin/ruby build_test "Build-in"
RUBY=/usr/local/bin/ruby build_test "Homebrew"
RBENV_VERSION=2.3.6 build_test "rbenv 2.3.6"
RBENV_VERSION=2.3.7 build_test "rbenv 2.3.7"
RBENV_VERSION=2.5.0 build_test "rbenv 2.5.0"
RBENV_VERSION=2.5.1 build_test "rbenv 2.5.1"
