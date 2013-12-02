; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

; auto cascade windows

; ^ = control
; != alt
; # = Win
; + = Shift



;stackoverflow
;^+s:: Run, webs.bat
;return

; CTRL+Shift+Q
^+Q::Run getdns
return

; CTRL+Shift+F
;^+F::Run powershell.exe File "c:\bin\stopzoom.ps1"
;return


; CTRL+Shift+A, Auto HotKey
^+A::Run npp AutoHotkey.ahk
return

; CTRL+Shift+M, Mintty
^+M::Run C:\cygwin\bin\mintty.exe "- perl web.pl"
return


; CTRL+Shift+T, Open Tweet Deck
^+T::
IfWinExist TweetDeck
	WinActivate
else
	Run C:\Program Files (x86)\Twitter\TweetDeck\TweetDeck.exe
return


; CTRL+Shift+S - Snipping Tool
^+S::Run C:\Windows\system32\SnippingTool.exe
return



; CTRL+Shift+P, I want to Previous Track
^+P::Send {Media_Play_Pause}
return


; CTRL+Shift+N, I want to Next Track
^+N::Send {Media_Next}
return

; CTRL+Shift+B, I want to Previous Track
^+B::Send {Media_Prev}
return


; CTRL+Shift+L, I want to Volume Down
^+L::Send {Volume_Down}
return


; CTRL+Shift+U, I want to Volume Up
^+R::Send {Volume_Up}
return

; CTRL+Shift+X, Launch ProcessExporer
^+X::Run C:\Users\gvilla\Documents\SysinternalsSuite\procexp.exe
return


#0:: DllCall( "CascadeWindows", uInt,0, Int,4, Int,0, Int,0, Int,0 )
return

; CTRL+Shift+C Sends a copy, then sends Clipboard to Run
^+c::
{
Send, ^c
Sleep 50
Run, %clipboard%
Return
}

; Ctrl + E This is my Docs
^+e::Run explorer.exe C:\Users\%USERNAME%\Documents\
return

; Ctrl + w This is my Downloads
^+W::Run explorer.exe C:\Users\%USERNAME%\Downloads
return


; Win + z
#z::Run www.autohotkey.com
return

; Win + c
#c::
IfWinExist Administrator: DOS2
	WinActivate
else
Run c2
return

; Win + n
#n::
Run npp
return

; CTRL+Shift+Z for Zoomit
^+Z::
Run c:\sys\zoomit.exe
return

; Win + s
#s::
Run C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\Ssms.exe
return

; Control+Alt+g //Search Google from Any Application
;^!g::
^+g::
{
Send, ^c
Sleep 50
Run, http://www.google.com/search?q=%clipboard%
Return
}

; Control+Alt+r //Copies and runs
^!r::
{
Send, ^c
Sleep 50
Run, %clipboard%
Return
}


; Minimize Active Windows with Caps Lock
Capslock::WinMinimize,A

; Control+Alt+Ng
;^!n::
;IfWinExist Untitled - Notepad
;	WinActivate
;else
;	Run Notepad
;return


; *************************      Below Drags window by Alt and mouse grab     **************************************************


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.


; This script modified from the original: http://www.autohotkey.com/docs/scripts/EasyWindowDrag.htm
; by The How-To Geek
; http://www.howtogeek.com 

Alt & LButton::
CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
if EWD_WinState = 0  ; Only if the window isn't maximized 
    SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
return

EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; Button has been released, so drag is complete.
{
    SetTimer, EWD_WatchMouse, off
    return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
{
    SetTimer, EWD_WatchMouse, off
    WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
    return
}
; Otherwise, reposition the window to match the change in mouse coordinates
; caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return

;=======================================================================================
;BDD Test Naming Mode AHK Script
;
;Description:
;  Replaces spaces with underscores while typing, to help with writing BDD test names.
;  Toggle on and off with Ctrl + Shift + U.
;=======================================================================================


;==========================
;Initialise
;==========================
#NoEnv
SendMode Input 
SetWorkingDir %A_ScriptDir% 

enabledIcon := "testnamingmode_16.ico"
disabledIcon := "testnamingmode_disabled_16.ico"
IsInTestNamingMode := false
SetTestNamingMode(false)

;==========================
;Functions
;==========================
SetTestNamingMode(toActive) {
  local iconFile := toActive ? enabledIcon : disabledIcon
  local state := toActive ? "ON" : "OFF"

  IsInTestNamingMode := toActive
  Menu, Tray, Icon, %iconFile%,
  Menu, Tray, Tip, Test naming mode is %state%  

  Send {Shift Up}
}

;==========================
;Test Mode toggle
;==========================
^+u::
  SetTestNamingMode(!IsInTestNamingMode)
return


;==========================
;Handle Enter press
;==========================
$Enter::
  if (IsInTestNamingMode){
	SetTestNamingMode(!IsInTestNamingMode)
  }
  else{
	  Send, {Enter}
 }
return

;==========================
;Handle Escape press
;==========================
$Escape::
  if (IsInTestNamingMode){
	SetTestNamingMode(!IsInTestNamingMode)
  }
  else{
  Send, {Escape}
  }
return

;==========================
;Handle SPACE press
;==========================
$Space::
  if (IsInTestNamingMode) {
    Send, _
  } else {
    Send, {Space}
  }











