#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/usr/cots/xilinx/SDK/2015.4/bin:/usr/cots/xilinx/Vivado/2015.4/ids_lite/ISE/bin/lin64:/usr/cots/xilinx/Vivado/2015.4/bin
else
  PATH=/usr/cots/xilinx/SDK/2015.4/bin:/usr/cots/xilinx/Vivado/2015.4/ids_lite/ISE/bin/lin64:/usr/cots/xilinx/Vivado/2015.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/usr/cots/xilinx/Vivado/2015.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/usr/cots/xilinx/Vivado/2015.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/h/bholen01/EE26/project_1/project_1.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log fft_wrapper.vds -m64 -mode batch -messageDb vivado.pb -notrace -source fft_wrapper.tcl
