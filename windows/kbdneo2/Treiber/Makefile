COMMON_FILES=reg_backup.bat reg_backup.bat kbdneo2_install.reg kbdneo2_uninstall.reg
BUILD_FILES=kbdneo32.zip kbdneo64.zip AHK_für_kbdneo2/kbdneo_ahk.exe

all: $(BUILD_FILES)

kbdneo%.zip: $(COMMON_FILES) %bit_Windows/kbdneo2.dll
	mkdir -p kbdneo$*
	cp $(COMMON_FILES) $*bit_Windows/kbdneo2.dll kbdneo$*
	cd kbdneo$*; zip -r kbdneo$* *
	mv kbdneo$*/kbdneo$*.zip .

AHK_für_kbdneo2/kbdneo_ahk.exe: AHK_für_kbdneo2/neo_enabled.ico AHK_für_kbdneo2/kbdneo2.ahk 
	cd AHK_für_kbdneo2; wine "C:\\Programme\\Ahk2Exe\\Ahk2Exe.exe" /in kbdneo2.ahk /out kbdneo_ahk.exe /icon neo_enabled.ico

clean: 
	rm -rf kbdneo32 kbdneo64
	rm -f $(BUILD_FILES)

.PHONY: all clean

