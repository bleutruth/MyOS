setlocal
set QEMU_PATH=..\Local\tolset\z_tools\qemu
%QEMU_PATH%\qemu.exe -L %QEMU_PATH% -m 32 -localtime -std-vga -fda MyOS.img
endlocal
