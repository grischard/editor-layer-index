#!/bin/sh
# Check if the imagery files needs to be deployed
# If there are no changes to the compiled out except the generated date (e.g. this is a README update) then just bail.
if diff <(git show HEAD:./imagery.geojson | sed -e "s/\"generated\":\"[-: 0-9]*\"//") <(sed -e "s/\"generated\":\"[-: 0-9]*\"//" imagery.geojson) &>/dev/null; then
    echo "No changes to the imagery files on this push; not deploying."
    exit 1
fi
