COMMON_FILES=reg_backup.bat reg_backup.bat kbdneo2_install.reg kbdneo2_uninstall.reg
BUILD_FILES=kbdneo32.zip kbdneo64.zip AHK_für_kbdneo2/kbdneo_ahk.exe

all: $(BUILD_FILES)

kbdneo64.zip: $(COMMON_FILES) 64bit_Windows/System32/kbdneo2.dll 64bit_Windows/SysWOW64/kbdneo2.dll
	mkdir -p kbdneo64
	cp -r $(COMMON_FILES) 64bit_Windows/System32/kbdneo2.dll 64bit_Windows/SysWOW64/kbdneo2.dll kbdneo64
	cd kbdneo64; zip -r kbdneo64 *
	mv kbdneo64/kbdneo64.zip .
	
kbdneo32.zip: $(COMMON_FILES) 32bit_Windows/kbdneo2.dll
	mkdir -p kbdneo32
	cp -r $(COMMON_FILES) 32bit_Windows/* kbdneo32
	cd kbdneo32; zip -r kbdneo32 *
	mv kbdneo32/kbdneo32.zip .

AHK_für_kbdneo2/kbdneo_ahk.exe: AHK_für_kbdneo2/neo_enabled.ico AHK_für_kbdneo2/kbdneo2.ahk 
	cd AHK_für_kbdneo2; wine "C:\\Programme\\Ahk2Exe\\Ahk2Exe.exe" /in kbdneo2.ahk /out kbdneo_ahk.exe /icon neo_enabled.ico

clean: 
	rm -rf kbdneo32 kbdneo64
	rm -f $(BUILD_FILES)

.PHONY: all clean

