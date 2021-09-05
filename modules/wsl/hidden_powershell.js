var args = WScript.Arguments;
var wshShell = new ActiveXObject("WScript.Shell");

wshShell.Run('%SystemRoot%\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -ExecutionPolicy Bypass -File "' + args(0) + '"', 0, false);

