----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2018 03:31:19 PM
-- Design Name: 
-- Module Name: complex - Behavioral
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

library ieee_proposed;
use ieee_proposed.float_pkg.all;


package complex is
    type complex is
        record
        r : float32;
        i : float32;
    end record;
    type complex_array is array (7 downto 0) of complex;
end package complex;
