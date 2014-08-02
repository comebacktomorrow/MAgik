;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	This script loads all the dependancies and gets the ball rolling.
;


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Initalise

Boot()
Load()
Watch()

;Load dependancies
#Include lib\checkshell.ahk	;We check to see if explorer is running for shutdown
#Include lib\externalload.ahk	;Loads programs from ini file
#Include lib\processSwitch.ahk	;Lets us access command line switches

;Load key functions
#Include funct\start.ahk	;functions to start ma running
#Include funct\bootGUI.ahk	;functions to administer startup
#Include funct\shutdown.ahk	;functions required to close up \ logout \ shutdown 
#Include funct\hotkeys.ahk	;modifications to MA for screen management
#Include funct\screenManagement.ahk	;add multimonitor screen pinning

#Include funct\cropMode.ahk	;add multimonitor screen pinning
#Include funct\altWindowDrag.ahk	;add multimonitor screen pinning

return

Boot(){
	;Sleep, 3000
	if (processSwitch("S"))
	{
		;MsgBox -S [True] means run MA if not loaded
		result:= processSwitch("S")
		if (result = "True") {
			startMA()
		}
	}
}

Load(){
	global c
	global crop

	c := getCanvasSize()
	if % getCanvasRecord(c) == 1
	{
		setWindowPositions(c)
		crop:= cropMode_Control("restore",1, c)
	}
	
	if (processSwitch("L"))
	{
		;MsgBox -L [Block] is the load script to be run from init.ini
		result:= processSwitch("L")
		LoadList:= externalload("Start", "init.ini")
		;MsgBox %LoadList% ;this is the list\program we need to quit on unboot

	}

	WinHide ahk_exe BCF4MA2-3.1.exe
	WinHide ahk_exe midiox.exe
	;Watch()	; Start watching
	
}

Watch(){
	settimer, thread1, 1
	settimer, thread2, 1
	
	thread1:	
	while (!ErrorLevel) {
		WinGet, MA_PID, PID, grandMA2	;find MA
		Process, WaitClose, %MA_PID%,	;wait for it to close
		;MsgBox "waiting..."
		WinWait, grandMA2, , 3		; give it two seconds to restart
		if ErrorLevel {
			Unload()	;call Quit
			Unboot()	;call Shutdown
			;MsgBox "Die, die, die"
			ExitApp		;exit the script
		} else {
			Unload()
			;MsgBox "I will rise again!"
			Load()
		}
	}

	return

	thread2:
	WinGet, MA_PID, PID, grandMA2
	if DllCall("IsHungAppWindow", "UInt", WinExist()){
		MsgBox "Not Responding. Reboot"
		WinKill, %MA_PID%
		WinWaitClose, %MA_PID%
		Unload()
		Boot()
		Load()
	}
	
	return
}

Unload(){
	if (processSwitch("Q"))
	{
		;MsgBox -S [Block] is the quit script to be run from init.ini
		result:= processSwitch("Q")
		externalload("Quit", "init.ini")
	}
}

Unboot(){
	if (processSwitch("U"))
	{	
		;Sleep, 3000	;give it time to quit
		;MsgBox -X [Logoff|Shutdown] tells the computer what to do on quit if in shell mode
		result:= processSwitch("U")
		Shutdown(result)
	}
}