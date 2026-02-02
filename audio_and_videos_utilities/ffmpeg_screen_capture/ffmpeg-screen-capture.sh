#!/usr/bin/env bash
#
#TODO I need to edit this a little bit more, specifically I want to have it 
#print its process ID somewhere so I can delete it later. If I print it in a file, then
#I'd want to print the file, If I print it in stdin, then I don't need a file.
#I also need it to capture audio in addition to video.
#
#TODO pid 
#TODO audio

# conf vars
output_file="$HOME/Videos/screen_recordings/screen_recording_at_$(print-screenshot-name).mp4"
microphone_source='alsa_input.pci-0000_00_1b.0.analog-stereo'
application_source='alsa_output.pci-0000_00_1b.0.analog-stereo.monitor'
capture_sink="ffmpeg_capture_$(print-screenshot-name)"
 
# initialize audio 
# taken from https://superuser.com/questions/236877/how-to-record-from-two-audio-sources-simultaneously-in-ffmpeg
# and from https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#module-null-sink

# https://superuser.com/questions/1816493/how-to-capture-two-audio-sources-on-separate-tracks-with-ffmpeg may be a better way to do this. 
output_sink_fd="$(pactl load-module module-null-sink sink_name="$capture_sink")"
loopback_microphone_fd="$(pactl load-module module-loopback source="$microphone_source" sink="$capture_sink")"
loopback_application_fd="$(pactl load-module module-loopback source="$application_source" sink="$capture_sink")"

# Every sink has a source that echos what it says called monitor
output_source="$capture_sink.monitor"
# Record video
ffmpeg -f x11grab -framerate 30 -i "$DISPLAY" \
	-f pulse -ac 2 -i "$output_source" \
	"$output_file"

# Remove audio capture stuff
# output_sink_fd should be removed last probably
for i in "$loopback_microphone_fd" "$loopback_application_fd" "$output_sink_fd"
	do 
		pactl unload-module "$i"
	done
