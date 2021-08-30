#!/bin/bash
echo "Copiando archivos a build_linux..."

cp *.html ./build_linux/
cp *.qml ./build_linux/
cp *.js ./build_linux/
cp *.png ./build_linux/
cp -r comps ./build_linux/
cp -r py ./build_linux/
cp -r resources ./build_linux/
cp -r swe ./build_linux/

echo "Se han copiando todos los archivos a build_linux."
