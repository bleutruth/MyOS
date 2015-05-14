# ÉâÉCÉuÉâÉäê∂ê¨ópMakefile

TARGET   = myoslib.lib
OBJS     = startup.obj

TOOLPATH = ../../../Local/tolset/z_tools/
INCPATH  = $(TOOLPATH)haribote/

SJISCONV = $(TOOLPATH)sjisconv.exe -s
CC1      = $(TOOLPATH)cc1.exe -I$(INCPATH) -Os -Wall -quiet
GAS2NASK = $(TOOLPATH)gas2nask.exe -a
NASK     = $(TOOLPATH)nask.exe
GOLIB    = $(TOOLPATH)golib00.exe
MAKE     = $(TOOLPATH)make.exe -r
DELE     = rm -rf

ALL :
	$(MAKE) $(TARGET)

%.ca : %.c Makefile
	$(SJISCONV) $*.c $*.ca

%.gas : %.ca Makefile
	$(CC1) -o $*.gas $*.ca

%.nas : %.gas Makefile
	$(GAS2NASK) $*.gas $*.nas

%.obj : %.nas Makefile
	$(NASK) $*.nas $*.obj

$(TARGET) : $(OBJS) Makefile
	$(GOLIB) out:$(TARGET) $(OBJS)

clean :
	$(DELE) *.obj

src_only :
	$(MAKE) clean
	$(DELE) $(TARGET)
