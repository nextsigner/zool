#!/bin/bash
folderWin="/home/ns/.wine/drive_c/"
zoolExePath="/home/ns/.wine/drive_c/Zool/zool.exe"
cd /media/ns/ZONA-A1/zool
sh copiarAMingwLinux.sh
wine $zoolExePath
echo "Cerrando runZoolMingwFromLinux.sh..."
exit 0
