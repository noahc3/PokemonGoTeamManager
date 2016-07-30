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

#Include %A_ScriptDir%\libs\csv_lib.ahk
#Include %A_ScriptDir%\libs\tf.ahk

mode = google
userFromMng =
passFromMng =
modeFromMng =

FileDelete, %A_ScriptDir%\libs\py\pogoapi\info.txt
FileDelete, %A_ScriptDir%\libs\py\pogoapi\session.txt


Gui, MainGui:default
Gui, Add, Edit, x144 y119 w250 h20 vEmailE, Email
Gui, Add, Edit, x144 y159 w250 h20 vPasswordE Password*,
Gui, Add, Button, x144 y209 w110 h30 vGoogleB gGoogleB, Google
Gui, Add, Button, x420 y12 w110 h30 vPoGoServer gPoGoServer, PoGo Server Status
Gui, Add, Button, x284 y209 w110 h30 vPTCB gPTCB, PTC
Gui, Add, Button, x144 y249 w110 h30 vAddMng gAddMng, Add to Manager
Gui, Add, Button, x284 y249 w110 h30 vActMng gActMng, Act Manager
Gui, Add, Button, x144 y289 w250 h30 vLoginB gLogin, Login
Gui, Add, Text, x5 y337 w542 h20, Runs on Pokemon Go API for Python by TehDing  |  https://github.com/rubenvereecken/pokemongo-api
Gui, Add, Picture, x159 y29 w220 h70 vImg, %A_ScriptDir%\res\img\google.png
; Generated using SmartGUI Creator 4.0
Gui, Show, h353 w542, Login to Pokemon GO
Return

AddMng:
	MsgBox, 52, Warning!, WARNING! Your Username and Password will be stored in plain text on your hard drive, are you sure you wish to continue?
	IfMsgBox, No
	{
		return
	}
	Gui, Submit, Nohide
	FileAppend, %EmailE%`,%PasswordE%`,%mode%`n, %A_ScriptDir%\actdatabase.csv
	Msgbox, Done!
return

ActMng:
	GuiControl, Disable, EmailE
	GuiControl, Disable, PasswordE
	GuiControl, Disable, GoogleB
	GuiControl, Disable, PTCB
	GuiControl, Disable, Login
	GuiControl, Disable, ActMng
	GuiControl, Disable, AddMng
	GuiControl, Disable, PoGoServer
	
	CSV_Load("actdatabase.csv", "actList", ",")
	actLength:=TF_CountLines("actdatabase.csv")
	tempVar1 = 1
	accountList =
	resGet = 1
	foundTrainer = 0
	trLineCheck = 1
	trainerLine = 0

	while not tempVar1 = actLength 
	{
		tempVar2 := CSV_ReadCell("actList", tempVar1, 1)
		tempVar5 := CSV_ReadCell("actList", tempVar1, 3)
		
		accountList = %accountList%%tempVar5%: %tempVar2%|
		
		tempVar1 += 1
	}
	Gui, Mng:Add, DropDownList, x12 y29 w276 h240 AltSubmit gActList vActList Choose1, %accountList%
	Gui, Mng:Add, Button, x12 y59 w110 h30 vMngLogin gMngLogin, Login
	Gui, Mng:Add, Button, x178 y59 w110 h30 vMngRemove gMngRemove, Remove
	Gui, Mng:Show, w300 h100, Account Manager
return

loadActDatabase()
{
	CSV_Load("actdatabase.csv", "actList", ",")
	actLength:=TF_CountLines("actdatabase.csv")
	tempVar1 = 1
	accountList =
	resGet = 1
	foundTrainer = 0
	trLineCheck = 1
	trainerLine = 0

	while not tempVar1 = actLength 
	{
		tempVar2 := CSV_ReadCell("actList", tempVar1, 1)
		tempVar5 := CSV_ReadCell("actList", tempVar1, 3)
		
		accountList = %accountList%%tempVar5%: %tempVar2%|
		
		tempVar1 += 1
	}
	
	GuiControl, Mng:, actList, |
	GuiControl, Mng:, actList, %accountList%
}

ActList:

return

MngLogin:
	Gui, Submit, NoHide
	
	GuiControl, Disable, EmailE
	GuiControl, Disable, PasswordE
	GuiControl, Disable, GoogleB
	GuiControl, Disable, PTCB
	GuiControl, Disable, Login
	GuiControl, Disable, ActMng
	GuiControl, Disable, AddMng
	GuiControl, Disable, ActList
	GuiControl, Disable, MngLogin
	GuiControl, Disable, MngRemove
	GuiControl, Disable, PoGoServer
	
	userFromMng := CSV_ReadCell("actList", ActList, 1)
	passFromMng := CSV_ReadCell("actList", ActList, 2)
	modeFromMng := CSV_ReadCell("actList", ActList, 3)
	
	FileAppend, %userFromMng%`n%passFromMng%`n%modeFromMng%, %A_ScriptDir%\libs\py\pogoapi\info.txt
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\done.txt
	run, auth.bat
	
	continue = 0
	
	While continue = 0
	{
		IfExist, %A_ScriptDir%\libs\py\pogoapi\done.txt
		{
			continue = 1
		}
	} 
	
	FileCopy, %A_ScriptDir%\libs\py\pogoapi\input.txt, %A_ScriptDir%, 1
	FileCopy, %A_ScriptDir%\libs\py\pogoapi\player.txt, %A_ScriptDir%, 1
	
	Parse()
return

MngRemove:
	Gui, Submit, Nohide
	oldActList = %actList%
	
	TF_RemoveLines("!actdatabase.csv", oldActList, oldActList)
	
	loadActDatabase()
	
	
	
	GuiControl, Choose, ActList, |%oldActList%
	
	Msgbox, Done!
return

PTCB:
	mode = ptc
	GuiControl, , Img, %A_ScriptDir%\res\img\ptc.png
return

GoogleB:
	mode = google
	GuiControl, , Img, %A_ScriptDir%\res\img\google.png
return

Login:
	Gui, Submit, NoHide
	
	GuiControl, Disable, EmailE
	GuiControl, Disable, PasswordE
	GuiControl, Disable, GoogleB
	GuiControl, Disable, PTCB
	GuiControl, Disable, Login
	GuiControl, Disable, ActMng
	GuiControl, Disable, AddMng
	GuiControl, Disable, PoGoServer
	
	
	FileAppend, %EmailE%`n%PasswordE%`n%mode%, %A_ScriptDir%\libs\py\pogoapi\info.txt
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\done.txt
	run, auth.bat
	
	continue = 0
	
	While continue = 0
	{
		IfExist, %A_ScriptDir%\libs\py\pogoapi\done.txt
		{
			continue = 1
		}
	} 
	
	FileCopy, %A_ScriptDir%\libs\py\pogoapi\input.txt, %A_ScriptDir%, 1
	FileCopy, %A_ScriptDir%\libs\py\pogoapi\player.txt, %A_ScriptDir%, 1
	
	Parse()
return

PoGoServer:
	Run, https://go.jooas.com
return

Parse()
{

	pla1 := 0
	pla2 := 0
	pla3 := 0
	pla4 := 0
	pla5 := 0
	pla6 := 0
	pla7 := 0
	pla8 := 0
	pla9 := 0
	pla10 := 0
	pla11 := 0
	pla12 := 0
	pla13 := 0
	pla14 := 0
	pla15 := 0
	pla16 := 0
	pla17 := 0
	pla18 := 0
	pla19 := 0
	
	var1 := 0
	var2 := 0
	var3 := 0
	var4 := 0
	var5 := 0
	var6 := 0
	var7 := 0
	var8 := 0
	var9 := 0
	var10 := 0
	var11 := 0
	var12 := 0
	var13 := 0
	var14 := 0
	var15 := 0
	var16 := 0
	var17 := 0
	
	Progress, H80 P0 R0-100, , Parsing Response..., Parsing Data...
	readLine = 1
	FileDelete, output.csv
	FileDelete, output.txt
	finished = false
	FileAppend, Auth Type Detected: %mode%`n, output.txt
	FileAppend, Begin Parse!`n########################`n`n, output.txt
	FileAppend,,output.csv
	
	
	TF_Replace("!input.txt", "}","")
	TF_Replace("!input.txt", "]","")
	TF_Replace("!input.txt", "{","")
	TF_Replace("!input.txt", "[","")
	TF_Replace("!input.txt", "'","")
	TF_Replace("!input.txt", ":","")
	TF_Replace("!input.txt", ";","")
	;TF_TrimRight("!input.txt", "", "", 1)
	;TF_TrimLeft("!input.txt", "", "", 139)
	TF_RemoveBlankLines("!input.txt","","")
	FileAppend, `nend, input.txt
	
	fileLength := TF_CountLines("input.txt")
	
	Loop
	{
		FileReadLine, currentLine, input.txt, %readLine%
		
		if currentLine = end
		{
			FileAppend, Done!, output.txt
			
			break
		}
		else if currentLine contains pokemon_id
		{
			StringTrimLeft, var1, currentLine, 11
			StringUpper, var1, var1, T
			FileAppend, Pokemon Name: %var1%, output.txt
		}
		else if currentLine contains cp
		{
			if currentLine contains cp_multiplier
			{
				StringTrimLeft, var12, currentLine, 14
				FileAppend, CP Multiplier: %var12%, output.txt
			}
			else
			{
				StringTrimLeft, var2, currentLine, 3
				FileAppend, CP: %var2%, output.txt
			}
		}
		else if currentLine contains stamina
		{
			if currentLine contains stamina_max
			{
				StringTrimLeft, var4, currentLine, 12
				FileAppend, MaxHP: %var4%, output.txt
			}
			else if currentLine contains individual_stamina
			{
				StringTrimLeft, var11, currentLine, 19
				FileAppend, Individual Stamina: %var11%, output.txt
			}
			else
			{
				StringTrimLeft, var3, currentLine, 8
				FileAppend, HP/Stamina: %var3%, output.txt
			}
		}
		else if currentLine contains move_1
		{
			StringTrimLeft, var5, currentLine, 7
			StringReplace, var5, var5, _, %a_space%, All
			StringUpper, var5, var5, T
			FileAppend, Move1: %var5%, output.txt
		}
		else if currentLine contains move_2
		{
			StringTrimLeft, var6, currentLine, 7
			StringReplace, var6, var6, _, %a_space%, All
			StringUpper, var6, var6, T
			FileAppend, Move2: %var6%, output.txt
		}
		else if currentLine contains height_m
		{
			StringTrimLeft, var7, currentLine, 9
			FileAppend, Height (Meters): %var7%, output.txt
		}
		else if currentLine contains weight_kg
		{
			StringTrimLeft, var8, currentLine, 10
			FileAppend, Weight (KG): %var8%, output.txt
			
			
		}
		else if currentLine contains individual_attack
		{
			StringTrimLeft, var9, currentLine, 18
			FileAppend, Individual Attack: %var9%, output.txt
		}
		else if currentLine contains individual_defense
		{
			StringTrimLeft, var10, currentLine, 18
			FileAppend, Individual Defense: %var10%, output.txt
		}
		else if currentLine contains pokeball
		{
			if currentLine contains pokeballs_thrown
			{
				StringTrimLeft, pla10, currentLine, 17
				FileAppend, Pokeballs Thrown: %pla10%, output.txt
			}
			else
			{
				StringTrimLeft, var13, currentLine, 9
				FileAppend, Pokeball Type: %var13%, output.txt
				
				FileAppend, `nAppending to CSV`n, output.txt
			
				FileAppend, pokemon`,%var1%`,%var2%`,%var3%`,%var4%`,%var5%`,%var6%`,%var7%`,%var8%`,%var9%`,%var10%`,%var11%`,%var12%`,%var13%`,%var17%`,`,`n,output.csv
				var1 := 0
				var2 := 0
				var3 := 0
				var4 := 0
				var5 := 0
				var6 := 0
				var7 := 0
				var8 := 0
				var9 := 0
				var10 := 0
				var11 := 0
				var12 := 0
				var13 := 0
				var14 := 0
				var15 := 0
				var16 := 0
				var17 := 0
			}
		}
		;else if currentLine contains CapturedS2CellId:
		;{
		;	StringTrimLeft, var14, currentLine, 28
		;	FileAppend, CapturedS2CellId: %var14%, output.txt
		;}
		else if currentLine contains CreationTimeMs
		{
			StringTrimLeft, var15, currentLine, 15
			FileAppend, Creation Time (ms): %var15%, output.txt
		}
		;else if currentLine contains family
		;{
		;	FileAppend, Pokemon Family data found`, skipping`n, output.txt
		;	readLine += 1
		;}
		
		
		;PLAYER STATS
		
		
		else if currentLine contains battle_attack_total
		{
			FileAppend, Trainer Stats Found!`n, output.txt
			StringTrimLeft, pla1, currentLine, 20
			FileAppend, Battles Attempted: %pla1%, output.txt
		}
		else if currentLine contains battle_attack_won
		{
			StringTrimLeft, pla2, currentLine, 18
			FileAppend, Battles Won: %pla2%, output.txt
		}
		;else if currentLine contains battle_training_total
		;{
		;	StringTrimLeft, pla3, currentLine, 22
		;	FileAppend, Training Battles: %pla3%, output.txt
		;}
		else if currentLine contains eggs_hatched
		{
			StringTrimLeft, pla4, currentLine, 13
			FileAppend, Eggs Hatched: %pla4%, output.txt
		}
		else if currentLine contains experience
		{
			StringTrimLeft, pla5, currentLine, 11
			FileAppend, Current Trainer XP: %pla5%, output.txt
		}
		else if currentLine contains km_walked
		{
			StringTrimLeft, pla6, currentLine, 10
			FileAppend, Kilometers Walked: %pla6%, output.txt
		}
		else if currentLine contains level
		{
			if currentLine contains next_level_xp
			{
				StringTrimLeft, pla8, currentLine, 14
				FileAppend, XP For Next Level: %pla8%, output.txt
			}
			else if currentLine contains prev_level_xp
			{
				StringTrimLeft, pla3, currentLine, 14
				FileAppend, Previous Level XP Req: %pla3%, output.txt
			}
			else
			{
				StringTrimLeft, pla7, currentLine, 6
				FileAppend, Player Current Level: %pla7%, output.txt
			}
		}
		else if currentLine contains poke_stop_visits
		{
			StringTrimLeft, pla9, currentLine, 17
			FileAppend, Pokestops Visited: %pla9%, output.txt
		}
		else if currentLine contains pokeballs_thrown
		{
			StringTrimLeft, pla10, currentLine, 17
			FileAppend, Pokeballs Thrown: %pla10%, output.txt
		}
		else if currentLine contains pokemons_captured
		{
			StringTrimLeft, pla11, currentLine, 17
			FileAppend, Total Pokemon Captured: %pla11%, output.txt
		}
		else if currentLine contains pokemons_encountered
		{
			StringTrimLeft, pla12, currentLine, 20
			FileAppend, Total Pokemon Encountered%pla12%, output.txt
		}
		else if currentLine contains prestige_dropped_total
		{
			StringTrimLeft, pla13, currentLine, 23
			FileAppend, Prestige Dropped: %pla13%, output.txt
		}
		else if currentLine contains unique_pokedex_entries
		{
			StringTrimLeft, pla14, currentLine, 23
			FileAppend, Unique Pokedex Entries: %pla14%, output.txt
		}
		;ID check
		else if currentLine contains id
		{
			if currentLine contains ,,
			{
				StringTrimLeft, var17, currentLine, 5
				StringUpper, var17, var17, T
				FileAppend, Pokemon UUID: %var1%, output.txt
			}
			else
			{
				StringTrimLeft, var17, currentLine, 3
				StringUpper, var17, var17, T
				FileAppend, Pokemon UUID: %var1%, output.txt
			}
			
		}
		else if currentLine contains POKECOIN
		{
			tmpReadLine := readLine + 1
		
			FileReadLine, currentLine, input.txt, %tmpReadLine%
			if currentLine contains amount
			{
				StringTrimLeft, pla18, currentLine, 11
				FileAppend, Pokecoins: %pla18%, output.txt
			}
			else
			{
				pla18 := 0
				FileAppend, No Pokecoins!, output.txt
			}
			
		}
		else if currentLine contains STARDUST
		{
			tmpReadLine := readLine + 1
			FileReadLine, currentLine, input.txt, %tmpReadLine%
			if currentLine contains amount
			{
				StringTrimLeft, pla19, currentLine, 11
				FileAppend, Stardust: %pla19%, output.txt
			}
			else
			{
				pla19 := 0
				FileAppend, No Stardust!, output.txt
			}
			
		}
		else
		{
			FileAppend, Unknown Line : %currentLine%, output.txt
		}
		
		
			
		

		PercentDone := ((readLine / fileLength) * 100)
		PercentDone := round(PercentDone, 1)
		
		Progress, %PercentDone%, %PercentDone%`% Done, Parsing File... (%PercentDone%`%)
		
		FileAppend, `n, output.txt
		readLine += 1
		
		
	}
	
	
	
	FileAppend, Appending Trainer Data to CSV, output.txt
	
	trainerDataPrepend = trainer`,%pla1%`,%pla2%`,%pla4%`,%pla5%`,%pla6%`,%pla7%`,%pla8%`,%pla9%`,%pla10%`,%pla11%`,%pla12%`,%pla13%`,%pla14%,%pla3%`,%pla18%`,%pla19%`n
	FileRead, csvPrependVal, output.csv 
	FileDelete, output.csv
	FileAppend, %trainerDataPrepend%, output.csv
	FileAppend, %csvPrependVal%, output.csv
	
	pla1 := 0
	pla2 := 0
	pla3 := 0
	pla4 := 0
	pla5 := 0
	pla6 := 0
	pla7 := 0
	pla8 := 0
	pla9 := 0
	pla10 := 0
	pla11 := 0
	pla12 := 0
	pla13 := 0
	pla14 := 0
	pla15 := 0
	pla16 := 0
	pla17 := 0
	pla18 := 0
	pla19 := 0
	
	Progress, Off
	
	run, tv.ahk
	
	ExitApp
}

^]::
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\info.txt
	reload
return

MainGuiGuiClose:
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\info.txt
	ExitApp
return

MngGuiClose:
	Gui, Mng:Destroy
	GuiControl, MainGui:Enable, EmailE
	GuiControl, MainGui:Enable, PasswordE
	GuiControl, MainGui:Enable, GoogleB
	GuiControl, MainGui:Enable, PTCB
	GuiControl, MainGui:Enable, Login
	GuiControl, MainGui:Enable, ActMng
	GuiControl, MainGui:Enable, AddMng
	GuiControl, MainGui:Enable, PoGoServer
return
