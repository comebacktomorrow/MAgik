;
; Shutdown: 1.x
; Language:       English
; Platform:       Vista/7
; Author:         comebacktomorrow
;
; Script Function:
;	Quit or restore the OS state
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Shutdown(mode) {
	shellmode:= Checkshell()	;check if the user is running explorer
	if !(shellmode)
	{
		if (mode = "Logoff")
		{
			Shutdown, 0 	;logout
		}
		else if (mode = "Shutdown")
		{
			Shutdown, 1	;shutdown
		}
	}
}
