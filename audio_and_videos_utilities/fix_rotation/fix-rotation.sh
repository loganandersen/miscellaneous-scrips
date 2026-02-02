#!/usr/bin/env bash

# 2025-10-09
# Logan Andersen
# This program looks at the exif orientation data of an image, does the rotation
# and removes the orientation data. 
# It takes 2 arguments, the first argument is the input file, the second is the output file.

IN="$1"
OUT="$2"

# define all the different orientation tags
# Taken from https://exiftool.org/TagNames/EXIF.html
NORMAL=1
MIRROR_HORIZONTAL=2
ROTATE_180=3
MIRROR_VERTICAL=4
MIRROR_HORIZONTAL_AND_ROTATE_270_CLOCKWISE=5
ROTATE_90_CLOCKWISE=6
MIRROR_HORIZONTAL_AND_ROTATE_90_CLOCKWISE=7
ROTATE_270_CLOCKWISE=8

function convert-command
{
	# orient top-left sets the orientation exiv value to 1
	convert -orient top-left "$@" "$IN" "$OUT" 
}

# I used the square dihedral group symmetries for some of these
# see https://en.wikipedia.org/wiki/Dihedral_group_of_order_8
# https://proofwiki.org/wiki/Dihedral_Group_D4/Cayley_Table
# Note that a^2b is a vertical flip. b is a horizontal flip.
# It turns out that https://imagemagick.org/script/command-line-options.php#orient has the rules

# if output file is non-empty (AKA we gave 2 arguments), and input file exists
if [[ -n "$OUT" && -f "$IN" ]] 
then
	num=$(exiftool -s3 -Orientation# "$IN")
	case "$num" in 
		"$NORMAL") 
			# simply copy the file over since there is no need to change anything
			cp "$IN" "$OUT" 
			;;
		"$MIRROR_HORIZONTAL") 
			# flip horizontally
			convert-command -flop 
			;;
		"$ROTATE_180")
			# rotate 180 degrees again to flip back to normal
			convert-command -rotate 180 
			;;
		"$MIRROR_VERTICAL")
			# mirror vertically 
			convert-command -flip 
			;;
		"$MIRROR_HORIZONTAL_AND_ROTATE_270_CLOCKWISE")
			# pretty sure this works transpose = a^2b + a = ab 
			# original = b + a^3 = ab
			# ab + ab = e #after transpose
			convert-command -transpose 
			;;
		"$ROTATE_90_CLOCKWISE")
			convert-command -rotate -270 
			;;
		"$MIRROR_HORIZONTAL_AND_ROTATE_90_CLOCKWISE")
			# original = b + a = a^3b 
			# transverse = b + a = a^3b
			# a^3b + a^3b = e
			convert-command -transverse 
			;;
		"$ROTATE_270_CLOCKWISE")
			convert-command -rotate -90 
			;;
		*)
			echo unknown rotation for "$IN"
			false
			;;
	esac
else
	false
fi
