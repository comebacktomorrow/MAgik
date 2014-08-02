#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;the hotkeys cycle through manual, auto, restore, reset
;you then have a different key for save - tied to the window save state

cropMode_Control(type="mode", monitor="current", px="auto"){
	static isCropped:= 0
	static mode = 0
	
	if (mode == 4) {
		mode:=0
	}
	if (type="mode") {
		mode:= mode + 1
	}
	
	; there are three different types - fill monitor, restore (load from reg), and reset (disable crop)
	;fill monitor can be set manually, automatically, or set to be the native size (800px)

	if (type == "monitor" || mode == 2) {
			if (monitor == "current" || mode == 2){
				;do it for the current monitor
				WinGetPos, dX, dY, dWidth, dHeight, grandMA2 onPC
				monitor := GetMonitorAt(dX, dY)
			}
			
			;the width we need to be defining is for the command region
			if (px=="auto" || mode == 2){
				SysGet, Mon2, Monitor, %monitor%
				;figure out how big the command screen should be to fill the monitor based on the width of the command section
				command_width := Mon2Right
				type= "Automatic"
			} else if (px=="native"){
				command_width:= 800
				type = "Native"
			} else if (px == int){
				command_width :=px
				type = "Manual"
			}
	scale_factor:= command_width/800
	cropMode_Move(-scale_factor)
	cropMode_Crop(scale_factor)
	isCropped:=1

	} else if (type == "restore" || mode == 3){
		canvas := px
		;the sizing of the window is handled by the screenManagement function .. except in the case of calling a mode restore!
		RegRead, dX, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_x
		RegRead, dY, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_y
		RegRead, dWidth, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_w
		RegRead, dHeight, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_h
		
		;see if crop mode is enabled
		RegRead, dCrop, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_crop
		scale_factor:= (dWidth/1352)
		cropMode_Move(scale_factor, dX, dY)
		if (dCrop == 1){
			;this is sort of like calling simple
			cropMode_Crop(scale_factor)
		} else {
			WinSet, Region, ,grandMA2 onPC
			dCrop = 0
		}
		isCropped:= dCrop
		type:= "Restore"
	} else if (type == "reset" || mode == 4){
		;dont resize, just kill the crop
		WinGetPos, dX, dY, dWidth, dHeight, grandMA2 onPC
		scale_factor:= (dWidth/1352)
		;no crop value - just move
		cropMode_Move(scale_factor, dX, dY)
		WinSet, Region, ,grandMA2 onPC
		type:= "Reset"
		isCropped=0
		
	} else if (type == "simple" || mode == 1){
		WinGetPos, dX, dY, dWidth, dHeight, grandMA2 onPC
		scale_factor:= (dWidth/1352)
		cropMode_Crop(scale_factor)
		type="Simple"
		isCropped=1
	}
	;keep it silent when restoring	
	if (type != "restore"){
		SplashTextOn, , , %type%. mode %mode%
		Sleep, 2000
		SplashTextOff
	}
	return isCropped
}

cropMode_Move(scale = 1, move_x=0, move_y=0){
	;if scale is greater than 0, assume we're not full running auto
	if (scale >= 0){
		dX:= move_x
		dY:= move_y
		; and work out the width based upon the scale
		dWidth:= scale*1352
		dHeight:= scale*800
	} else {
	;otherwise make it relative to scale
		dX:= scale*1
		dY:= scale*236
		; and work out the width based upon the scale
		dWidth:= -scale*1352
		dHeight:= -scale*800
	}

	; and move!
	WinMove, grandMA2 onPC,, dX, dY, dWidth, dHeight
}

cropMode_Crop(scale_factor = 1){
	;work out pixel crop offset
	compute_x:= 1*scale_factor
	compute_y:= 236*scale_factor
	;draw the crop box proportionally
	compute_internalw:= 800*scale_factor
	compute_internalh:= 480*scale_factor
	;crop
	WinSet, Region, %compute_x%-%compute_y% w%compute_internalw% h%compute_internalh%, grandMA2 onPC
}

cropMode_Save(canvas, isCropped){
	state:=isCropped
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\ShellLauncher\%canvas%, 1_crop, %state%
}


; Get the index of the monitor containing the specified x and y co-ordinates. 
GetMonitorAt(x, y, default=1) 
{ 
    SysGet, m, MonitorCount 
    ; Iterate through all monitors. 
    Loop, %m% 
    {   ; Check if the window is on this monitor. 
        SysGet, Mon, Monitor, %A_Index% 
        if (x >= MonLeft && x <= MonRight && y >= MonTop && y <= MonBottom) 
            return A_Index 
    } 
    return default 
}