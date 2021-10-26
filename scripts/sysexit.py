#!/usr/bin/env python3

from os import system
import dmenu

actions=["1: shutdown", "2: reboot", "3: suspend", "4: logout", "5: turn off monitor"]
action = dmenu.show(
    items=actions,
    prompt="Select action: ",
    lines = len(actions),
    case_insensitive=True
)

if(action=="1: shutdown"):
    system("systemctl poweroff")
elif(action=="2: reboot"):
    system("systemctl reboot")
elif(action=="3: suspend"):
    system("systemctl suspend")
elif(action=="4: logout"):
    system("pkill xmonad")
elif(action=="5: turn off monitor"):
    system("xset dpms force off")
