TOOLPATH = ../Local/tolset/z_tools/
MAKE     = $(TOOLPATH)make.exe -r
NASK     = $(TOOLPATH)nask.exe
EDIMG    = $(TOOLPATH)edimg.exe
IMGTOL   = $(TOOLPATH)imgtol.com
COPY     = cp -rfu
DEL      = rm -rf

QEMU_PATH:=$(TOOLPATH)qemu
QEMU:=$(QEMU_PATH)/qemu.exe

# デフォルト動作

default :
	$(MAKE) img

# ファイル生成規則

ipl.bin : ipl.nas Makefile
	$(NASK) ipl.nas ipl.bin ipl.lst

MyOS.sys : asmhead.nas Makefile
	$(NASK) asmhead.nas MyOS.sys asmhead.lst

MyOS.img : ipl.bin MyOS.sys Makefile
	$(EDIMG)   imgin:$(TOOLPATH)fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0 \
		copy from:MyOS.sys to:@: \
		imgout:MyOS.img

# コマンド

img :
	$(MAKE) MyOS.img

run :
	$(MAKE) img
	$(QEMU) -L $(QEMU_PATH) -m 32 -localtime -std-vga -fda MyOS.img

install :
	$(MAKE) img
	$(IMGTOL) w a: MyOS.img

clean :
	$(DEL) ipl.bin
	$(DEL) ipl.lst
	$(DEL) MyOS.sys
	$(DEL) asmhead.lst

src_only :
	$(MAKE) clean
	$(DEL) MyOS.img
