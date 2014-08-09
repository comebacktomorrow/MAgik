;
; Start Launcher: 2.x
; Language:       English
; Platform:       Vista/Win7
; Author:         CBT
;
; Script Function:
;


StartMA() {

	;Now lets see if there a default version already set
	RegRead, Default, HKEY_CURRENT_USER, Software\ShellLauncher, Default

	;Either Run, or Present GUI
	KeyWait, LWin, D T0.1
	KeyWait, LCtrl, D T0.1
	if (!ErrorLevel || Default == "") {	; Run GUI Mode if key or no registry setting
		default:= bootGUI(Default)	;start GUI
		;Pause
		MsgBox, starting up %default%
		;RegRead, Default, HKEY_CURRENT_USER, Software\ShellLauncher, Default
	}
	Run, %default%\gma2onpc.exe	;RUN MA

	;wait for MA2 to load
	WinWait, grandMA2 onPC
	;Give it two seconds to load stuff
	sleep, 2000	;wait for it to load
}