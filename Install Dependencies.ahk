;
;Program Name by Noahc3
;Additional Credits
;Built with Autohotkey 1.1.22.09
;Program Version
;
;Source Code available at [Link]
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



MsgBox, 68, Install Dependencies, This will install all required Python modules. Would you like to continue? If your Python version is lower than 2.7.9, make sure PIP is installed!
IfMsgBox, No
{
	ExitApp
	Return
}


continue = 0

run, %A_ScriptDir%\libs\install.bat, %A_ScriptDir%\libs
	
While continue = 0
{
	IfExist, %A_ScriptDir%\libs\install_done.txt
	{
		continue = 1
	}
} 

MsgBox, 0, Done!, Python dependency install complete!

FileDelete, %A_ScriptDir%\libs\install_done.txt

ExitApp
Return
