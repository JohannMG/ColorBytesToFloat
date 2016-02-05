# Byte to UIColor

Quick tool I built to move a giant color pallete from RBG docs to UIColor snippets. 

Your lovely designers finished up designs and sent the team the new offical color pallete in tons of RGB or hexadecimal format. 
Now you want to turn those into Swift UIColors. Quickly the values, and it will return the UIColor() string and paste it automatically to your clipboard (you can turn that off but it's useful if you want to not use a mouse)

Simple terminal tool to do just that! 
 - Byte to float 
 - RGB to UIColor
 - RGBA to UIColor
 - HEX to UIColor 

Grab the entire xcode project if you like or 

Clone the repo OR just grab the terminal app here http://www.johannmg.com/downloads/ColorBytesToFloat
*[use `chmod +x ColorBytesToFloat` to use it]*

If this helps any say hi on [Twitter @johann_mg] :)
[Twitter @johann_mg]: <https://www.twitter.com/johann_mg>

##Example term
```Terminal
RGB to Swift UIColor by @johann_mg
Type `autopaste off` to disable automatic pasting to clipboard
Modes: byte, rgb, rgba, hex. Options: help, autopaste
Starting in rgb mode: Enter input as  RRR GGG BBB 

>>40 40 223
UIColor(red: 0.157, green: 0.157, blue: 0.875, alpha: 1.00)

>>255 0 247
UIColor(red: 1.000, green: 0.000, blue: 0.969, alpha: 1.00)

>>rgba
Set mode to RGBA, enter input as  RRR GGG BBB AAA

>>44 55 180 22
UIColor(red: 0.173, green: 0.216, blue: 0.706, alpha: 0.086)

>>hex
Set mode to Hex, enter input as #FAFF00, hash optional

>>FAFF00
UIColor(red: 0.980, green: 1.000, blue: 0.000, alpha: 1.00)
```



 