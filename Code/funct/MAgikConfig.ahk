#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

if (A_ScriptName == "MAgikConfig.ahk" || A_ScriptName == "MAgikConfig.exe"){
	;MsgBox, Autoload GUI
	default:= bootGUI(startVer)
} else {
	;MsgBox, Dont autoload gui
	}



bootGUI(default) {
global
;;;;;;;;; Load Deafults from Reg ;;;;;

	RegRead, regStartVer, HKEY_CURRENT_USER, Software\MAgik, Version
	RegRead, regAutoStart, HKEY_CURRENT_USER, Software\MAgik, autostart
	RegRead, regOnBoot, HKEY_CURRENT_USER, Software\MAgik, BootScript
	RegRead, regOnUnBoot, HKEY_CURRENT_USER, Software\MAgik, UnbootScript
	RegRead, regOnExit, HKEY_CURRENT_USER, Software\MAgik, onExit

;;;;;;;;; Generate DDL Data ;;;;;;;;;

;Lets find all the folders with gma2onpc in it and pop them in an array
	Array:= Object()
	Loop, gma2onpc.exe, 0, 1
	{
	   Array.Insert(A_LoopFileDir)
	}
	ddlVersions:= ParseDDL(Array, regStartVer)
	ddlAutoStart:= ["True",""] 
	ddlAutoStart:= ParseDDL(ddlAutoStart, regAutoStart)
	ddlOnExit:= ["", "Logoff", "Shut Down"]
	ddlOnExit:= ParseDDL(ddlOnExit, regOnExit)
	ddlLoadApps:= ["True",""]
	ddlLoadApps:= ParseDDL(ddlLoadApps, regOnBoot)
	ddlUnloadApps := ["True",""]
	ddlUnloadApps:= ParseDDL(ddlUnloadApps, regOnUnBoot)

;;;;;;;;;;;; Create the GUI ;;;;;;;;;;;;

;Lets create the drop down
	Gui, Add, Text,, Version to run
	Gui, Add, DropDownList, vVersion, %ddlVersions%
	Gui, Add, Text,, Autostart MA
	Gui, Add, DropDownList, vautoStart, %ddlAutoStart%
	Gui, Add, Text,, Action on Shutdown
	Gui, Add, DropDownList, vonExit, %ddlOnExit%
	Gui, Add, Text,, Load Apps on boot
	Gui, Add, DropDownList, vonLoad, %ddlLoadApps%
	Gui, Add, Text,, Unload Apps on Shutdown
	Gui, Add, DropDownList, vonUnload, %ddlUnloadApps%
	Gui, Add, Button, gStart, Launch Selected OnPC Version
	Gui, Add, Button, gDefault, Store Settings as Default
	Gui, Add, Button, gSetExplorer, Restore Explorer as Shell
	Gui, Add, Button, gSetMAgik, Set MAgik as Shell
	Gui, Show

	Pause

	return %Version%

;;;;;;;;;;; Set Defaults ;;;;;;;;;;;;;;;;;;;;

; Set default startup version
Default:
{
	GuiControlGet, Version 
	GuiControlGet, autoStart
	GuiControlGet, onExit
	GuiControlGet, onLoad
	GuiControlGet, onUnload

	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\MAgik, Version, %Version%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\MAgik, autostart, %autostart%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\MAgik, BootScript, %onLoad%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\MAgik, UnbootScript, %onUnload%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\MAgik, onExit, %onExit%

	MsgBox, Settings have been stored.
	
	sleep, 2000
	return %version%
}

;;;;;;;;;;;;;;;; Start MA with the selected defaults ;;;;;;;

;Start GrandMA
Start:
{
	GuiControlGet, Version
	Pause, off
	if (A_ScriptName == "MAgikConfig.exe")
	{
		Run, %version%\gma2onpc.exe
	}
	return %Version%
}

SetExplorer:
{
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows NT\CurrentVersion\IniFileMapping\system.ini\boot, Shell, SYS:Microsoft\Windows NT\CurrentVersion\Winlogon
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon, Shell, explorer.exe
	MsgBox, Windows Explorer has been set to Shell
	return
}
SetMAgik:
{
	v:= A_WorkingDir . "\Magik2.exe"
	RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows NT\CurrentVersion\IniFileMapping\system.ini\boot, Shell, USR:Software\Microsoft\Windows NT\CurrentVersion\Winlogon
	RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon, Shell, %v%
	MsgBox % v
	return
}
return %version%
}

ParseDDL(Array, default*){
	;Now lets convert that array into a list for a drop down
	isset = 0
	list =

	for index, item in Array
	{
		if (item == Default) {
			list = %item%||%list%
			isset = 1
		} else {
			list = %item%|%list%	
		}
	}
	if (isset == 0){
		list = %list%|
	}
	return list
}
