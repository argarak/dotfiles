#!/usr/bin/env python3

#################################################
#                                               #
# Welcome to my lemonbar script!                #
#                                               #
# To build it, run                              #
#     python setup_panel.py build_ext --inplace #
#                                               #
# this will compile it via cython, then use     #
#     python start_new_panel.py                 #
#                                               #
# to execute the script.                        #
#                                               #
#################################################

################################################################################################################
#                                                                                                              #
# You will need to create a socat stream for this script to function correctly.                                #
# Create the stream by running this at startup:                                                                #
#     socat -d -d pty,raw,echo=0,link=/tmp/lemonbarin pty,raw,echo=0,link=/tmp/lemonbarout &                   #
#                                                                                                              #
# And for creating lemonbar itself:                                                                            #
#     cat /tmp/lemonbarin | lemonbar -p -g 1920x24+0+0 -d -f "ypn envypn" -f FontAwesome-10 -b -B \#FF070707 & #
#                                                                                                              #
# Feel free to change the colours or fonts and adjust the screen size if needed.                               #
#                                                                                                              #
################################################################################################################

from daemonize import Daemonize
from mpd import MPDClient
from pathlib import Path
from json import loads
import subprocess
import alsaaudio
import notify2
import serial
import psutil
import time

mpd_client = MPDClient()
mpd_client.timeout = 10
mpd_client.idletimeout = None

# Change this if MPD music is in another directory
MUSIC_DIRECTORY=str(Path.home()) + "/Music"

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

date_format = "%a %b %d"
time_format = "%H:%M"

def lemon_out(data, direction=False, bcolor=ACCENT_COLOR, fcolor=TEXT_COLOR):
    lout = ""

    if direction != False:
        lout += "%{" + direction + "}"

    lout += "%{F" + bcolor + "}"
    lout += " " + data + " "
    lout += "%{B-}"
    lout += "%{F-}"

    return lout.rstrip()

def get_dump_list():
    out = subprocess.check_output(["bspc", "wm", "-d"])
    return loads(out)

dump_list = get_dump_list()

def get_date():
    return lemon_out(time.strftime(date_format), "l", ACCENT_DARK)

def get_time():
    return lemon_out(time.strftime(time_format))

current_song = {}

def get_mpd():
    global current_song

    if not mpd_client.currentsong():
        return ""

    if mpd_client.currentsong() != current_song:
        current_song = mpd_client.currentsong()

        cover_path = ""
        
        cover_dir = current_song['file']
        cover_dir = cover_dir[:cover_dir.rfind('/')]

        song_files = mpd_client.listfiles(cover_dir)
        image_types = [".jpg", ".jpeg", ".png"]

        for song_file in song_files:
            file_type = ""
            if 'file' in song_file:
                file_type = song_file['file'][song_file['file'].rfind('.'):]

            if file_type in image_types:
                cover_path = MUSIC_DIRECTORY + "/" + cover_dir + "/" + song_file['file']

        artist = ""
        if 'artist' in current_song:
            artist = current_song['artist'] + " - "

        album = ""
        if 'album' in current_song:
            album = current_song['album']
        else:
            album = cover_dir

        if not cover_path.strip():
            cover_path = "media-playback-start"

        title = ""
        if 'title' in current_song:
            title = current_song['title']
        else:
            title = current_song['file']


        n = notify2.Notification(artist + title,
                                 album,
                                 cover_path)
        n.close()
        n.set_timeout(2000)
        n.show()
    else:
        current_song = mpd_client.currentsong()

        artist = ""
        if 'artist' in current_song:
            artist = current_song['artist'] + " - "

        title = ""
        if 'title' in current_song:
            title = current_song['title']
        else:
            title = current_song['file']


    state_char = ""
    status = mpd_client.status()

    if status['state'] == "pause":
        state_char = u"\uf04c"
    else:
        state_char = u"\uf04b"

    if status['state'] != "stop":
        return lemon_out(state_char + " " + artist + title, False, ACCENT_COLOR)
    else:
        return ""

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
    return lemon_out(str(round(psutil.cpu_percent())).rjust(3) + "%", False, PURPLE_MID2)

def get_temps():
    temps = subprocess.check_output(["sensors -u | grep temp1_input"], shell=True).decode().split('\n')

    gpu_temp = round(float(temps[0].strip(" ")[13:]), 2)
    cpu_temp = round(float(temps[1].strip(" ")[13:]), 2)

    return lemon_out(str(cpu_temp).rjust(5) + u"\u00B0" + "C", False, PURPLE_MID1) + lemon_out(str(gpu_temp).rjust(5) + u"\u00B0" + "C", False, PURPLE_DARK)

def get_current_vol():
    m = alsaaudio.Mixer()
    return lemon_out(str(m.getvolume()[0]) + "%", False, PURPLE)

import keyring
import imaplib

mail_count = ""

# Hi, you've got mail!
#
# You will need to create keyrings for this to work with python-keyring cli:
# keyring set mail address_imap_1 <mail_server>
# keyring set mail address_1 <user@host.tld>
# keyring set mail <user@host.tld> <password for email>
#
def get_mail():
    global mail_count

    if (int(time.strftime("%M")) % 15 == 0) or (not mail_count):
        mail = imaplib.IMAP4_SSL(keyring.get_password("mail", "address_imap_1"))
        address = keyring.get_password("mail", "address_1")

        (retcode, capabilities) = mail.login(address,
                                             keyring.get_password("mail", address))
        mail.list()
        mail.select('inbox')

        (retcode, messages) = mail.search(None, '(UNSEEN)')

        mail_count = str(len(messages[0].split()))

        if retcode == 'OK':
            return lemon_out(mail_count, "r", PURPLE_LIGHT)
        else:
            return lemon_out("null", "r", PURPLE_LIGHT)

    return lemon_out(mail_count, "r", PURPLE_LIGHT)

def get_mail_lemonbar():
    pass

# Uncomment the bar elements you don't want but watch out, as alignment may
# change so pass the "r", "l" or "c" parameter to lemon_out to the first bar
# element which will be aligned, the ones after that don't need to have this
# parameter after that.
def render_panel():
    current_list = ""

    # Left
    current_list += get_date()
    current_list += get_time()
    current_list += get_mpd()

    # Center
    current_list += get_workspaces()

    # Right
    current_list += get_mail()
    current_list += get_current_vol()
    current_list += get_cpu_usage()
    current_list += get_temps()

    return current_list

pid = "/tmp/panel.pid"

def main():
    mpd_client.connect("localhost", 6600)
    notify2.init("paneld")
    s = serial.Serial('/tmp/lemonbarout')

    while True:
        s.write(render_panel().encode() + "\r\n".encode())
        time.sleep(1)

if __name__ == '__main__':
    mpd_client.connect("localhost", 6600)
    notify2.init("paneld")
    s = serial.Serial('/tmp/lemonbarout')
    s.write(render_panel().encode() + "\r\n".encode())
