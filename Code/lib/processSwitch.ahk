;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

0 = %0%						;load the switches

processSwitch(tag){
getParamsX:
	tag= %tag%				;the switch we are searching for
	global 0				;the switches we are loading

   Loop, %0% ; for each parameter
   {
      param := %A_Index%
      StringLeft, paramType, param, 1		;move through characters one by one 
      If paramType = - ; switch indicator	;if the chracter is a dash
      {
        StringMid, switch, param, 2, 1		;retrieve the character to the left of the switch
         If switch = %tag%
         {
            param = % A_Index + 1		; access value (= next parameter)
	    value := %param%
            return value
         }
      }
   }
}