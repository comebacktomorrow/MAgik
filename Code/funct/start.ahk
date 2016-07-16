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
	RegRead, Default, HKEY_CURRENT_USER, Software\MAgik, Version
	; if it is set, skip over the below loop

	;if it's not set, or we press a key ... do the following loop

	;Either Run, or Present GUI
	KeyWait, Tab, D T0.5
	if (!ErrorLevel || Default == "") {	; Run GUI Mode if key or no registry setting
		default:= bootGUI(Default)	;start GUI
		;Pause
		;MsgBox, starting %default%
		;RegRead, Default, HKEY_CURRENT_USER, Software\MAgik, Default
	}
	Run, %default%\gma2onpc.exe	;RUN MA

	;wait for MA2 to load
	WinWait, grandMA2 onPC
	;Give it two seconds to load stuff
	sleep, 2000	;wait for it to load
}

if (!A_IsCompiled){
	StartMA()
}