all: kbdneo32 kbdneo64

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

clean: 
	rm -rf kbdneo32 kbdneo64
	rm -f kbdneo32.zip kbdneo64.zip

.PHONY: all clean
