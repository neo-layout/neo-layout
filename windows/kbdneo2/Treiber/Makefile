all: kbdneo32 kbdneo64 kbdneo_ahk

kbdneo32: reg_backup.bat kbdneo2_install.reg kbdneo2_uninstall.reg 32bit_Windows/kbdneo2.dll
	mkdir -p kbdneo32
	cp reg_backup.bat kbdneo2_install.reg kbdneo2_uninstall.reg 32bit_Windows/kbdneo2.dll kbdneo32
	cd kbdneo32; zip -r kbdneo32 *
	mv kbdneo32/kbdneo32.zip .

kbdneo64: reg_backup.bat kbdneo2_install.reg kbdneo2_uninstall.reg 64bit_Windows/kbdneo2.dll
	mkdir -p kbdneo64
	cp reg_backup.bat kbdneo2_install.reg kbdneo2_uninstall.reg 64bit_Windows/kbdneo2.dll kbdneo64
	cd kbdneo64; zip -r kbdneo64 *
	mv kbdneo64/kbdneo64.zip .

kbdneo_ahk: /home/erik/Ahk2Exe/Ahk2Exe.exe /home/erik/Ahk2Exe/AutoHotkeySC.bin /home/erik/Ahk2Exe/upx.exe AHK_für_kbdneo2/neo_enabled.ico AHK_für_kbdneo2/kbdneo2.ahk
	cd AHK_für_kbdneo2; wine /home/erik/Ahk2Exe/Ahk2Exe.exe /in kbdneo2.ahk /out kbdneo_ahk.exe /icon neo_enabled.ico

clean: 
	rm -rf kbdneo32 kbdneo64
	rm -f kbdneo32.zip kbdneo64.zip
	rm -f AHK_für_kbdneo2/kbdneo_ahk.exe

.PHONY: all clean
