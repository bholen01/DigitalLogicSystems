----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2018 03:02:13 PM
-- Design Name: 
-- Module Name: fft_8point_3stage - Behavioral
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

entity fft_8point_3stage is
    Port (  X : in complex_array;
            
            Y : out complex_array
    );
end fft_8point_3stage;

architecture Behavioral of fft_8point_3stage is
    component butterfly_unit is
    Generic (k: integer:=0);
    Port (  A       : in complex;
            B       : in complex;
            A_prime : out complex;
            B_prime : out complex
    );
    end component;

    signal stage1_0 : complex;
    signal stage1_1 : complex;
    signal stage1_2 : complex;
    signal stage1_3 : complex;
    signal stage1_4 : complex;
    signal stage1_5 : complex;
    signal stage1_6 : complex;
    signal stage1_7 : complex;
    
    signal stage2_0 : complex;
    signal stage2_1 : complex;
    signal stage2_2 : complex;
    signal stage2_3 : complex;
    signal stage2_4 : complex;
    signal stage2_5 : complex;
    signal stage2_6 : complex;
    signal stage2_7 : complex;
begin

    BU_stage1_0 : butterfly_unit generic map (0) port map (A => X(0), B => X(4), A_prime => stage1_0, B_prime => stage1_4);
    BU_stage1_1 : butterfly_unit generic map (0) port map (A => X(2), B => X(6), A_prime => stage1_2, B_prime => stage1_6);
    BU_stage1_2 : butterfly_unit generic map (0) port map (A => X(1), B => X(5), A_prime => stage1_1, B_prime => stage1_5);
    BU_stage1_3 : butterfly_unit generic map (0) port map (A => X(3), B => X(7), A_prime => stage1_3, B_prime => stage1_7);
    
    BU_stage2_0 : butterfly_unit generic map (0) port map (A => stage1_0, B => stage1_2, A_prime => stage2_0, B_prime => stage2_2);
    BU_stage2_1 : butterfly_unit generic map (2) port map (A => stage1_4, B => stage1_6, A_prime => stage2_4, B_prime => stage2_6);
    BU_stage2_2 : butterfly_unit generic map (0) port map (A => stage1_1, B => stage1_3, A_prime => stage2_1, B_prime => stage2_3);
    BU_stage2_3 : butterfly_unit generic map (2) port map (A => stage1_5, B => stage1_7, A_prime => stage2_5, B_prime => stage2_7);
    
    BU_stage3_0 : butterfly_unit generic map (0) port map (A => stage2_0, B => stage2_1, A_prime => Y(0), B_prime => Y(4));
    BU_stage3_1 : butterfly_unit generic map (1) port map (A => stage2_4, B => stage2_5, A_prime => Y(1), B_prime => Y(5));
    BU_stage3_2 : butterfly_unit generic map (2) port map (A => stage2_2, B => stage2_3, A_prime => Y(2), B_prime => Y(6));
    BU_stage3_3 : butterfly_unit generic map (3) port map (A => stage2_6, B => stage2_7, A_prime => Y(3), B_prime => Y(7));
    
    
end Behavioral;
