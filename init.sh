#!/bin/bash

set -e

# Update and install required packages
sudo apt update
#!/bin/sh
clear
echo ⭐ Welcome to the Clinux setup! ⭐
echo "❓ Would you like to install Firefox? (y/n) ❓"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    sudo apt install -y firefox xfce4 xfce4-goodies tightvncserver git wget
fi
clear
echo "❓ Would you like to install 7-zip? (y/n) ❓"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    sudo apt install -y p7zip-full
fi



# Set up VNC server
vncserver :1
vncserver -kill :1

# Create xstartup file for VNC (starts XFCE)
mkdir -p ~/.vnc
cat > ~/.vnc/xstartup <<EOF
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# Download and set up noVNC
NOVNC_DIR="$HOME/novnc"
WEBSOCKIFY_DIR="$HOME/websockify"

if [ ! -d "$NOVNC_DIR" ]; then
    git clone https://github.com/novnc/noVNC.git "$NOVNC_DIR"
    git clone https://github.com/novnc/websockify "$WEBSOCKIFY_DIR"
    ln -s "$WEBSOCKIFY_DIR" "$NOVNC_DIR/utils/websockify"
fi

# Start VNC server
vncserver :1

# Start noVNC on port 6080
"$NOVNC_DIR"/utils/novnc_proxy --vnc localhost:5901 --listen 6080 &
clear
echo ⭐ Finished! You may now kill this terminal. ⭐
