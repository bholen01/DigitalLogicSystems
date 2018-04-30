----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2018 05:16:25 PM
-- Design Name: 
-- Module Name: hardware_interface - Behavioral
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

entity hardware_interface is
  Port (
    switches: IN STD_LOGIC_VECTOR (7 downto 0);
    fastclk : IN STD_LOGIC;
    decode  : OUT STD_LOGIC_VECTOR (7 downto 0);
    anode   : OUT STD_LOGIC_VECTOR (7 downto 0)
);
end hardware_interface;

architecture Behavioral of hardware_interface is

component dist_mem_gen_0 is
  Port (
    a : in STD_LOGIC_VECTOR ( 3 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end component;
component floating_point_multiplier is
            Port (
            X : in STD_LOGIC_VECTOR (31 downto 0);
            Y : in STD_LOGIC_VECTOR (31 downto 0);
            P : out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

signal    X : STD_LOGIC_VECTOR (31 downto 0);
signal    Y : STD_LOGIC_VECTOR (31 downto 0);
signal    P : STD_LOGIC_VECTOR (31 downto 0);
signal hex     : STD_LOGIC_VECTOR (3 downto 0);
signal slowclk : STD_LOGIC_VECTOR (2 downto 0);

begin
    fpm: floating_point_multiplier port map(X => X, Y => Y, P => P);
prom1: dist_mem_gen_0 port map(a(3 downto 0) => switches(7 downto 4), spo => X);
prom2: dist_mem_gen_0 port map(a(3 downto 0) => switches(3 downto 0), spo => Y);

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
hex <= P(3 downto 0) when "000",
P(7 downto 4) when "001",
P(11 downto 8) when "010",
P(15 downto 12) when "011",

P(19 downto 16) when "100",
P(23 downto 20) when "101",
P(27 downto 24) when "110",
P(31 downto 28) when "111",

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
