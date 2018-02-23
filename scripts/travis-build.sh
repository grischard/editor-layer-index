#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

SOURCE_BRANCH="gh-pages"

make check

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping build; just doing a check."
else
    # Run our compile script
    make
fi
