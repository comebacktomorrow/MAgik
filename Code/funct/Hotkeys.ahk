;Martin MPC Hotkeys Sunday 05 August
crop:=Object()



LWin UP::
	WinActivate grandMA2 onPC
return

;add toggle command
^r::	
	;disable crop mode
	global crop
	c:= getWindowPositions(getCanvasSize())
	crop:=cropMode_Control("resetfull")
return
 
^t:: 
	;restore window settings
	global crop
	c:= setWindowPositions(getCanvasSize())
	crop:=cropMode_Control("restore",,, c)	
return

^w::
	;save window settings
	SplashTextOn, , , Saving Window State
	Sleep, 2000
	SplashTextOff
	global crop
	c:= getWindowPositions(getCanvasSize())
	cropMode_Save(c, crop)
return

^q:: 
	;activate crop mode
	global crop
	c:= getWindowPositions(getCanvasSize())
	crop:=cropMode_Control("monitor", "current", "auto", c)	
return