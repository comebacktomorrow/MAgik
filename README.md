MAgik
=====

Grand MA2 Launcher

Instructions for MAgik
###About MAgik
MAgik is a program designed to make your OnPC computer a less 'computer' and a little more 'OnPC'. Keep your computer running lean and optimised. Who needs print services! 

I've been running it for a year and put it through at least 100 shows in that time. It's been in development for two years; it started life as a similar program designed for Martin MPC before the switch to GrandMA where it has also been living for a year. I finally managed to complete my one last key function, and have thus decided others might find it useful too.

###Features include:
+ Booting right into Grand MA
+ Storing window positions for a variety of multi-screen configurations
+ Modifying the command screen to work nice on your tablet
+ Auto starting programs such as BCF4MA (user configurable!)
+ Restarting of programs upon software reboot
+ Crash detection and recovery
+ Automatic shutdown or logoff upon closure of Grand MA2
+ Switching between versions of OnPC

###How it works:
MAgik works from within your grandma folder in program files. From there, it knows how to discover what versions of the software you have installed.

###MAgik switches:
The core functionality is controlled through optional command line switches that tell MAgik how to behave.

Commands:
- S True // Start GrandMA2 when you run magik?
- L [Start | Block] // Which set of programs do you want to run with Grand MA (See init.ini)
- Q [Quit | Block] // Which set of programs do you want to close with Grand MA (See init.ini)
- U [Shutdown | Logoff] //Do you wish to shutdown or logoff when you close Grand MA?*

A example: "C:\Program Files\MA Lighting Technologies\grandma\Magik.exe" -S True -L Start -Q Quit -U Shutdown"

*Please note, the shutdown functionality only works when MAgik has been setup to run as Shell.

###MAgik hotkeys
Once you have GrandMA and MAgik running, there are also optional window management hotkeys you can use to set up your environment to your liking. 

Commands:
+ Left Windows Key - Bring GrandMA2 command window to foreground // *This only works when running as shell
+ Ctrl+W - Save window state // Magik will remember when you keep your windows when you start for any given monitor configuration.
+ Ctrl+Q - Cycle through command cropping // This will crop your command screen to just be a command screen. There are a few different variations of it, so press it a few times.
+ Ctrl - Version switch gui // This only works when MAgik is starting. Press it repeatedly fast!
+ Alt - Move window // Hold this down then click and drag

MAgik as Shell
This is about replacing Window Explorer, start menu and the like with MAgik and GrandMA. Included is a registry key that will replace explorer.exe with a link to the MAgik shortcut you create.

Other bits:
-------------------
###What if I lock myself out of shell?
You can always press Ctrl-Alt-Delete. I contemplated putting a nicer GUI in for just that sort of situation, but why add another hotkey and more complication when any one can just press ctrl-alt-delete anyway? The only reason I can see that you'd want to do this is to really lock down the computer, in which case you don't need me to disable ctrl-alt-delete for you :)

If you want to minimize the risk of this happening, just work on getting your configuration right prior to setting it up as shell.

###What else can I do?
+ Enable auto-login for Windows. Google it.
+ Disable non-essential services.
+ Install the Windows theme (designed for Windows 8).

###Having issues with BCF4MA not connecting?
If you've got MA2 as part of a network, the chance is GrandMA2 is loading before your computer has set its IP. Set it to static, that helps a bit. MAgik already has a delay in there to let windows acquire its IP. Yes, even if its static. If anyone finds a way around this, let me know! I'm confident it's a Windows configuration safeguard.

###How do I auto-log in.
I won't write it up here, but this is a good starting point. http://windows.microsoft.com/en-au/windows-vista/turn-on-automatic-logon

Getting Started.
--------------------
Running the raw executable won't do anything by itself, you need to pass instructions through command lind switches, hotkeys, and stored registry settings. It's designed to get itself out of the way.

1. On your first run, make sure the path in the shortcut is correct. 
2. Double click on the shortcut to run it, and quickly start pressing your Control key.
This should bring up the autoboot gui. Select the version of MA2 you'd like to boot into. Then press default to make this your chosen version (the launch button lets you launch a different version without setting it as default). FYI: This value is stored in the registry under HKCU\Software\ShellLauncher\Default, the data being the folder name of the version you want to launch.

3. Now, run the shortcut to make sure everything is working fine. By default it is setup to work with BCF4MA - either delete the command line switch for S and Q, or remove the lines from init.exe.

You're now ready to set MAgik as shell.
4. In the MAgik shortcut, copy the switches in "target", by default it is "-S True -L Start -Q Quit -U Shutdown". Now go into the extras folder and open "Set MAgik as Shell.reg". You'll see the last line has the switches at the end - if you've changed anything, replace those switches with your copied switches.

5. Once you've done that, save and double click to apply the settings to the registry. Now, restart your computer. 
Fingers crossed, it should load!

User license:
-------------------
Attribution-NonCommercial 4.0 International
http://creativecommons.org/licenses/by-nc/4.0/
http://creativecommons.org/licenses/by-nc/4.0/legalcode

Made in Queensland, Australia. 
© 2014 comebacktomorrow
