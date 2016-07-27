;
;Program Name by Noahc3
;Additional Credits
;Built with Autohotkey 1.1.22.09
;Program Version
;
;Source Code available at [Link]
;

val1 = 0
val2 = 0
val3 = 0
val4 = 0
val5 = 0
val6 = 0
val7 = 0
val8 = 0
val9 = 0
val10 = 0
val11 = 0
val12 = 0
val13 = 0
val17 = 0
val31 = 0
	
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include %A_ScriptDir%\libs\csv_lib.ahk
#Include %A_ScriptDir%\libs\tf.ahk
#Include %A_ScriptDir%\libs\zip.ahk

Gui, Main:default

CSV_Load("output.csv", "teamList", ",")

ifnotexist, %A_ScriptDir%\res
{
	FileCreateDir, %A_ScriptDir%\res
	FileCreateDir, %A_ScriptDir%\res\pokemon
	DownloadFile("https://s3.amazonaws.com/noahc3-go/pkmn.zip", A_ScriptDir . "\res\pkmn.zip", false, true)
	
	Unz(A_ScriptDir . "\res\pkmn.zip", A_ScriptDir . "\res\pokemon")
}
teamLength:=TF_CountLines("output.csv")
tempVar1 = 2
amountList =
resGet = 1
foundTrainer = 0
trLineCheck = 1
trainerLine = 0

while foundTrainer = 0
{
	trVar1 := CSV_ReadCell("teamList", trLineCheck, 1)
	if trVar1 = trainer
	{
		trainerLine = trLineCheck
		amountList = %amountList%Trainer|
		foundTrainer = 1
	}
	else
	{
		trLineCheck += 1
	}
}

tempVar1 = 2
while not tempVar1 = teamLength
{
	tempVar12 := round(((CSV_ReadCell("teamList", tempVar1, 10) + CSV_ReadCell("teamList", tempVar1, 11) + CSV_ReadCell("teamList", tempVar1, 12)) / 45) * 100, 2)
	
	tempVar2 := CSV_ReadCell("teamList", tempVar1, 2)
	
	tempVar4 := CSV_ReadCell("teamList", tempVar1, 3)
	
	
	
	amountList = %amountList%%tempVar2%`,   CP: %tempVar4%`,   IV: %tempVar12%`%|
	
	tempVar1 += 1
}

Gui, Add, DropDownList, x12 y29 w220 h240 AltSubmit gPokeList vPokeList Choose1 HwndPokelisthwnd, %amountList%
Gui, Add, Picture, x32 y69 w100 h100 +Border vPokemonIcon, %A_ScriptDir%\res\pokemon\1.png
Gui, Add, Text, x32 y179 w100 h20 +Center +Border vIDText, ID
Gui, Add, Text, x162 y69 w100 h20 vHPText, HP/HPMAX
Gui, Add, Progress, x162 y89 w180 h10 +Border vHealthBar, 100
Gui, Add, Text, x285 y69 w70 h20 vCP, CP: 
Gui, Add, Text, x32 y219 w100 h20 +Center vWeight, Weight (KG):
Gui, Add, Text, x32 y249 w100 h20 +Center vHeight, Height (M):
Gui, Add, Button, x585 y279 w100 h30 gClose, Close
Gui, Add, Button, x465 y279 w100 h30 gTransfer, Transfer
Gui, Add, Button, x345 y279 w100 h30 gBulkTransfer, Bulk Transfer
Gui, Add, Text, x162 y124 w70 h20 vIV, IV's:
Gui, Add, Text, x162 y144 w150 h20 vAIV, Attack: 
Gui, Add, Text, x162 y164 w150 h20 vDIV, Defense: 
Gui, Add, Text, x162 y184 w150 h20 vHIV, HP: 
Gui, Add, Text, x162 y204 w150 h20 vPIV, Perfection: 
Gui, Add, Picture, x340 y127 w16 h16 , %A_ScriptDir%\res\img\pokeball.png
Gui, Add, Text, x360 y129 w230 h20 vPokeball, Pokeball Used: Standard
Gui, Add, Text, x360 y159 w230 h20 vFWeight, Full Weight (KG): 
Gui, Add, Text, x360 y179 w230 h20 vFHeight, Full Height (M): 
Gui, Add, Text, x360 y239 w230 h20 vCPMult, CP Multiplier:
Gui, Add, Text, x360 y219 w230 h20 vUUID, Pokemon UUID:
Gui, Add, Text, x360 y199 w230 h20 vIDBase, ID: 
Gui, Add, Text, x360 y69 w170 h20 vMove1, Move 1: 
Gui, Add, Text, x530 y69 w170 h20 vMove2, Move 2: 
; Generated using SmartGUI Creator 4.0
Gui, Show, h321 w699, Pokemon GO! Team Manager

DefaultDDL()




Return


PokeList:
	Gui, Submit, Nohide
	
	if PokeList = 1
	{
		DefaultDDL()
	}
	else
	{
		val1 := CSV_ReadCell("teamList", PokeList, 2)
		val2 := CSV_ReadCell("teamList", PokeList, 3)
		val3 := CSV_ReadCell("teamList", PokeList, 4)
		val4 := CSV_ReadCell("teamList", PokeList, 5)
		val5 := CSV_ReadCell("teamList", PokeList, 6)
		val6 := CSV_ReadCell("teamList", PokeList, 7)
		val7 := CSV_ReadCell("teamList", PokeList, 8)
		val8 := CSV_ReadCell("teamList", PokeList, 9)
		val9 := CSV_ReadCell("teamList", PokeList, 10)
		val10 := CSV_ReadCell("teamList", PokeList, 11)
		val11 := CSV_ReadCell("teamList", PokeList, 12)
		val12 := CSV_ReadCell("teamList", PokeList, 13)
		val13 := CSV_ReadCell("teamList", PokeList, 14)
		val17 := CSV_ReadCell("teamList", PokeList, 15)
		val31 := round(((CSV_ReadCell("teamList", PokeList, 10) + CSV_ReadCell("teamList", PokeList, 11) + CSV_ReadCell("teamList", PokeList, 12)) / 45) * 100, 2)
		
		val14 := getIdenFromName(val1)
		
		val15 := Round(val7, 2)
		val16 := Round(val8, 2)
		
		if val13 = ITEM_POKE_BALL
		{
			val13 = Standard
		}
		else if val13 = ITEM_GREAT_BALL
		{
			val13 = Great
		}
		else if val13 = ITEM_ULTRA_BALL
		{
			val13 = Ultra
		}
		else
		{
			val13 = Promo/Unknown
		}
		
		
		GuiControl, Text, IDText, %val1%
		
		GuiControl, show, CP
		GuiControl, show, CPMult
		GuiControl, show, IDBase
		GuiControl, show, Transfer
		GuiControl, show, Bulk Transfer
		GuiControl, show, PIV
		GuiControl, Text, IV, IVs:
		
		GuiControl, Text, CP, CP: %val2%
		GuiControl, Text, Height, Height (M): %val15%
		GuiControl, Text, Weight, Weight (KG): %val16%
		GuiControl, Text, FHeight, Full Height (M): %val7%
		GuiControl, Text, FWeight, Full Weight (KG): %val8%
		GuiControl, Text, AIV, Attack: %val9%
		GuiControl, Text, DIV, Defense: %val10%
		GuiControl, Text, HIV, HP: %val11%
		GuiControl, Text, PIV, Perfection: %val31%`%
		GuiControl, Text, Pokeball, Pokeball Caught In: %val13%
		GuiControl, Text, Move1, Move 1: %val5%
		GuiControl, Text, Move2, Move 2: %val6%
		GuiControl, Text, HPText, HP: %val3%`/%val4%
		GuiControl, Text, CPMult, CP Multiplier: %val12%
		GuiControl, Text, IDBase, ID: %val14%
		GuiControl, Text, UUID, Pokemon UUID %val17%
		GuiControl, , PokemonIcon, %A_ScriptDir%\res\pokemon\%val14%.png
		
		healthPercentage := ((val3 / val4)  * 100)
		
		GuiControl, , HealthBar, %healthPercentage%
		
		
		Gui, Submit, Nohide
	}
	
	
return

Transfer:
	
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\doneRelease.txt
	run, python "%A_ScriptDir%\libs\py\pogoapi\release.py" --uuid %val17%, %A_ScriptDir%\libs\py\pogoapi
	
	continue = 0
	
	While continue = 0
	{
		IfExist, %A_ScriptDir%\libs\py\pogoapi\doneRelease.txt
		{
			continue = 1
		}
	} 
	
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\doneRelease.txt
	
	oldPokeList = %PokeList%
	
	
	
	TF_RemoveLines("!output.csv", oldPokeList, oldPokeList)

	CSV_Load("output.csv", "teamList", ",")
	refreshCache()
	GuiControl, Choose, PokeList, |%oldPokeList%
	
	
	Gui, Submit, Nohide
	
	Msgbox, Transfer Finished!
return

BulkTransfer:
	Gui, Bulk:Add, ListBox, x20 y20 w240 h300 AltSubmit vTransferList 8, %amountList%
	Gui, Bulk:Add, Button, x90 y320 w100 h30 gInitBulk, Bulk Transfer
	Gui, Bulk:Show, h400 w280, Bulk Transfer
	
return

InitBulk:
	
	MsgBox, 68, Bulk Transfer, This might take some time, would you like to continue?
	IfMsgBox, No
	{
		return
	}
	
	Gui, Submit, Nohide
	
	Decrement = 0

	;debug MsgBox, %TransferList%
	
	transferListStorage := TransferList
	
	Loop, parse, TransferList, |
	{
		if A_LoopField = 1
		{
			Msgbox, You can't release your trainer! Skipping.
			GoTo skipLoop
		}
	
	
		Random, rngsus, 100, 1000
		
		rngsusPassIn := 750 + rngsus
	
		sleep, %rngsusPassIn%
	
		
		loopFieldStorage := A_LoopField
		
		uuidField := CSV_ReadCell("teamList", loopFieldStorage, 15)
		
		;debug MsgBox, %uuidField%
		
		FileDelete, %A_ScriptDir%\libs\py\pogoapi\doneRelease.txt
		run, python "%A_ScriptDir%\libs\py\pogoapi\release.py" --uuid %uuidField%, %A_ScriptDir%\libs\py\pogoapi
		
		continue = 0
		
		While continue = 0
		{
			IfExist, %A_ScriptDir%\libs\py\pogoapi\doneRelease.txt
			{
				continue = 1
			}
		} 
		
		FileDelete, %A_ScriptDir%\libs\py\pogoapi\doneRelease.txt
		
		
		
		
		Gui, Submit, Nohide
		
		skipLoop:
		
		
	}
	
	Sort, transferListStorage, R N D|
	
	Loop, parse, transferListStorage, |
	{
		if A_LoopField = 1
		{
			GoTo skipLoop2
		}
		TF_RemoveLines("!output.csv", A_LoopField, A_LoopField)

		CSV_Load("output.csv", "teamList", ",")
		refreshCache()
		
		skipLoop2:
		
	
	}
	

	Gui, Bulk:Destroy

	GuiControl, Main:Choose, PokeList, |1
	
	DefaultDDL()

	MsgBox, Done!

return

Close:
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\info.txt
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\session.txt
	ExitApp
return

^[::
	reload
return

MainGuiClose:
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\info.txt
	FileDelete, %A_ScriptDir%\libs\py\pogoapi\session.txt
	ExitApp
return

BulkGuiClose:
	Gui, Bulk:Destroy
return

DefaultDDL()
{
		val1 := CSV_ReadCell("teamList", 1, 2)
		val2 := CSV_ReadCell("teamList", 1, 3)
		val3 := CSV_ReadCell("teamList", 1, 4)
		val4 := CSV_ReadCell("teamList", 1, 5)
		val5 := CSV_ReadCell("teamList", 1, 6)
		val6 := CSV_ReadCell("teamList", 1, 7)
		val7 := CSV_ReadCell("teamList", 1, 8)
		val8 := CSV_ReadCell("teamList", 1, 9)
		val9 := CSV_ReadCell("teamList", 1, 10)
		val10 := CSV_ReadCell("teamList", 1, 11)
		val11 := CSV_ReadCell("teamList", 1, 12)
		val12 := CSV_ReadCell("teamList", 1, 13)
		val13 := CSV_ReadCell("teamList", 1, 14)
		val17 := CSV_ReadCell("teamList", 1, 15)
		
		val5 := round(val5, 2)
		
		GuiControl, Text, IDText, Level: %val6%
		GuiControl, Hide, CP
		GuiControl, Hide, CPMult
		GuiControl, Hide, IDBase
		GuiControl, Hide, Transfer
		GuiControl, Hide, Bulk Transfer
		GuiControl, Hide, PIV
		GuiControl, Text, IV, Stats:
		GuiControl, Text, Weight, Battles Attempted: %val1% 
		GuiControl, Text, Height, Battles Won: %val2% 
		GuiControl, Text, FHeight, Pokemon Captured: %val10%
		GuiControl, Text, FWeight, Pokemon Encountered: %val11%
		GuiControl, Text, AIV, Pokeballs Thrown: %val9%
		GuiControl, Text, DIV, Stops Visited: %val8%
		GuiControl, Text, HIV, Eggs Hatched: %val3% 
		GuiControl, Text, Pokeball, Unique Pokedex Entries %val13%
		GuiControl, Text, Move1, KM Walked: %val5%
		GuiControl, Text, Move2, Prestige Dropped: %val12%
		GuiControl, Text, HPText, XP: %val4%`/%val7%
		GuiControl, Text, UUID, Previous Level XP: %val17%
		GuiControl, , PokemonIcon, %A_ScriptDir%\res\img\trainer_1.png
		
		val21 := ((val4 / val7) * 100)
		
		GuiControl, , HealthBar, %val21%
}

^\::
	if Pokelist = 1
	{
		return
	}
	else
	{
		Goto, Transfer
	}
return

refreshCache()
{
	
	teamLength:=TF_CountLines("output.csv")
	tempVar1 = 2
	amountList =
	resGet = 1
	foundTrainer = 0
	trLineCheck = 1
	trainerLine = 0

	while foundTrainer = 0
	{
		trVar1 := CSV_ReadCell("teamList", trLineCheck, 1)
		if trVar1 = trainer
		{
			trainerLine = trLineCheck
			amountList = %amountList%Trainer|
			foundTrainer = 1
		}
		else
		{
			trLineCheck += 1
		}
	}

	tempVar1 = 2
	while not tempVar1 = teamLength
	{
		tempVar2 := CSV_ReadCell("teamList", tempVar1, 2)
		
		tempVar4 := CSV_ReadCell("teamList", tempVar1, 3)
		
		
		
		amountList = %amountList%%tempVar2%`, CP: %tempVar4%|
		
		tempVar1 += 1
	}
	GuiControl, Main: , PokeList, |
	GuiControl, Main: , PokeList, %amountList%
	GuiControl, Bulk: , TransferList, |
	GuiControl, Bulk: , TransferList, %amountList%
	
	DefaultDDL()
}





;File Downloader by Bruttosozialprodukt
DownloadFile(UrlToFile, SaveFileAs, Overwrite := True, UseProgressBar := True) {
    ;Check if the file already exists and if we must not overwrite it
      If (!Overwrite && FileExist(SaveFileAs))
          Return
    ;Check if the user wants a progressbar
      If (UseProgressBar) {
          ;Initialize the WinHttpRequest Object
            WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
          ;Download the headers
            WebRequest.Open("HEAD", UrlToFile)
            WebRequest.Send()
          ;Store the header which holds the file size in a variable:
            FinalSize := WebRequest.GetResponseHeader("Content-Length")
          ;Create the progressbar and the timer
            Progress, H80, , Downloading..., %UrlToFile%
            SetTimer, __UpdateProgressBar, 100
      }
    ;Download the file
      UrlDownloadToFile, %UrlToFile%, %SaveFileAs%
    ;Remove the timer and the progressbar because the download has finished
      If (UseProgressBar) {
          Progress, Off
          SetTimer, __UpdateProgressBar, Off
      }
    Return
    
    ;The label that updates the progressbar
      __UpdateProgressBar:
          ;Get the current filesize and tick
            CurrentSize := FileOpen(SaveFileAs, "r").Length ;FileGetSize wouldn't return reliable results
            CurrentSizeTick := A_TickCount
          ;Calculate the downloadspeed
            Speed := Round((CurrentSize/1024-LastSize/1024)/((CurrentSizeTick-LastSizeTick)/1000)) . " Kb/s"
          ;Save the current filesize and tick for the next time
            LastSizeTick := CurrentSizeTick
            LastSize := FileOpen(SaveFileAs, "r").Length
          ;Calculate percent done
            PercentDone := Round(CurrentSize/FinalSize*100)
          ;Update the ProgressBar
            Progress, %PercentDone%, %PercentDone%`% Done, Downloading...  (%Speed%), Downloading %SaveFileAs% (%PercentDone%`%)
      Return
}


;oh god dont look man, look for some reason it wouldnt work when i put it in a seperate library and i didnt feel like spending more time on why :P

getIdenFromName(id)
{
	if id = Bulbasaur
	{
	return 1
	}
	else if id = Ivysaur
	{
	return 2
	}
	else if id = Venusaur
	{
	return 3
	}
	else if id = Charmander
	{
	return 4
	}
	else if id = Charmeleon
	{
	return 5
	}
	else if id = Charizard
	{
	return 6
	}
	else if id = Squirtle
	{
	return 7
	}
	else if id = Wartortle
	{
	return 8
	}
	else if id = Blastoise
	{
	return 9
	}
	else if id = Caterpie
	{
	return 10
	}
	else if id = Metapod
	{
	return 11
	}
	else if id = Butterfree
	{
	return 12
	}
	else if id = Weedle
	{
	return "13"
	}
	else if id = Kakuna
	{
	return 14
	}
	else if id = Beedrill
	{
	return 15
	}
	else if id = Pidgey
	{
	return 16
	}
	else if id = Pidgeotto
	{
	return 17
	}
	else if id = Pidgeot
	{
	return 18
	}
	else if id = Rattata
	{
	return 19
	}
	else if id = Raticate
	{
	return 20
	}
	else if id = Spearow
	{
	return 21
	}
	else if id = Fearow
	{
	return 22
	}
	else if id = Ekans
	{
	return 23
	}
	else if id = Arbok
	{
	return 24
	}
	else if id = Pikachu
	{
	return 25
	}
	else if id = Riachu
	{
	return 26
	}
	else if id = Sandshrew
	{
	return 27
	}
	else if id = Sandslash
	{
	return 28
	}
	else if id = Nidoran_female
	{
	return 29
	}
	else if id = Nidorina
	{
	return 30
	}
	else if id = Nidoqueen
	{
	return 31
	}
	else if id = Nidoran_male
	{
	return 32
	}
	else if id = Nidorino
	{
	return 33
	}
	else if id = Nidoking
	{
	return 34
	}
	else if id = Clefairy
	{
	return 35
	}
	else if id = Clefable
	{
	return 36
	}
	else if id = Vulpix
	{
	return 37
	}
	else if id = Ninetales
	{
	return 38
	}
	else if id = Jigglypuff
	{
	return 39
	}
	else if id = Wifflytuff
	{
	return 40
	}
	else if id = Zubat
	{
	return 41
	}
	else if id = Golbat
	{
	return 42
	}
	else if id = Oddish
	{
	return 43
	}
	else if id = Gloom
	{
	return 44
	}
	else if id = Vileplume
	{
	return 45
	}
	else if id = Paras
	{
	return 46
	}
	else if id = Parasect
	{
	return 47
	}
	else if id = Venonat
	{
	return 48
	}
	else if id = Venomoth
	{
	return 49
	}
	else if id = Diglett
	{
	return 50
	}
	else if id = Dugtrio
	{
	return 51
	}
	else if id = Meowth
	{
	return 52
	}
	else if id = Persian
	{
	return 53
	}
	else if id = Psyduck
	{
	return 54
	}
	else if id = Golduck
	{
	return 55
	}
	else if id = Mankey
	{
	return 56
	}
	else if id = Primeape
	{
	return 57
	}
	else if id = Glowlithe
	{
	return 58
	}
	else if id = Arcanine
	{
	return 59
	}
	else if id = Poliwag
	{
	return 60
	}
	else if id = Poliwhirl
	{
	return 61
	}
	else if id = Poliwrath
	{
	return 62
	}
	else if id = Abra
	{
	return 63
	}
	else if id = Kadabra
	{
	return 64
	}
	else if id = Alakazam
	{
	return 65
	}
	else if id = Machop
	{
	return 66
	}
	else if id = Machoke
	{
	return 67
	}
	else if id = Machamp
	{
	return 68
	}
	else if id = Bellsprout
	{
	return 69
	}
	else if id = Weepinbell
	{
	return 70
	}
	else if id = Victreebel
	{
	return 71
	}
	else if id = Tentacool
	{
	return 72
	}
	else if id = Tentacruel
	{
	return 73
	}
	else if id = Geodude
	{
	return 74
	}
	else if id = Graveler
	{
	return 75
	}
	else if id = Golem
	{
	return 76
	}
	else if id = Ponyta
	{
	return 77
	}
	else if id = Rapidash
	{
	return 78
	}
	else if id = Slowpoke
	{
	return 79
	}
	else if id = Slowbro
	{
	return 80
	}
	else if id = Magnemite
	{
	return 81
	}
	else if id = Magneton
	{
	return 82
	}
	else if id = Farfetchd
	{
	return 83
	}
	else if id = Doduo
	{
	return 84
	}
	else if id = Dodrio
	{
	return 85
	}
	else if id = Seel
	{
	return 86
	}
	else if id = Dewgong
	{
	return 87
	}
	else if id = Grimer
	{
	return 88
	}
	else if id = Muk
	{
	return 89
	}
	else if id = Shellder
	{
	return 90
	}
	else if id = Cloyster
	{
	return 91
	}
	else if id = Gastly
	{
	return 92
	}
	else if id = Haunter
	{
	return 93
	}
	else if id = Gengar
	{
	return 94
	}
	else if id = Onic
	{
	return 95
	}
	else if id = Drowzee
	{
	return 96
	}
	else if id = Hypno
	{
	return 97
	}
	else if id = Krabby
	{
	return 98
	}
	else if id = Kingler
	{
	return 99
	}
	else if id = Voltorb
	{
	return 100
	}
	else if id = Electrode
	{
	return 101
	}
	else if id = Exeggcute
	{
	return 102
	}
	else if id = Exeggutor
	{
	return 103
	}
	else if id = Cubone
	{
	return 104
	}
	else if id = Marowak
	{
	return 105
	}
	else if id = Hitmonlee
	{
	return 106
	}
	else if id = Hitmonchan
	{
	return 107
	}
	else if id = Lickitung
	{
	return 108
	}
	else if id = Koffing
	{
	return 109
	}
	else if id = Weezing
	{
	return 110
	}
	else if id = Rhyhorn
	{
	return 111
	}
	else if id = Rhydon
	{
	return 112
	}
	else if id = Chansey
	{
	return 113
	}
	else if id = Tangela
	{
	return 114
	}
	else if id = Kangaskhan
	{
	return 115
	}
	else if id = Horsea
	{
	return 116
	}
	else if id = Seadra
	{
	return 117
	}
	else if id = Goldeen
	{
	return 118
	}
	else if id = Seaking
	{
	return 119
	}
	else if id = Staryu
	{
	return 120
	}
	else if id = Starmie
	{
	return 121
	}
	else if id = Mr Mime
	{
	return 122
	}
	else if id = Scyther
	{
	return 123
	}
	else if id = Jynx
	{
	return 124
	}
	else if id = Electabuzz
	{
	return 125
	}
	else if id = Magmar
	{
	return 126
	}
	else if id = Pinsir
	{
	return 127
	}
	else if id = Tauros
	{
	return 128
	}
	else if id = Magikarp
	{
	return 129
	}
	else if id = Gyrados
	{
	return 130
	}
	else if id = Lapras
	{
	return 131
	}
	else if id = Ditto
	{
	return 132
	}
	else if id = Eevee
	{
	return 133
	}
	else if id = Vaporeon
	{
	return 134
	}
	else if id = Jolteon
	{
	return 135
	}
	else if id = Flareon
	{
	return 136
	}
	else if id = Porygon
	{
	return 137
	}
	else if id = Omanyte
	{
	return 138
	}
	else if id = Omastar
	{
	return 139
	}
	else if id = Kabuto
	{
	return 140
	}
	else if id = Kabutops
	{
	return 141
	}
	else if id = Aerodactyl
	{
	return 142
	}
	else if id = Snorlax
	{
	return 143
	}
	else if id = Articuno
	{
	return 144
	}
	else if id = Zapdos
	{
	return 145
	}
	else if id = Moltres
	{
	return 146
	}
	else if id = Dratini
	{
	return 147
	}
	else if id = Dragonair
	{
	return 148
	}
	else if id = Dragonite
	{
	return 149
	}
	else if id = Mewtwo
	{
	return 150
	}
	else if id = Mew
	{
	return 151
	}
}
return