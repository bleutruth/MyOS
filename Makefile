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

MyOS.img : ipl.bin Makefile
	$(EDIMG)   imgin:../Local/tolset/z_tools/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0   imgout:MyOS.img

# コマンド

asm :
	$(MAKE) ipl.bin

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

src_only :
	$(MAKE) clean
	$(DEL) MyOS.img
