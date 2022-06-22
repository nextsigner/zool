#!/bin/bash
fileData="[Desktop Entry]
Type=Application
Name=Zool v$1
Exec=AppRun %F
Icon=icon
Comment=Zool by nextsigner
Terminal=true
"
echo "$fileData" > $2
exit 0
