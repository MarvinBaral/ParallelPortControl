#include-once
#include "functionsParallelPort.au3"

$oldClipboard = ""
While True
   $newClipboard = ClipGet()
   If $oldClipboard <> $newClipboard And Not ProcessExists("PCS500.exe") Then
	  $newClipboard = Int($newClipboard)
	  $binary = Binary($newClipboard)
	  setParallelPortRegisterToValue("0x378", $binary, False)
   EndIf
   $oldClipboard = $newClipboard
   Sleep(100)
WEnd
