----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2018 04:12:56 PM
-- Design Name: 
-- Module Name: fft_8point_3stage_test - Behavioral
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

entity fft_8point_3stage_test is
--  Port ( );
end fft_8point_3stage_test;

architecture Behavioral of fft_8point_3stage_test is

component fft_wrapper is
    Port (
    switches : IN STD_LOGIC_VECTOR(7 downto 0);
    fastclk  : IN STD_LOGIC;
    decode   : OUT STD_LOGIC_VECTOR(7 downto 0);
    anode    : OUT STD_LOGIC_VECTOR(7 downto 0)
           );
end component;
    signal Sw : std_logic_vector (7 downto 0);  
begin
    FW : fft_wrapper port map (switches => Sw, fastclk => '0');
    
    process begin
        Sw <= "00000010";
        wait for 10 ps;
        Sw <= "00010010";
        wait for 10 ps;
        Sw <= "10000010";
        wait for 10 ps;
    end process;
end Behavioral;
