#!/bin/bash
echo 'Creando Zool AppIMage...'
cd /media/*/*/zool
echo 'Copiando archivos...'
./copiarALinux.sh
cd ~
echo 'Ejecutando linuxdeployqt... ~/linuxdeployqt-continuous-x86_64.AppImage /media/ns/ZONA-A1/zool/build_linux/zool -qmldir=/media/ns/ZONA-A1/zool -qmake=/home/ns/Qt/5.15.2/gcc_64/bin/qmake -verbose=3 -bundle-non-qt-libs -no-plugins -appimage'
~/linuxdeployqt-continuous-x86_64.AppImage /media/ns/ZONA-A1/zool/build_linux/zool -qmldir=/media/ns/ZONA-A1/zool -qmake=/home/ns/Qt/5.15.2/gcc_64/bin/qmake -verbose=3 -bundle-non-qt-libs -no-plugins -appimage