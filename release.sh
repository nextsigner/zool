#!/bin/bash
echo "Copiando archivos a ../zool-release ..."

cd ../zool-release
git rm *.html
git rm *.qml
git rm *.js
git rm *.png
git rm -r comps
git rm -r editor
git rm -r py
git rm -r resources
git rm -r swe
git rm -r modules

cd -

cp *.html ../zool-release/
cp *.qml ../zool-release/
cp *.js ../zool-release/
cp *.png ../zool-release/
cp -r comps ../zool-release/
cp -r editor ../zool-release/
cp -r py ../zool-release/
cp -r resources ../zool-release/
cp -r swe ../zool-release/
cp -r modules ../zool-release/

#echo "vaciado 3" > ../zool-release/vaciado.txt

rm ../zool-release/resources/*.dat
rm ../zool-release/resources/*.xcf
rm ../zool-release/resources/*.sh
rm ../zool-release/resources/*.iit
cd ../zool-release
git add *
git commit -m "$1"
git push origin main

echo "Se han copiando todos los archivos a ../zool-release"
