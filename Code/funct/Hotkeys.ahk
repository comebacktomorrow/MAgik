;Martin MPC Hotkeys Sunday 05 August

^q:: 
	global crop
	crop:=cropMode_Control("mode", ,getCanvasSize())
	
return

LWin UP::
	WinActivate grandMA2 onPC
return

^w::
	MsgBox, "Save Window State"
	global crop
	c:= getWindowPositions(getCanvasSize())
	cropMode_Save(c, crop)
return



;add toggle command