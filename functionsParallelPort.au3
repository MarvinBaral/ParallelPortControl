#include-once
#include <MsgBoxConstants.au3>
$dllFile = "C:\WINDOWS\system32\inpout32.dll"

Func setParallelPortRegisterToValue( $register, $value, $check )
   ;"0x378" to "0x37A", 0-255 d, 0x00-0xFF h, bool that en/disables return value which displays result of check
   DllCall($dllFile, "int", "Out32", "int", $register, "int", $value)

   ;recheck, only works well with data regisster
   If $check Then
	  sleep(1)
	  $response = DllCall($dllFile, "int", "Inp32", "int", $register)
	  $confirmedValue = $response[0]
	  If $confirmedValue = $value Or Binary($confirmedValue) = $value Then
		 Return True
	  Else
		 Return False
	  EndIf
   EndIf
EndFunc

Func readFromParallelPortRegister( $register, $showMsgBox );"0x378" to "0x37A",
   $value = DllCall($dllFile, "int", "Inp32", "int", $register)
   $state = $value[0]
   If $showMsgBox Then
	  MsgBox(0,"State of "&$register,$state&" ("&Binary($state)&")")
   EndIf
   Return $state
EndFunc

Func checkForDllFile( $displaySuccess )
   If FileExists($dllFile) Then
	  If $displaySuccess Then
		 MsgBox(0,"success","inpout32.dll found",1)
	  EndIf
	  Return True
   Else
	  MsgBox($ICON_ERROR,"Error",$dllFile&" not found.")
	  Return False
   EndIf
EndFunc

Func findOutToggledPins($showMsgBox)
   $register = "0x379"
   ;standard: 0x01111110
   Local $bPinStates[5] = [False, False, False, False, False] ;Pin 3, 4, 5, 6, 7
   $value = readFromParallelPortRegister($register, False)

   If $value < 1126 Then
	  $value = BitShift($value, 3)

	  $value = BitXOR($value, 15)

	  $divisor = 16
	  For $i = 0 To 4
		 If $value >= $divisor Then
			$bPinStates[$i] = True
			$value -= $divisor
		 EndIf
		 $divisor = $divisor * 0.5
	  Next

   EndIf

   If $showMsgBox Then
	  $string = "States of the Pins:"
	  For $i = 0 To 4
		 $string &= @CRLF & "Pin " & $i + 3 & ": " & $bPinStates[$i]
	  Next

	  MsgBox(0, "Pinstates", $string)
   EndIf

   Return $bPinStates
EndFunc
;===========Testscripts=========================
#cs
checkForDllFile(True)
$register = "0x378"
If setParallelPortRegisterToValue( $register, 255, True ) Then
   MsgBox(0,"","ok")
EndIf

#ce

