;
; INI External Loader
; Language:       English
; Platform:       Vista/7
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Loads in ini file (src) and reads section (switch) and starts those applications 
;

externalload(switch, src) {
	LoadList := Object()
	#EscapeChar /
	if FileExist (src) {
		IniRead, run_path_raw, %src%, %switch%
		StringReplace, run_path, run_path_raw, run= ,+, , A	;split lines
		StringReplace, run_path, run_path, /n ,, , A		;strip returns
		StringReplace, run_path, run_path, /" ,, , A		;strip quotes
		StringSplit, executables, run_path, +, , /"		;replace quotes
		executables := executables	

		Loop, 30
		{
			if executables%A_Index%
			{
				executable :=executables%a_index%

				if FileExist(executable)
				{
					if (switch = "Start") 
					{
						Run %executable%, Hide, OutputVarPID
						;WinWait ahk_pid %OutputVarPID%
						WinHide ahk_exe %OutputVarPID%
						;MsgBox %OutputVarPID%
						LoadList.Insert(OutputVarPID)
					} 
					else if (switch = "Quit") {
						Process, Close,  %executable%
						WinWaitClose ahk_exe %executable%
					}
					
				} 
				else 
				{
					MsgBox I can't find %executable%
				}
			}
		}	
	} 
	else 
	{ 
		MsgBox cant load ini init.ini
	}
	#EscapeChar '
	sleep, 2000	;wait for everything to load
	return LoadList
}