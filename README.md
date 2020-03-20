# ASWX1-FW-MOD  
**Artillery Sidewinder X1 Firmware Mod**  


<img align="right" width="175" src="https://github.com/MarlinFirmware/Marlin/raw/2.0.x/buildroot/share/pixmaps/logo/marlin-250.png" style="max-width:100%;">

<img align="left" width="175" src="https://github.com/pinguinpfleger/ASWX1-FW-MOD/blob/2.0.x/artillery_logo_brand.png?raw=true" style="max-width:100%;">

 
The ASWX1-FW-Mod is an optimization for the Artillery Sidewinder X1 3D printer.  
The Artillery Sidewinder X1 is delivered with Marlin 1.19 [link](http://www.artillery3d.com/DownLoad/15688.html) and deactivated EEPROM memory function `M500`.  
  
This optimized firmware is based on [Marlin Firmware Version 2.0.x](https://github.com/MarlinFirmware/Marlin/tree/2.0.x)  
and on Marlin [Artillery Sidewinder X1 config](https://github.com/MarlinFirmware/Configurations/tree/master/config/examples/Artillery/Sidewinder%20X1)  

<br>

There is also an [optimized firmware for Artillery Sidewinder X1 touch display](https://github.com/pinguinpfleger/ASWX1-TFTFW-MOD) which you can install too but it is optionally.  

## Releases  
**20.03.2020** [ASWX1-FW-MOD-v1.2](https://github.com/pinguinpfleger/ASWX1-FW-MOD/releases/tag/ASWX1-FW-MOD-v1.2) - [ASWX1-FW-MOD-v1.2.zip](https://github.com/pinguinpfleger/ASWX1-FW-MOD/releases/download/ASWX1-FW-MOD-v1.2/ASWX1-FW-MOD-v1.2.zip)  based on Marlin 2.0.5.1  

**07.03.2020** [ASWX1-FW-MOD-v1.1](https://github.com/pinguinpfleger/ASWX1-FW-MOD/releases/tag/ASWX1-FW-MOD-v1.1) - [ASWX1-FW-MOD-v1.1.zip](https://github.com/pinguinpfleger/ASWX1-FW-MOD/releases/download/ASWX1-FW-MOD-v1.1/ASWX1-FW-MOD-v1.1.zip)  based on Marlin 2.0.4.4  
*Maintained some basic changes (e.g. the possibility to store babystepping)*  
  
**29.02.2020** [ASWX1-FW-MOD-v1.0](https://github.com/pinguinpfleger/ASWX1-FW-MOD/releases/tag/ASWX1-FW-MOD-v1.0) - [ASWX1-FW-MOD-v1.0.zip](https://github.com/pinguinpfleger/ASWX1-FW-MOD/releases/download/ASWX1-FW-MOD-v1.0/ASWX1-FW-MOD-v1.0.zip)  based on Marlin 2.0.4.4  
   
## Improvements  

1. **Save to EEPROM**  
   Enabled EEPROM `M500` to persist settings.  
   Now you can store PIDs and Z-Offsets to EEPROM  

2. **LIN_ADVANCE activated**  
    Linear Advance brings you better dimensional precision due to reduced bleeding edges.  
    Higher printing speeds are possible without any loss of print quality - as long as your extruder can handle the needed speed changes.  
    Visible and tangible print quality is increased even at lower printing speeds.  
    No need for high acceleration and jerk values to get sharp edges.  
   Read https://marlinfw.org/docs/features/lin_advance.html for more details and how to calibrate.  
   By default the K_Factor is set to 0, so it is disabled.  
   To enable it using gcode you should first calibrate your specific K factor.  
   You can do this [here](https://marlinfw.org/tools/lin_advance/k-factor.html). Accordingly set the K factor within your slicer using e.g. `M900 K0.2`  

4. **S_CURVE_ACCELERATION activated**  
   This option eliminates vibration during printing by fitting a Bézier curve to move acceleration, producing much smoother direction changes.  
  
5. **ADAPTIVE_STEP_SMOOTHING activated**  
    Adaptive Step Smoothing increases the resolution of multi-axis moves, particularly at step frequencies below 1kHz (for AVR) or 10kHz (for ARM), where aliasing between axes in multi-axis moves causes audible vibration and surface artifacts.
    The algorithm adapts to provide the best possible step smoothing at the lowest stepping frequencies.  



## Individual adjustments  
Individual adjustments can be made in [Configuration.h](/Marlin/Configuration.h) and [Configuration_adv.h](/Marlin/Configuration_adv.h)  
[Read more about configuring Marlin](https://marlinfw.org/docs/configuration/configuration.html)  
Of course the firmware must be recompiled than.  
There are serveral ways to compile.  
An easy one is [platformio CLI](https://docs.platformio.org/en/latest/installation.html#installation-methods) command.  
To complile you just need execute `platformio run` in the root folder of this repository (where platformio.ini is also located).  
The new compiled firmware is saved here: .pio/build/megaatmega2560/firmware.hex  
  
## Flashing  
The display and the USB-Port are sharing the same wires so flashing the tft firmware need some extra work.  
There are two ways possible to flash the firmware.  
  
### 1. Disconnect the display  
You have to open the printer and unplug the display.  
  
### 2. Loop method  
With this method we try to talk to the motherboard before the display is ready to listen.  
The [flash.sh](/flash.sh) script is trying to flash the command in a loop until the command finishs succesfully.  
Steps:  
Make sure Artillery Sidewinder X1 is unplugged from the power supply.  
Unplug USB Cable too.  
Connect your linux box (or mac) with the printer USB-Port  
Place firmware.hex and flash.sh in same directory and execute flash.sh.  
You will see timeout errors thats normal.  
Plug USB Cable  
Leave flash.sh running and unplug / plug USB Cable or hit the reset button until the flash.sh finishs  
  
  
### Reset to factory defaults  
I recommend to reset the newly flashed firmware to its defaults and overwrite any older settings.  
The gcode command is `M502` to reset the firmware to the hardcoded defaults,  
followed by `M500` to save these default setting to EEPROM.  
You can execute the gcode commands using a terminal program (Arduino has one included) or using the Terminal Tab in octoprint.  
If you have no serial monitor for running the command you could temporary modify mks_config.txt with a text editor, to include the M502/M500 commands in Line 191 to look like this:  
#SaveToEEPROM >moreitem_button4_cmd:M42 P4 S0;M42 P5 S255;M42 P6 S0;M502;M500;G4 S1;M42 P4 S255;M42 P5 S0;M42 P6 S0;  
  
Now, if you press SaveToEEPROM you will reset to factory defaults and save the settings.  
Everything will get overwritten, so if you already have done PID Tuning you will need to redo this.  
Do not forget to remove the M502 command after you executed it once, otherwise you will always reset your settings back to defaults and loose PIDs and Z-Offsets.  
  
<br><br><hr>  

## Credits  
The repository here is the continuation of the MarlinFW from [**Robscar's firmware mod** at Thingiverse](https://www.thingiverse.com/thing:3856144).  
The modified firmware for the Makerbase MKS-TFT 3.2 touch display has been seperated to an own repository:  
https://github.com/pinguinpfleger/ASWX1-TFTFW-MOD
  

## Links

### Slicer Machine & Profile Settings
https://3d-nexus.com/resources/file-archives/category/8-artillery-evnovo

### Youtube
RICS 3D Marlin 2 https://www.youtube.com/watch?v=JlgykMHhMzw  

