#!/bin/bash
wid=$(xdotool search --name "$1")
id=$(xdotool getwindowpid "$wid")
cat /proc/$id/cmdline 
