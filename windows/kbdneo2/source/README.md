# Build-Anleitung für kbdneo / kbdbone / kbdqwertz

## Voraussetzungen

Aktuell notwendig zum Bauen sind folgende Programme:
* Visual Studio (2017 oder neuer)
  * Desktop-Entwicklung mit C++ installiert
* Windows 10 SDK (10.0.19041 oder neuer)
* Windows Driver Kit (Version 2004 oder neuer)
  * siehe Anleitung: https://docs.microsoft.com/en-us/windows-hardware/drivers/download-the-wdk
  
## Build

* kbd.sln in Visual Studio öffnen
* Release-Build einstellen und Konfiguration x64 auswählen
* Build solution
* Konfiguration x86 auswählen
* Build solution

Für jedes der enthaltenen Tastaturlayouts sind nun je zwei .dll-Dateien (Name = Projektname) gebaut worden. Diese müssen mit einem 64-Bit-fähigen Dateimanager (z.B. Windows Explorer) in die entsprechenden Verzeichnisse kopiert werden:
* x64\release\kbd*.dll → C:\Windows\System32
* release\kbd*.dll → C:\Windows\SysWOW64
