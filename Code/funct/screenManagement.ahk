;
; Screen Management Script
; Language:       English
; Platform:       Vista/7
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Capture, store, and recall the screen layout
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;the following functions are used to create sets
;based on the assumption that windows wont move around for a given setup
;theses sets are unique for a setup and thus can be recalled automagically
;saving should happen automatically at shutdown .. yeah?

;this is the size of the current set
getCanvasSize() {
	SysGet, X, 78
 	SysGet, Y, 79
	SysGet, C, 80
	return x + y + c
}

;c:= getCanvasSize()

;this is how we discover if a canvas exists
getCanvasRecord(canvas){
	RegRead, exists, HKCU, Software\ShellLauncher\%canvas%, %canvas%
	ErrorLevel = 0
	return exists
}

;d:= getCanvasRecord(c)

;next up: retrieve the current positions of each of the windows
getWindowPositions(canvas){
	WinGetPos, X, Y, Width, Height, grandMA2 onPC
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_x, %x%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_y, %y%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_w, %Width%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_h, %Height%

	WinGetPos, X, Y, Width, Height, Display 2
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 2_x, %x%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 2_y, %y%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 2_w, %Width%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 2_h, %Height%

	WinGetPos, X, Y, Width, Height, Display 3
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 3_x, %x%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 3_y, %y%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 3_w, %Width%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 3_h, %Height%

	WinGetPos, X, Y, Width, Height, Display 4
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 4_x, %x%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 4_y, %y%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 4_w, %Width%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 4_h, %Height%

	WinGetPos, X, Y, Width, Height, Display 5
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 5_x, %x%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 5_y, %y%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 5_w, %Width%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 5_h, %Height%

	WinGetPos, X, Y, Width, Height, Display 6
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 6_x, %x%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 6_y, %y%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 6_w, %Width%
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 6_h, %Height%

	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, %canvas%, 1
	return %canvas%
}

;e:= getWindowPositions(c)

;this should happen on load
setWindowPositions(canvas){
	RegRead, X, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_x
	RegRead, Y, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_y
	RegRead, W, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_w
	RegRead, H, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_h
	
	WinMove, grandMA2 onPC,, X, Y, W, H

	RegRead, X, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 2_x
	RegRead, Y, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 2_y
	RegRead, W, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 2_w
	RegRead, H, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 2_h

	WinMove, Display 2,, X, Y, W, H

	RegRead, X, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 3_x
	RegRead, Y, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 3_y
	RegRead, W, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 3_W
	RegRead, H, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 3_h

	WinMove, Display 3,, X, Y, W, H

	RegRead, X, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 4_x
	RegRead, Y, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 4_y
	RegRead, W, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 4_w
	RegRead, H, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 4_h

	WinMove, Display 4,, X, Y, W, H

	RegRead, X, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 5_x
	RegRead, Y, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 5_y
	RegRead, W, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 5_w
	RegRead, H, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 5_h

	WinMove, Display 5,, X, Y, W, H

	RegRead, X, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 6_x
	RegRead, Y, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 6_y
	RegRead, W, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 6_w
	RegRead, H, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 6_h

	WinMove, Display 6,, X, Y, W, H
	ErrorLevel = 0
}

;setWindowPositions(c)

;SysGet, MonitorCount, MonitorCount
;SysGet, MonitorPrimary, MonitorPrimary
;MsgBox, Monitor Count:`t%MonitorCount%`nPrimary Monitor:`t%MonitorPrimary%
;Loop, %MonitorCount%
;{
;    SysGet, MonitorName, MonitorName, %A_Index%
;    SysGet, Monitor, Monitor, %A_Index%
;    SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
;    MsgBox, Monitor:`t#%A_Index%`nName:`t%MonitorName%`nLeft:`t%MonitorLeft% (%MonitorWorkAreaLeft% work)`nTop:`t%MonitorTop% (%MonitorWorkAreaTop% work)`nRight:`t%MonitorRight% (%MonitorWorkAreaRight% work)`nBottom:`t%MonitorBottom% (%MonitorWorkAreaBottom% work)
;}

;WinSet, Region, 0-0 w840 h400, grandMA2 onPC