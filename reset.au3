   #include-once
#include "functionsParallelPort.au3"

$register = "0x379"

MsgBox(0, "Result", setParallelPortRegisterToValue($register, "0x11111111", True))
