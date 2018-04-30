----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2018 03:01:25 PM
-- Design Name: 
-- Module Name: fft_8point - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.complex.all;
library ieee_proposed;
use ieee_proposed.float_pkg.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fft_8point is
    Port (  x0       : in complex;
            x1       : in complex;
            x2       : in complex;
            x3       : in complex;
            x4       : in complex;
            x5       : in complex;
            x6       : in complex;
            x7       : in complex;
            
            y0       : out complex;
            y1       : out complex;
            y2       : out complex;
            y3       : out complex;
            y4       : out complex;
            y5       : out complex;
            y6       : out complex;
            y7       : out complex
    );
end fft_8point;

architecture Behavioral of fft_8point is

begin


end Behavioral;
