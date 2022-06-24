#!/bin/bash
version=$(cat version | sed 's/\n//g' | sed 's/\./-/g')
IFS=- read var1 var2 var3 <<< "$version"
res=$(($var3 + 1))
echo "Version previa: $var3"
echo "Version posterior: $res"
nversion="$var1.$var2.$res"
echo "$res" > num_comp
echo "$nversion" > version
echo "$nversion" > build_linux/version
exit 0
