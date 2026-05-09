#!/usr/bin/sh
haxe -cp source -lib heaps -hl client.hl -main Main -debug -lib hlsdl -D windowSize=1280x720 -D windowTitle=RTS
echo end
read
