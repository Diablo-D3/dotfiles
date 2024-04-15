var args = WScript.Arguments;
var file = args(0);
var fileargs = '';
var wshShell = new ActiveXObject("WScript.Shell");

for (i = 1; i < args.length; i++) {
    fileargs += (args(i) + " ");
}

wshShell.Run('%SystemRoot%\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -ExecutionPolicy Bypass -File "' + file + '" ' + fileargs, 0, false);

