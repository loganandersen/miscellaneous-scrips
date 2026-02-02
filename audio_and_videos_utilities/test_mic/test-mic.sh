#!/usr/bin/env bash
# /home/loga/Documents/programs/laptop/shell/audio_and_videos_utilities/test_mic/test-mic.sh
# July 06 2025

# This makes your microphone play out of your speakers. It assumes you are using
# a default microphone with default speakers with my thinkpad t400
# IDK if it works on other things
descriptor="$(pactl load-module module-loopback source=alsa_input.pci-0000_00_1b.0.analog-stereo sink=alsa_output.pci-0000_00_1b.0.analog-stereo)"
trap "pactl unload-module $descriptor" TERM INT
echo $descriptor
sleep infinity

