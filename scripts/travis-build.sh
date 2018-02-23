#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

SOURCE_BRANCH="gh-pages"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping build; just doing a check."
    # Using xargs to do 8 parallel checks. Not using find -exec because it always returns 0.
    find sources -name '*.geojson' | xargs -0 -P 8 -n 1 scripts/convert_xml.py
else
    # Run our compile script
    make
    # If there are no changes to the compiled out (e.g. this is a README update) then just bail.
    if diff -q <(git diff -G "^\s*\"generated") <(git diff); then
        echo "No changes to the imagery files on this push; not deploying."
    else
        # Deploy if we reach this far
        touch .deploy
    fi
fi
