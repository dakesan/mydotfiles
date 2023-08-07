#!/bin/sh

if [ ! -d ~/.config/rstudio/ ]; then
    exit 1
fi

cd ~/.config/rstudio/

if [ ! -d fonts/ ]; then
    mkdir fonts
fi
cd fonts/

# HackGen

read -p "Input the version of HackGen: " HACKGEN_VER

if [ ! -z "$HACKGEN_VER" ]; then
    mkdir -p HackGen/400
    mkdir -p HackGen/700
    mkdir -p HackGen\ Console/400
    mkdir -p HackGen\ Console/700
    mkdir -p HackGen35/400
    mkdir -p HackGen35/700
    mkdir -p HackGen35\ Console/400
    mkdir -p HackGen35\ Console/700

    if ! ls HackGen_v* > /dev/null 2>&1
    then
	wget https://github.com/yuru7/HackGen/releases/download/v$HACKGEN_VER/HackGen_v$HACKGEN_VER.zip
    fi

    unzip HackGen_v$HACKGEN_VER.zip

    mv HackGen_v$HACKGEN_VER/HackGen-Regular.ttf HackGen/400
    mv HackGen_v$HACKGEN_VER/HackGen-Bold.ttf HackGen/700
    mv HackGen_v$HACKGEN_VER/HackGenConsole-Regular.ttf HackGen\ Console/400
    mv HackGen_v$HACKGEN_VER/HackGenConsole-Bold.ttf HackGen\ Console/700
    mv HackGen_v$HACKGEN_VER/HackGen35-Regular.ttf HackGen35/400
    mv HackGen_v$HACKGEN_VER/HackGen35-Bold.ttf HackGen35/700
    mv HackGen_v$HACKGEN_VER/HackGen35Console-Regular.ttf HackGen35\ Console/400
    mv HackGen_v$HACKGEN_VER/HackGen35Console-Bold.ttf HackGen35\ Console/700

    rm -r HackGen_v$HACKGEN_VER
else
    continue
fi

# udev-gothic

read -p "Input the version of udev-gothic: " UDEVGOTHIC_VER
if [ ! -z "$UDEVGOTHIC_VER" ]; then
    mkdir -p UDEV\ Gothic/400
    mkdir -p UDEV\ Gothic/700
    mkdir -p UDEV\ Gothic\ LG/400
    mkdir -p UDEV\ Gothic\ LG/700

    if ! ls UDEVGothic_v* > /dev/null 2>&1
    then
	wget https://github.com/yuru7/udev-gothic/releases/download/v$UDEVGOTHIC_VER/UDEVGothic_v$UDEVGOTHIC_VER.zip
    fi

    unzip UDEVGothic_v$UDEVGOTHIC_VER.zip

    mv UDEVGothic_v$UDEVGOTHIC_VER/UDEVGothic-Regular.ttf UDEV\ Gothic/400
    mv UDEVGothic_v$UDEVGOTHIC_VER/UDEVGothic-Bold.ttf UDEV\ Gothic/700
    mv UDEVGothic_v$UDEVGOTHIC_VER/UDEVGothicLG-Regular.ttf UDEV\ Gothic\ LG/400
    mv UDEVGothic_v$UDEVGOTHIC_VER/UDEVGothicLG-Bold.ttf UDEV\ Gothic\ LG/700

    rm -r UDEVGothic_v$UDEVGOTHIC_VER
else
    continue
fi

# Clean up

if [ -e *.zip ]; then
    rm *.zip
fi

