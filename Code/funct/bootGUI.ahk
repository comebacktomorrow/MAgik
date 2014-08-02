#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



bootGUI(Default) {
global Version

;Lets find all the folders with gma2onpc in it and pop them in an array
Array:= Object()

Loop, gma2onpc.exe, 0, 1
{
   Array.Insert(A_LoopFileDir)
}

;Now lets convert that array into a list for a drop down
for index, element in Array
{
	if (element == Default) {
		Versions = %element%||%Versions%
	} else {
		Versions = %element%|%Versions%
	}
}


;Lets create the drop down
Gui, Add, DropDownList, vVersion, %Versions%
Gui, Add, Button, Default gStart, Launch
Gui, Add, Button, gDefault, Default
Gui, Show
Return

; Set default startup version
Default:
{
	Gui, Submit
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher, Default, %Version%
	sleep, 2000
}

;Start GrandMA
Start:
{
	
	RegRead, Default, HKEY_CURRENT_USER, Software\ShellLauncher, Default
	Pause
	return	
}
return
}