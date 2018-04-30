----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2018 03:35:18 PM
-- Design Name: 
-- Module Name: butterfly_unit - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity butterfly_unit is
    Generic (k: integer:=0);
    Port (  A       : in complex;
            B       : in complex;
            A_prime : out complex;
            B_prime : out complex
    );
end butterfly_unit;

architecture Behavioral of butterfly_unit is

signal W : complex;
signal s : float32;

begin

s <= x"00000000";
with k select
W.r <= 
to_float(1.0, s) when 0,
to_float(0.707107, s) when 1,
to_float(0, s) when 2,
to_float(-0.707107, s) when 3,
to_float(0, s) when others;

with k select
W.i <=
to_float(0, s) when 0,
to_float(-0.707107, s) when 1,
to_float(-1.0, s) when 2,
to_float(-0.707107, s) when 3,
to_float(0, s) when others;

A_prime.r <= (A.r + (B.r*W.r) - (B.i*W.i) );
A_prime.i <= (A.i + (B.r*W.i) + (B.i*W.r) );

B_prime.r <= (A.r -( (B.r*W.r) - (B.i*W.i) ));
B_prime.i <= (A.i -( (B.r*W.i) + (B.i*W.r) ));

end Behavioral;
