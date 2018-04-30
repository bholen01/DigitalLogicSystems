@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 732eb6a54a2c461fb9d272e75a6d62f7 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot fft_8point_3stage_test_behav xil_defaultlib.fft_8point_3stage_test -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
