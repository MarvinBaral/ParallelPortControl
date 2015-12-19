   #include-once
#include "functionsParallelPort.au3"

$register = "0x379"

While True
   $value = readFromParallelPortRegister($register, False)
   setParallelPortRegisterToValue($register - 1, $value, False)
WEnd