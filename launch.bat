setlocal
set TOLSET_PATH=..\Local\tolset
set NASK=%TOLSET_PATH%\z_tools\nask.exe
set QEMU_PATH=%TOLSET_PATH%\z_tools\qemu
set QEMU=%QEMU_PATH%\qemu.exe
set FILE_IMG=MyOS.img
%NASK% MyOS.nas %FILE_IMG%
%QEMU% -L %QEMU_PATH% -m 32 -localtime -std-vga -fda %FILE_IMG%
endlocal
