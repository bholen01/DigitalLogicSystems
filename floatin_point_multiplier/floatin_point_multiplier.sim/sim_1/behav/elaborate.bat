@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 74decd8987844eb8ae1e39eac47d7f05 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot floating_test_behav xil_defaultlib.floating_test -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
