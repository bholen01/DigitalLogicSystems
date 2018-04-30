----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2018 03:40:07 PM
-- Design Name: 
-- Module Name: fft_wrapper - Behavioral
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

entity fft_wrapper is
    Port ( 
    switches : IN STD_LOGIC_VECTOR(7 downto 0);
    fastclk  : IN STD_LOGIC;
    decode   : OUT STD_LOGIC_VECTOR(7 downto 0);
    anode    : OUT STD_LOGIC_VECTOR(7 downto 0)
           );
end fft_wrapper;

architecture Behavioral of fft_wrapper is
    signal s: complex_array;
    signal f_result: complex_array;
    signal template: float32 := x"3f800000";
    signal f_converted: std_logic_vector(31 downto 0);
    signal rom_out : STD_LOGIC_VECTOR(511 downto 0);
    signal hex     : STD_LOGIC_VECTOR (3 downto 0);
    signal slowclk : STD_LOGIC_VECTOR (2 downto 0);
    
    component fft_8point_3stage is
        Port (  X : in complex_array;      
                Y : out complex_array
        );
    end component;
    component dist_mem_gen_0 is
      Port (
        a : in STD_LOGIC_VECTOR ( 3 downto 0 );
        spo : out STD_LOGIC_VECTOR ( 511 downto 0 )
      );
    end component;
    

begin
    prom1: dist_mem_gen_0 port map(a(3 downto 0) => switches(7 downto 4), spo => rom_out);
    s(0).r <= to_float(rom_out(511 downto 480));
    s(0).i <= to_float(rom_out(479 downto 448));
    s(1).r <= to_float(rom_out(447 downto 416));
    s(1).i <= to_float(rom_out(415 downto 384));
    s(2).r <= to_float(rom_out(383 downto 352));
    s(2).i <= to_float(rom_out(351 downto 320));
    s(3).r <= to_float(rom_out(319 downto 288));
    s(3).i <= to_float(rom_out(287 downto 256));
    s(4).r <= to_float(rom_out(255 downto 224));
    s(4).i <= to_float(rom_out(223 downto 192));
    s(5).r <= to_float(rom_out(191 downto 160));
    s(5).i <= to_float(rom_out(159 downto 128));
    s(6).r <= to_float(rom_out(127 downto  96));
    s(6).i <= to_float(rom_out(95  downto  64));
    s(7).r <= to_float(rom_out(63  downto  32));
    s(7).i <= to_float(rom_out(31  downto   0));
    FFT: fft_8point_3stage port map(X => s, Y => f_result);

        with switches(3 downto 0) select
        f_converted <= 
        std_logic_vector(f_result(0).r) when "0000",
        std_logic_vector(f_result(0).i) when "0001",
        std_logic_vector(f_result(1).r) when "0010",
        std_logic_vector(f_result(1).i) when "0011",
        std_logic_vector(f_result(2).r) when "0100",
        std_logic_vector(f_result(2).i) when "0101",
        std_logic_vector(f_result(3).r) when "0110",
        std_logic_vector(f_result(3).i) when "0111",
        std_logic_vector(f_result(4).r) when "1000",
        std_logic_vector(f_result(4).i) when "1001",
        std_logic_vector(f_result(5).r) when "1010",
        std_logic_vector(f_result(5).i) when "1011",
        std_logic_vector(f_result(6).r) when "1100",
        std_logic_vector(f_result(6).i) when "1101",
        std_logic_vector(f_result(7).r) when "1110",
        std_logic_vector(f_result(7).i) when "1111",
        
        "00000000000000000000000000000000" when others;
    
    clock: process(fastclk, slowclk)
    variable counter : integer;
    begin
      if rising_edge(fastclk) then
        counter := counter + 1;
        if counter = 50000 then
            counter := 0;
            slowclk(2) <= (not(slowclk(2)) and slowclk(1) and slowclk(0)) or (slowclk(2) and (slowclk(1) nand slowclk(0)));
            slowclk(1) <= slowclk(1) xor slowclk(0);
            slowclk(0) <= not slowclk(0);
        end if;
      end if;    
    end process clock;
    
    with slowclk select
    hex <= 
    f_converted(3 downto 0) when "000",
    f_converted(7 downto 4) when "001",
    f_converted(11 downto 8) when "010",
    f_converted(15 downto 12) when "011",
    f_converted(19 downto 16) when "100",
    f_converted(23 downto 20) when "101",
    f_converted(27 downto 24) when "110",
    f_converted(31 downto 28) when "111",
    
    "0000" when others;
    with slowclk select
    anode <= "11111110" when "000",
    "11111101" when "001",
    "11111011" when "010",
    "11110111" when "011",
    "11101111" when "100",
    "11011111" when "101",
    "10111111" when "110",
    "01111111" when "111",
    "11111111" when others;
    
    with hex select
    decode <= "00000011" when "0000",
    "10011111" when "0001",
    "00100101" when "0010",
    "00001101" when "0011",
    "10011001" when "0100",
    "01001001" when "0101",
    "01000001" when "0110",
    "00011111" when "0111",
    "00000001" when "1000",
    "00011001" when "1001",
    "00010001" when "1010",
    "11000001" when "1011",
    "01100011" when "1100",
    "10000101" when "1101",
    "01100001" when "1110",
    "01110001" when "1111",
    "11111111" when others;
    
end Behavioral;




--s(0).r <= to_float(-2.0, template);
--    s(0).i <= to_float(1.2, template);
    
--    s(1).r <= to_float(-2.2, template);
--    s(1).i <= to_float(1.7, template);
    
--    s(2).r <= to_float(1.0, template);
--    s(2).i <= to_float(-2.0, template);
    
--    s(3).r <= to_float(-3.0, template);
--    s(3).i <= to_float(-3.2, template);
    
--    s(4).r <= to_float(4.5, template);
--    s(4).i <= to_float(-2.5, template);
    
--    s(5).r <= to_float(-1.6, template);
--    s(5).i <= to_float(0.2, template);
    
--    s(6).r <= to_float(0.5, template);
--    s(6).i <= to_float(1.5, template);
    
--    s(7).r <= to_float(-2.8, template);
--    s(7).i <= to_float(-4.2, template);
    