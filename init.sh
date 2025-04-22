#!/bin/bash

set -e

#!/bin/sh
clear
echo
echo
echo
echo
center() {
  local term_width=$(tput cols)
  local str="$1"
  local str_length=${#str}
  local padding=$(( (term_width - str_length) / 2 ))
  printf "%*s%s\n" $padding "" "$str"
}
center "⭐ Welcome to the Clinux setup! ⭐"
center "🛠️ By: Instel 🛠️"
sleep 5
clear
sudo apt update
sudo apt install -y firefox xfce4 xfce4-goodies tightvncserver git wget



vncserver :1
vncserver -kill :1

mkdir -p ~/.vnc
cat > ~/.vnc/xstartup <<EOF
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

NOVNC_DIR="$HOME/novnc"
WEBSOCKIFY_DIR="$HOME/websockify"

if [ ! -d "$NOVNC_DIR" ]; then
    git clone https://github.com/novnc/noVNC.git "$NOVNC_DIR"
    git clone https://github.com/novnc/websockify "$WEBSOCKIFY_DIR"
    ln -s "$WEBSOCKIFY_DIR" "$NOVNC_DIR/utils/websockify"
fi

vncserver :1

"$NOVNC_DIR"/utils/novnc_proxy --vnc localhost:5901 --listen 6080 &
clear
center() {
  local term_width=$(tput cols)
  local str="$1"
  local str_length=${#str}
  local padding=$(( (term_width - str_length) / 2 ))
  printf "%*s%s\n" $padding "" "$str"
}
echo
echo
echo
echo
center "⭐ Finished! ⭐"
center "⭐ You can now kill this terminal. ⭐"
