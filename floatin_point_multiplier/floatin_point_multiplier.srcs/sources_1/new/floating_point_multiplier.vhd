----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2018 03:12:33 PM
-- Design Name: 
-- Module Name: floating_point_multiplier - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity floating_point_multiplier is
    Port ( X : in STD_LOGIC_VECTOR (31 downto 0);
           Y : in STD_LOGIC_VECTOR (31 downto 0);
           P : out STD_LOGIC_VECTOR (31 downto 0));
end floating_point_multiplier;

architecture Behavioral of floating_point_multiplier is
signal Sign_X: STD_LOGIC;
signal Sign_Y: STD_LOGIC;
signal Sign_P: STD_LOGIC;

signal Exponent_X: STD_LOGIC_VECTOR (7 downto 0);
signal Exponent_Y: STD_LOGIC_VECTOR (7 downto 0);
signal Exponent_P: STD_LOGIC_VECTOR (7 downto 0);

signal Mantissa_X: STD_LOGIC_VECTOR (23 downto 0);
signal Mantissa_Y: STD_LOGIC_VECTOR (23 downto 0);
signal Mantissa_P: STD_LOGIC_VECTOR (22 downto 0);

signal product: STD_LOGIC_VECTOR (47 downto 0);

component array_multiplier is
    Generic (N: integer:=4);
    Port (  X : in STD_LOGIC_VECTOR (N-1 downto 0);
            Y : in STD_LOGIC_VECTOR (N-1 downto 0);
            P : out STD_LOGIC_VECTOR (2*N-1 downto 0)
    );
end component;


begin
Sign_X <= X(31);
Sign_Y <= Y(31);
P(31) <= Sign_P;

Exponent_X <= X(30 downto 23);
Exponent_Y <= Y(30 downto 23);
--P(30 downto 23) <= Exponent_P;

Mantissa_X <= '1' & X(22 downto 0);
Mantissa_Y <= '1' & Y(22 downto 0);
--P(22 downto 0) <= normalized_product(46 downto 24);

AM4: array_multiplier generic map (24) port map (X => Mantissa_X, Y => Mantissa_Y, P => product);

process (Sign_X, Sign_Y, Exponent_X, Exponent_Y, Mantissa_X, Mantissa_Y, product) is
variable normalized_product: STD_LOGIC_VECTOR(47 downto 0);
variable normalized_exponent: STD_LOGIC_VECTOR(7 downto 0);
begin
    Sign_P <= Sign_X xor Sign_Y;
    --Exponent_P <= Exponent_X + Exponent_Y - 127;
    --product <= ('1' & Mantissa_X) * ('1' & Mantissa_Y);
    normalized_product := product;
    normalized_exponent := Exponent_X + Exponent_Y - 127;
    for i in 0 to 47 loop
    --while (normalized_product(47) = '0') loop
        if (normalized_product(47) = '0') then
            normalized_product := normalized_product(46 downto 0) & '0';
            normalized_exponent := normalized_exponent - 1;
        end if;
        if (normalized_product(47) = '1') then
            exit;
        end if;
    end loop;
    normalized_exponent := normalized_exponent + 1;
    P(22 downto 0) <= normalized_product(46 downto 24);
    P(30 downto 23) <= normalized_exponent;
--    if (product(23) = '0') then
--        Mantissa_P <= Mantissa_P + 1;
--    end if;
    
end process;

end Behavioral;
