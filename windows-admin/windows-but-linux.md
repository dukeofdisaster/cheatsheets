# Windows But Like Linux
A cheat sheet of shit that could be used for making troubleshooting life 
on windows easier incase someone decides to run an entire elk cluster
on windows because 1 person "isn't a linux guy". 

## Cheat Sheet
tail a file
- get-content C:\Some\File\Path\somefile.txt -wait

Hexdump in powershell; note count param isn't supported in all ps versions
- format-hex .\somefile.txt -count 16
- fhx .\somefile.txt 


## BOM stuff
Default : If you're piping shell output into file in ps it'll be unicode

Header bytes and corresponding encoding 
0  1  2  3
===========
ef bb bf			=> utf8 
===========
2b 2f 76   		=> utf7
===========
ff fe      		=> unicode
===========
fe ff      		=> bigendianunicode
===========
00 00 fe ff		=> utf32
===========
