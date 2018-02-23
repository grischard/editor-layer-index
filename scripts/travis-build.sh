#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

SOURCE_BRANCH="gh-pages"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping build; just doing a check."
    # Using xargs to do 8 parallel checks. Not using find -exec because it always returns 0.
    find sources -name '*.geojson' | xargs -P 8 -n 8 scripts/check.py
else
    # Run our compile script
    make
fi
