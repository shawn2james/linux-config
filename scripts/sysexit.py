#!/usr/bin/env python3

from os import system
import dmenu

actions=["shutdown", "reboot", "suspend", "logout", "turn off monitor"]
action = dmenu.show(
    items=actions,
    prompt="Select action: ",
    lines = len(actions),
    case_insensitive=True
)

if(action=="shutdown"):
    system("systemctl poweroff")
elif(action=="reboot"):
    system("systemctl reboot")
elif(action=="suspend"):
    system("systemctl suspend")
elif(action=="logout"):
    system("pkill xmonad")
elif(action=="turn off monitor"):
    system("xset dpms force off")
