#!/bin/bash
folderWin="/home/ns/.wine/drive_c/"
folderWinZool="/home/ns/.wine/drive_c/Zool"
folderZool="$folderWin/zool-mingw-build/"

echo "Borrando archivos de la carpeta $folderZool"

#find $folderZool ! -name '*.exe' -type f -exec rm -f {} +
#rm -rf $folderZool*/

rm $folderZool*.qml
rm $folderZool*.js
rm $folderZool*.html
rm $folderZool*.json
rm -rf $folderZoolcomps

echo "Archivos eliminados."


echo "Copiando archivos desde "$folderWin

cp $folderWinZool/*.png $folderZool
cp $folderWinZool/*.ico $folderZool

cp *.html $folderZool
cp *.qml $folderZool
cp *.js $folderZool
cp *.png $folderZool
cp -r comps $folderZool
cp -r modules $folderZool
cp -r editor $folderZool
cp -r py $folderZool
#cp -r Python ./build_win/
cp -r resources $folderZool
cp -r swe $folderZool

echo "Se han copiando todos los archivos a "$folderZool

exit 0
