#Instructions for MAgik
##About MAgik
MAgik is a program designed to make your OnPC computer a less 'computer' and a little more 'OnPC'. Keep your computer running lean and optimised. Who needs print services! 

I've been running it for about three years and put it through at leask weekly loads all that time. For a while it stalled in development mostly because it did what it needed to, but there were always a few things that I wanted to tidy up.

###Features include:
+ A new easy config tool (MAgik Config)
+ Booting right into Grand MA
+ Storing (Ctrl+W) and restoring (Ctrl+T) window positions for a variety of multi-screen configurations 
+ Modifying the command screen to work nice on your tablet #Improved! (Ctrl+Q, Ctrl+R) And yes, this attribute is storable! (Ctrl+W)
+ Auto starting programs such as BCF4MA (user configurable through a nifty .ini file!)
+ Restarting of programs upon software reboot
+ Crash detection and recovery (so it won't auto-shutdown)
+ User configrable automatic shutdown or logoff upon closure of Grand MA2
+ Switching between versions of OnPC

###How it works:
MAgik works from within your grandma folder in program files. From there, it knows how to discover what versions of the software you have installed.
After you've placed it in there, run MAgik Config!

##MAgik Config
The Config GUI replaces the old switches that were somewhat confusing, even to me. You can either run the MAgik Config directly, or you can quickly press and hold down tab when booting MAgik.
It gives you options to:
+ Boot a different version of MA
+ Change the "Shutdown" action
+ Choose whether to load and unload apps on launch
+ Set MAgik or Explorer as Shell

*Please note, the shutdown and logoff functionality is only enabled when MAgik has been setup to run as Shell and Windows explorer \ shell is not running.

##MAgik hotkeys
Once you have GrandMA and MAgik running, there are also optional window management hotkeys you can use to set up your environment to your liking. 

###Commands:
+ Left Windows Key - Bring GrandMA2 command window to foreground // *This only works when running as shell
+ Ctrl+W - Save window state // Magik will remember when you keep your windows when you start for any given monitor configuration.
+ Ctrl+Q - Enable Crop Mode for the command screen on its current monitor (resize so it fits inside first)
+ Ctrl+R - Disable Crop Mode
+ Ctrl+T - Restore Window Deafults
+ Tab- Version switch gui // This only works when MAgik is starting. Press it repeatedly fast!
+ Alt - Move window // Hold this down then click and drag

Other bits:

What if I lock myself out of shell?
You can always press Ctrl-Alt-Delete. I contemplated putting a nicer GUI in for just that sort of situation, but why add another hotkey and more complication when any one can just press ctrl-alt-delete anyway? The only reason I can see that you'd want to do this is to really lock down the computer, in which case you don't need me to disable ctrl-alt-delete for you :)

If you want to minimize the risk of this happening, just work on getting your configuration right prior to setting it up as shell.

What else can I do to make my computer more console like?
+ Enable auto-login for Windows. Google it.
+ Disable non-essential services.
+ Install the Windows theme (designed for Windows 8).

Having issues with BCF4MA not connecting? If you've got MA2 as part of a network, the chance is GrandMA2 is loading before your computer has set its IP. Set it to static, that helps a bit. MAgik already has a delay in there to let windows acquire its IP. Yes, even if its static. If anyone finds a way around this, let me know! I'm confident it's a Windows configuration safeguard.

Getting Started.
--------------------
Running the raw executable won't do anything by itself first up - by design it tries not to draw attention to itself.

1. Copy MAgik (and optionally, MAGikConfig) to your "MA Lighting Technologies\grandma" folder in program files.
2. On your first run, either quickly hold down tab to launch the config tool or .. just run the config tool.
3. Once the config window comes up, so you need to choose some options: 
- Select the version of MA2 you'd like to boot into.
- If MA onPC should automatically start when MAgik runs (set to true).
- What action should be taken when MA is closed while running as shell (usually shutdown, logoff is great for testing)
- If applications should be loaded or unloaded on boot \ shutdown.

- Launch selected onPC verison is for quickly changing versions of MA
- *Store settings as default saves all the above settings*
- Restore explorer as shell and set MAgik as shell define what happens when you log in.

4. If you've decided to set MAgik as Shell, log out and then log back in. You shoud see MA start. Hooray!
5. Advanced: If you're also loading additional apps, you'll need to do that through init.ini. Take a look at the file to see the BCF4MA example.

Version History
---------------
2.0.0 Inital release
2.0.1 Modified boot GUI to be more verbose to try and why it's not finding versions.
2.2.7 New ConfigGUI tool - changed configuration to use registry instead of commmand line switches. Fixed autoboot registry settings. Experimental screen1 cropping and scaling.

User license:
Attribution-NonCommercial 4.0 International
http://creativecommons.org/licenses/by-nc/4.0/
http://creativecommons.org/licenses/by-nc/4.0/legalcode

Made in Queensland, Australia. 
© 2016 David Tilley
