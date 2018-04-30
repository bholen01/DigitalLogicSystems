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
    anode    : OUT STD_LOGIC_VECTOR(7 downto 0);
    clk      : IN STD_LOGIC
           );
end component;  
    signal clk : std_logic := '1';
    signal switches : std_logic_vector(7 downto 0) := "00000000";
    signal new_input : std_logic  := '0';
begin
    FW : fft_wrapper port map (switches => switches, fastclk => '0', clk => clk);
    
    process begin
        clk <= not(clk);
        wait for 10 ps;
        clk <= not(clk);
        wait for 10 ps;
        clk <= not(clk);
        wait for 10 ps;
        clk <= not(clk);
        wait for 10 ps;
        clk <= not(clk);
        wait for 10 ps;
        clk <= not(clk);
        wait for 10 ps;
        switches <= "11111111";
        new_input <= not(new_input);
        clk <= not(clk);
        wait for 10 ps;
        clk <= not(clk);
        wait for 10 ps;
        clk <= not(clk);
        wait for 10 ps;
        clk <= not(clk);
        wait for 10 ps;
                
    end process;
end Behavioral;
