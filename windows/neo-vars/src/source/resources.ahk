EnvGet, WindowsEnvTempFolder, TEMP
ResourceFolder = %WindowsEnvTempFolder%\NEO2
FileCreateDir, %ResourceFolder%

if (FileExist("ResourceFolder")<>false) {
  FileInstall,neo_enabled.ico,%ResourceFolder%\neo_enabled.ico,1
  FileInstall,neo_disabled.ico,%ResourceFolder%\neo_disabled.ico,1
  FileInstall,ebene1.png,%ResourceFolder%\ebene1.png,1
  FileInstall,ebene2.png,%ResourceFolder%\ebene2.png,1
  FileInstall,ebene3.png,%ResourceFolder%\ebene3.png,1
  FileInstall,ebene4.png,%ResourceFolder%\ebene4.png,1
  FileInstall,ebene5.png,%ResourceFolder%\ebene5.png,1
  FileInstall,ebene6.png,%ResourceFolder%\ebene6.png,1
  FileInstall,deadkeys.png,%ResourceFolder%\deadkeys.png,1
}

