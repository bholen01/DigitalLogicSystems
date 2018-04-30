----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2018 06:16:12 PM
-- Design Name: 
-- Module Name: interface_test - Behavioral
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

entity interface_test is
--  Port ( );
end interface_test;

architecture Behavioral of interface_test is
component hardware_interface is
  Port (
  switches: IN STD_LOGIC_VECTOR (7 downto 0);
  fastclk : IN STD_LOGIC;
  decode  : OUT STD_LOGIC_VECTOR (7 downto 0);
  anode   : OUT STD_LOGIC_VECTOR (7 downto 0)
);
end component;

signal switches: STD_LOGIC_VECTOR (7 downto 0);
signal fastclk : STD_LOGIC;
signal decode  : STD_LOGIC_VECTOR (7 downto 0);
signal anode   : STD_LOGIC_VECTOR (7 downto 0);
   
begin
hi: hardware_interface port map( switches => switches, fastclk => fastclk, decode => decode, anode => anode);

process begin
    fastclk <= '0';
    switches <= "00000000";
    wait for 10 ps;
    switches <= "00000001";
    wait for 10 ps;
    switches <= "00010000";
    wait for 10 ps;
    switches <= "00010001";
    wait for 10 ps;
end process;

end Behavioral;


