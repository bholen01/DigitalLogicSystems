----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2018 03:25:47 PM
-- Design Name: 
-- Module Name: full_adder - full_adder_arch
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity half_adder is
    Port (   x : in STD_LOGIC;
             y : in STD_LOGIC;
             s : out STD_LOGIC;
          cout : out STD_LOGIC);
end half_adder;

architecture half_adder_arch of half_adder is
begin
       s <= x xor y;
    cout <= x and y;
end half_adder_arch;