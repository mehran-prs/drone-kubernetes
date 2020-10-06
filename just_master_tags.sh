#!/usr/bin/env bash
# Check [this link](https://travis-ci.community/t/only-build-tags-that-are-on-the-master-branch/10081)

# if travis_tag is not set or is empty
if [[ -z $TRAVIS_TAG ]]; then
 exit 1    # quit the build
fi
# Travis does a shallow clone by default
# so `master` is not present in the local metadata
# in a build for another branch
git fetch origin master:master
if ! (git branch --contains "$TRAVIS_TAG" | grep -qxE '. master'); then
    exit 1    # quit the build early
fi