----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2018 03:56:39 PM
-- Design Name: 
-- Module Name: floating_test - Behavioral
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

entity floating_test is
--  Port ( );
end floating_test;

architecture Behavioral of floating_test is
component floating_point_multiplier is
            Port (
            X : in STD_LOGIC_VECTOR (31 downto 0);
            Y : in STD_LOGIC_VECTOR (31 downto 0);
            P : out STD_LOGIC_VECTOR (31 downto 0)
    );
    
end component;
    signal X : STD_LOGIC_VECTOR(31 downto 0);
    signal Y : STD_LOGIC_VECTOR(31 downto 0);
    signal P : STD_LOGIC_VECTOR(31 downto 0);
    
begin
fpm: floating_point_multiplier port map (X => X, Y => Y, P => P);

process begin
    X <= "01000000000000000000000000000000"; -- 2
    Y <= "01000000011000000000000000000000"; -- 3.5
    wait for 10 ps;
    X <= "01000000111000000000000000000000"; -- 7
    Y <= "01000000101000000000000000000000"; -- 5
    wait for 10 ps;
    X <= "00111111100000000000000000000000"; -- 1
    Y <= "01000000000000000000000000000000"; -- 2
    wait for 10 ps;
    X <= "00111111000000000000000000000000"; -- 0.5
    Y <= "00111111000000000000000000000000"; -- 0.5
    wait for 10 ps;
    X <= "11000000011100000000000000000000"; -- -3.75
    Y <= "01000000100000000000000000000000"; -- 4
    wait for 10 ps;
    
end process;

end Behavioral;
