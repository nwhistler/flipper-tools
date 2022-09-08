# MAC OS Key Remapper

What better way to piss someone off then to remap some keys. This script uses the built in hidutil to modify the plist file to remap whatever keys you like.

I have the `STRING` running the command as a single line which seems to work well. Here below is the expanded command which you can add whatever keys you like:

``` hidutil property --set '{"UserKeyMapping":
    [
            {
              "HIDKeyboardModifierMappingSrc": 0x700000004,
              "HIDKeyboardModifierMappingDst": 0x700000016
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x700000016,
              "HIDKeyboardModifierMappingDst": 0x700000004
            }
        ]
}'
```
and of course, here is how to undo it:

``` ~  hidutil property --set '{"UserKeyMapping":                ok | system node
    [
            {
              "HIDKeyboardModifierMappingSrc": 0x700000004,
              "HIDKeyboardModifierMappingDst": 0x700000004
            },
            {
              "HIDKeyboardModifierMappingSrc": 0x700000016,
              "HIDKeyboardModifierMappingDst": 0x700000016
            }
        ]
}'
```

If you really wanted to be a jerk, you could remap every key to dvorak layout. See below in the references for the Hex for each key.


**Note:** 

**This does revert on restart so if you get a real bind, you can restart and get back to normal.**



## References
https://developer.apple.com/library/archive/technotes/tn2450/_index.html

https://hidutil-generator.netlify.app/ - Special thanks [amarsyla](https://github.com/amarsyla/hidutil-key-remapping-generator) for the quick easy mode for generating the json.
