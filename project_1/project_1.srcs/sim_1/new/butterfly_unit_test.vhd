----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2018 03:54:21 PM
-- Design Name: 
-- Module Name: butterfly_unit_test - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity butterfly_unit_test is
--  Port ( );
end butterfly_unit_test;


architecture Behavioral of butterfly_unit_test is

component butterfly_unit is
    Generic (k: integer:=0);
    Port (  A       : in complex;
            B       : in complex;
            A_prime : out complex;
            B_prime : out complex
    );
end component;
    
    signal A : complex;
    signal B : complex;
    signal A_prime : complex;
    signal B_prime : complex;
    
    signal A_prime2 : complex;
    signal B_prime2 : complex;
    signal s : float32;
    
begin
    BU1 : butterfly_unit generic map (1) port map (A => A, B => B, A_prime => A_prime, B_prime => B_prime);
    
    BU2 : butterfly_unit generic map (3) port map (A => A, B => B, A_prime => A_prime2, B_prime => B_prime2);
    
    s <= x"00000000";
    process begin
    A.r <= to_float(1.0, s);
    A.i <= to_float(1.0, s);
    B.r <= to_float(1.0, s);
    B.i <= to_float(1.0, s); 
    wait for 10 ps;
    A.r <= to_float(2.0, s);
    A.i <= to_float(1.0, s);
    B.r <= to_float(2.0, s);
    B.i <= to_float(1.0, s); 
    wait for 10 ps;
    end process;

end Behavioral;
