----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2018 05:46:16 PM
-- Design Name: 
-- Module Name: summation_unit - Behavioral
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

entity summation_unit is
    Port ( Sum_in : in STD_LOGIC;
           X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Sum_out : out STD_LOGIC;
           Cout : out STD_LOGIC);
end summation_unit;

architecture Behavioral of summation_unit is
component full_adder is
    Port (   x : in STD_LOGIC;
             y : in STD_LOGIC;
           cin : in STD_LOGIC;
             s : out STD_LOGIC;
          cout : out STD_LOGIC);
end component;

    signal XandY: STD_LOGIC;
begin
    XandY <= X and Y;
    adder: full_adder port map (cin => Cin, x => Sum_in, y => XandY, s => Sum_out, cout => Cout);
end Behavioral;
