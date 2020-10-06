#!/usr/bin/env bash
# Check [this link](https://travis-ci.community/t/only-build-tags-that-are-on-the-master-branch/10081)

if [[ -n $TRAVIS_TAG ]]; then
  # Travis does a shallow clone by default
  # so `master` is not present in the local metadata
  # in a build for another branch
  git fetch origin master:master
  if ! (git branch --contains "$TRAVIS_TAG" | grep -qxE '. master'); then
    travis_terminate 0    # quit the build early
  fi
fi