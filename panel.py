#!/bin/python

from sys import stdout
#import time
from json import loads
import subprocess
#import threading
#import psutil
#import imaplib

ACCENT_COLOR="#c62828"
ACCENT_DARK="#b71c1c"
ACCENT_SUB_LIGHT="#d32f2f"
TEXT_COLOR="#E7E7E7"
PINK="#E91E63"
PINK_DARK="#880E4F"
PINK_MID="#AD1457"
PURPLE="#9C27B0"
PURPLE_DARK="#4A148C"
PURPLE_MID1="#6A1B9A"
PURPLE_MID2="#7B1FA2"
PURPLE_LIGHT="#AB47BC"

date_format = ["date", "+%a %b %d"]
time_format = ["date", "+%H:%M"]

def lemon_out(data, direction=False, bcolor=ACCENT_COLOR, fcolor=TEXT_COLOR):
    lout = ""

    if direction != False:
        lout += "%{" + direction + "}"

    lout += "%{F" + bcolor + "}"
    #lout += "%{B" + bcolor + "}"
    lout += " " + data + " "
    lout += "%{B-}"
    lout += "%{F-}"

    return lout.rstrip()

def get_dump_list():
    out = subprocess.check_output(["bspc", "wm", "-d"])
    return loads(out)

dump_list = get_dump_list()

def get_date():
    return lemon_out(subprocess.check_output(date_format).decode().rstrip(), "l", ACCENT_DARK)

def get_time():
    return lemon_out(subprocess.check_output(time_format).decode().rstrip())

def get_mpd():
    out = subprocess.check_output("mpc")
    song = out.decode().split('\n')[0]

    if "volume: n/a" in song:
        return ""

    state = out.decode().split('\n')[1].split(" ")[0]
    state = state[1:state.index(']')]

    state_char = ""

    if state == "paused":
        state_char = u"\uf04c"
        pass
    else:
        state_char = u"\uf04b"
        pass

    return lemon_out(state_char + " " + song.rstrip(), False, ACCENT_COLOR)

def get_workspaces():
    lout = "%{c}"

    # Support for one monitor atm
    desktops = dump_list["monitors"][0]["desktops"];
    currently_focused = int(subprocess.check_output(["bspc", "query", "--desktops", "--desktop", "focused"]).decode().rstrip(), 16)

    for i in desktops:
        if currently_focused == i["id"]:
            lout += lemon_out(i["name"], False, PINK_MID, "#000000")
        elif i["root"] != None:
            lout += lemon_out(i["name"], False, PINK_DARK)
        else:
            lout += lemon_out(i["name"], False, PINK)

    return lout

def get_cpu_usage():
    cpu_usage = subprocess.check_output(["ps",  "-eo", "pcpu"]).decode().split('\n')

    cpu_usage.remove(cpu_usage[0])
    cpu_usage.remove(cpu_usage[len(cpu_usage) - 1])

    totol_usage = 0
    for i in cpu_usage:
        totol_usage += float(i.strip(" "))

    return lemon_out(str(round(totol_usage, 2)) + "%", False, PURPLE_MID2)

def get_temps():
    temps = subprocess.check_output(["sensors -u | grep temp1_input"], shell=True).decode().split('\n')

    gpu_temp = round(float(temps[0].strip(" ")[13:]), 2)
    cpu_temp = round(float(temps[1].strip(" ")[13:]), 2)

    return lemon_out(str(cpu_temp) + u"\u00B0" + "C", False, PURPLE_MID1) + lemon_out(str(gpu_temp) + u"\u00B0" + "C", False, PURPLE_DARK)

def get_current_vol():
    current_vol = subprocess.check_output(["amixer", "sget", "Master", "|", "tail", "-n", "1"]).decode().rstrip()
    current_vol = current_vol[current_vol.index('[') + 1:current_vol.index('%')]

    return lemon_out(current_vol + "%", "r", PURPLE)

import keyring

# # Hi, you've got mail!
# def get_mail():
#     mail = imaplib.IMAP4_SSL("mail.autistici.org")
#     (retcode, capabilities) = mail.login("kzer-za@cryptolab.net",
#                                          keyring.get_password("mail", "kzer-za@cryptolab.net"))
#     mail.list()
#     mail.select('inbox')

#     (retcode, messages) = mail.search(None, '(UNSEEN)')

#     if retcode == 'OK':
#         return lemon_out(str(len(messages[0].split())), "r", PURPLE_LIGHT)
#     else:
#         return lemon_out("null", "r", PURPLE_LIGHT)

def get_mail_lemonbar():
    pass

def render_panel():
    current_list = ""

    # Left
    current_list += get_date()
    current_list += get_time()
    current_list += get_mpd()

    # Center
    current_list += get_workspaces()

    # Right
    #current_list += get_mail()
    current_list += get_current_vol()
    current_list += get_cpu_usage()
    current_list += get_temps()

    stdout.write(current_list + "\n")
    stdout.flush()

render_panel()
