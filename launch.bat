setlocal
set TOLSET_PATH=..\Local\tolset
set NASK=%TOLSET_PATH%\z_tools\nask.exe
set EDIMG=%TOLSET_PATH%\z_tools\edimg.exe
set FILE_IPLBIN=ipl.bin

set QEMU_PATH=%TOLSET_PATH%\z_tools\qemu
set QEMU=%QEMU_PATH%\qemu.exe
set FILE_IMG=MyOS.img

%NASK% ipl.nas %FILE_IPLBIN% ipl.lst
%EDIMG% imgin:%TOLSET_PATH%/z_tools/fdimg0at.tek wbinimg src:%FILE_IPLBIN% len:512 from:0 to:0 imgout:%FILE_IMG%
%QEMU% -L %QEMU_PATH% -m 32 -localtime -std-vga -fda %FILE_IMG%
endlocal
