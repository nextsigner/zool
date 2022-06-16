#!/bin/bash
find /home/ns/.local/share/Zool.ar/Zool/ ! -name '*.cfg' -type f -exec rm -f {} +
rm -rf /home/ns/.local/share/Zool.ar/Zool/*/

