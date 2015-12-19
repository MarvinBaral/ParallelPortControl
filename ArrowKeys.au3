#include-once
#include "functionsParallelPort.au3"


Local $keysAssigned[5] = ["{LEFT}", "{UP}", "{ENTER}", "{RIGHT}", "{DOWN}"]

While True
   $delay = 50
   $keysPressed = findOutToggledPins(False)
   For $i = 0 To 4
	  If $keysPressed[$i] Then
		 Send($keysAssigned[$i])
		 $delay = 300
	  EndIf
   Next
   Sleep($delay)
WEnd