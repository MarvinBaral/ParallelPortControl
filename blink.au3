#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         Marvin Baral

 Script Function:
	blink an LED on the parallel port

#ce ----------------------------------------------------------------------------
#include <GUIConstants.au3>
#include "functionsParallelPort.au3"


#cs ;adresses in hex
$parallelPortAdress = "0x378"
=============================
--> $adressDataReg = "0x378"
--> $adressStatusReg = "0x379"
--> $adressControlReg = "0x37A"
#ce

$adress = "0x378"
checkForDllFile(False)

;-------------------GUI-------------------
GUICreate("Parallelport Control - increment-speed at register "&$adress, 400, 50)
$slider = GUICtrlCreateSlider(50, 10, 300, 100)
GUICtrlSetData($slider, 50)
GUICtrlCreateLabel("faster", 360, 20, 30)
GUICtrlCreateLabel("slower", 10, 20, 30)
GUISetState( @SW_SHOW )
Opt("GUIonEventMode" ,1)
GUISetOnEvent( $GUI_EVENT_CLOSE, "_Exit" )
HotKeySet( "{SPACE}", "_Exit" )
HotKeySet( "{ENTER}", "_Exit" )
HotKeySet( "{ESC}", "_Exit" )
Func _Exit()
   Exit
EndFunc

;-----------------------------------------

$value = 0
While True
   $value += 1
   DllCall($dllFile, "int", "Out32", "int", $adress, "int", $value)
   Sleep(100 - GUICtrlRead($slider))
WEnd

