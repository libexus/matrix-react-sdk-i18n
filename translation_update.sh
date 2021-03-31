#!/usr/bin/env bash

# If you want to edit this, use the `update_script` branch! Otherwise the changes will be ignored!

if [ -z "$1" ]; then echo "Usage: $0 <path to translation zipfile> [push]";exit 1;fi

ORIG_DIR=$PWD

# Extract Translations
unzip "$1" -d /tmp/$PPID

# Get upstream source code
cd `dirname "$0"`
git checkout develop
git fetch "https://github.com/matrix-org/matrix-react-sdk"
git reset --hard FETCH_HEAD

# Update Translations
cp -f /tmp/$PPID/element-web/matrix-react-sdk/src/i18n/strings/* ./src/i18n/strings
git commit -a -m "Update translations: `date +%d.%m.%Y`"

git merge update_script -m "Restore update script"

# Update repo
if [ "$2" == "push" ]; then git push -f; fi

cd $ORIG_DIR
