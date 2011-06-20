#!/bin/bash

#Name: ranwp.sh
#Function: Wallpaper randomiser
#Adapted for Ubuntu Warty from suggestions
#found on http://gnome-hacks.jodrell.net/
#License: Public Domain

#Instructions: Place this script in a /bin directory
#and do a chmod +x <filename> on it.
#Then put it in a crontab or with your startup programs.
#Or both. Ubuntu Warty doesn't have a crontab editor,
#but you can install gcrontab via synaptic.

#Change this location if you keep your backgrounds elsewhere.
#Just one location allowed, sorry
BGDIR=/home/cie/Képek/Móni

cd $BGDIR

IMGS=`find . -iname '*.jpg' -o -iname '*.png' -o -iname '*.svg'`
#You may want to get rid of the tiger head in
#/usr/share/backgrounds/scalable, in fact, blow
#that directory away!

N=`echo $IMGS | wc -w`
#Find out how many pictures we got

#((N=RANDOM%N))
#Take a random number between 1 and N
#That take a number between 0 and N-1. We must to add 1.
(( N= (RANDOM%N)+1 ))


#BGNAME=`echo $IMGS | cut -d '/' -f $N | cut -d ' ' -f 1`
#We have to cut twice to get rid of an irritating " ." at the
#end after the first cut

#The above code returns error at first element because it is a dot alone.
#And never selects the last one.
#I think this one works correctly.
BGNAME=`echo -e $IMGS | sed s@\./@@g | cut -d ' ' -f $N`

# start of gconftool command - all on one line!
gconftool-2 -t str --set /desktop/gnome/background/picture_filename "$BGDIR/$BGNAME"
# end of gconftool command

# start of gconftool command - all on one line!
gconftool-2 -t str --set /desktop/gnome/background/picture_options "zoom"
#Possible values are "none", "wallpaper" (eg tiled), "centered", "scaled", "stretched", "zoom"
# end of gconftool command


#That's it, your background should have changed.
