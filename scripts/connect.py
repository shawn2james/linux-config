#!/usr/bin/env python3

import dmenu
from os import system
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("devices", help="provide available devices")

devices = parser.parse_args().devices
devices = devices.split("\n")

selected_device = dmenu.show(
    items=devices,
    prompt="Select device: ",
    lines=5,
    case_insensitive=True
)
selected_device = selected_device.split(' ')[1]

system(f"bluetoothctl connect {selected_device}")
