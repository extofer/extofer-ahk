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


; CTRL+Shift+N, I want to Next Track
^+N::Send {Media_Next}
return

; CTRL+Shift+P, I want to Previous Track
^+P::Send {Media_Prev}
return

; CTRL+Shift+D, I want to Volume Down
^+D::Send {Volume_Down}
return


; CTRL+Shift+U, I want to Volume Up
^+U::Send {Volume_Up}
return


#0:: DllCall( "CascadeWindows", uInt,0, Int,4, Int,0, Int,0, Int,0 )
return

; Win + Shift + E This is my Dev Enviornment Dev - Billing Repository
#+e::Run explorer.exe "C:\Users\gvilla\Documents\Dev - Billing"
return

; Win + F2 this is a web page with my shortcuts
#F2::Run C:/Users/gvilla/Documents/_mypath/hotkeys.htm
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

; Win + s
#s::
Run C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\Ssms.exe
return

; Control+Alt+g //Search Google from Any Application
^!g::
{
Send, ^c
Sleep 50
Run, http://www.google.com/search?q=%clipboard%
Return
}

; Control+Shift+r //Copies and runs
^+r::
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









