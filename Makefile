
QEMU_PATH:=../Local/tolset/z_tools/qemu
QEMU:=$(QEMU_PATH)/qemu.exe

# デフォルト動作

default :
	../Local/tolset/z_tools/make.exe img

# ファイル生成規則

ipl.bin : ipl.nas Makefile
	../Local/tolset/z_tools/nask.exe ipl.nas ipl.bin ipl.lst

MyOS.img : ipl.bin Makefile
	../Local/tolset/z_tools/edimg.exe   imgin:../Local/tolset/z_tools/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0   imgout:MyOS.img

# コマンド

asm :
	../Local/tolset/z_tools/make.exe -r ipl.bin

img :
	../Local/tolset/z_tools/make.exe -r MyOS.img

run :
	../Local/tolset/z_tools/make.exe img
	$(QEMU) -L $(QEMU_PATH) -m 32 -localtime -std-vga -fda MyOS.img

install :
	../Local/tolset/z_tools/make.exe img
	../Local/tolset/z_tools/imgtol.com w a: MyOS.img

clean :
	rm -rf ipl.bin
	rm -rf ipl.lst

src_only :
	../Local/tolset/z_tools/make.exe clean
	rm -rf MyOS.img
