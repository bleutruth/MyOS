OBJS_BOOTPACK = bootpack.obj myosfunc.obj hankaku.obj graphic.obj dsctbl.obj

TOOLPATH = ../../Local/tolset/z_tools/
INCPATH  = $(TOOLPATH)haribote/

MAKE     = $(TOOLPATH)make.exe -r
NASK     = $(TOOLPATH)nask.exe
CC1      = $(TOOLPATH)cc1.exe -I$(INCPATH) -Os -Wall -quiet
GAS2NASK = $(TOOLPATH)gas2nask.exe -a
OBJ2BIM  = $(TOOLPATH)obj2bim.exe
MAKEFONT = $(TOOLPATH)makefont.exe
BIN2OBJ  = $(TOOLPATH)bin2obj.exe
BIM2HRB  = $(TOOLPATH)bim2hrb.exe
RULEFILE = MyOS.rul
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

asmhead.bin : asmhead.nas Makefile
	$(NASK) asmhead.nas asmhead.bin asmhead.lst

hankaku.bin : hankaku.txt Makefile
	$(MAKEFONT) hankaku.txt hankaku.bin

hankaku.obj : hankaku.bin Makefile
	$(BIN2OBJ) hankaku.bin hankaku.obj _hankaku

bootpack.bim : $(OBJS_BOOTPACK) Makefile
	$(OBJ2BIM) @$(RULEFILE) out:bootpack.bim stack:3136k map:bootpack.map \
		$(OBJS_BOOTPACK)
# 3MB+64KB=3136KB

bootpack.hrb : bootpack.bim Makefile
	$(BIM2HRB) bootpack.bim bootpack.hrb 0

MyOS.sys : asmhead.bin bootpack.hrb Makefile
	cat asmhead.bin bootpack.hrb > MyOS.sys

MyOS.img : ipl.bin MyOS.sys Makefile
	$(EDIMG)   imgin:$(TOOLPATH)fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0 \
		copy from:MyOS.sys to:@: \
		imgout:MyOS.img

# 一般規則

%.gas : %.c Makefile
	$(CC1) -o $*.gas $*.c

%.nas : %.gas Makefile
	$(GAS2NASK) $*.gas $*.nas

%.obj : %.nas Makefile
	$(NASK) $*.nas $*.obj $*.lst

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
	$(DEL) *.bin
	$(DEL) *.lst
	$(DEL) *.obj
	$(DEL) bootpack.map
	$(DEL) bootpack.bim
	$(DEL) bootpack.hrb
	$(DEL) MyOS.sys

src_only :
	$(MAKE) clean
	$(DEL) MyOS.img
