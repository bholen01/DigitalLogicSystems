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
            Y : out complex_array;
            clk : in std_logic
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
    component D_Latch_8by8_complex is
        Port (  D       : in complex_array;
                Q       : out complex_array;
                clk     : in std_logic
        );
    end component;
    signal stage_0_latch : complex_array;
    signal stage_1_latch : complex_array;
    signal stage_2_latch : complex_array;
    
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
    DLatch_stage_0 : D_Latch_8by8_complex port map(D => X, clk => clk, Q => stage_0_latch);

    BU_stage1_0 : butterfly_unit generic map (0) port map (A => stage_0_latch(0), B => stage_0_latch(4), A_prime => stage_1_latch(0), B_prime => stage_1_latch(1));
    BU_stage1_1 : butterfly_unit generic map (0) port map (A => stage_0_latch(2), B => stage_0_latch(6), A_prime => stage_1_latch(2), B_prime => stage_1_latch(3));
    BU_stage1_2 : butterfly_unit generic map (0) port map (A => stage_0_latch(1), B => stage_0_latch(5), A_prime => stage_1_latch(4), B_prime => stage_1_latch(5));
    BU_stage1_3 : butterfly_unit generic map (0) port map (A => stage_0_latch(3), B => stage_0_latch(7), A_prime => stage_1_latch(6), B_prime => stage_1_latch(7));
        
    DLatch_stage_1 : D_Latch_8by8_complex port map(
        D => stage_1_latch,
        Q(0) => stage1_0, Q(1) => stage1_4, Q(2) => stage1_2, Q(3) => stage1_6, Q(4) => stage1_1, Q(5) => stage1_5, Q(6) => stage1_3, Q(7) => stage1_7,
        clk => clk
        );
        
    BU_stage2_0 : butterfly_unit generic map (0) port map (A => stage1_0, B => stage1_2, A_prime => stage_2_latch(0), B_prime => stage_2_latch(1));
    BU_stage2_1 : butterfly_unit generic map (2) port map (A => stage1_4, B => stage1_6, A_prime => stage_2_latch(2), B_prime => stage_2_latch(3));
    BU_stage2_2 : butterfly_unit generic map (0) port map (A => stage1_1, B => stage1_3, A_prime => stage_2_latch(4), B_prime => stage_2_latch(5));
    BU_stage2_3 : butterfly_unit generic map (2) port map (A => stage1_5, B => stage1_7, A_prime => stage_2_latch(6), B_prime => stage_2_latch(7));
    
    DLatch_stage_2 : D_Latch_8by8_complex port map(
        D => stage_2_latch,
        Q(0) => stage2_0, Q(1) => stage2_2, Q(2) => stage2_4, Q(3) => stage2_6, Q(4) => stage2_1, Q(5) => stage2_3, Q(6) => stage2_5, Q(7) => stage2_7,
        clk => clk
        );
        
    BU_stage3_0 : butterfly_unit generic map (0) port map (A => stage2_0, B => stage2_1, A_prime => Y(0), B_prime => Y(4));
    BU_stage3_1 : butterfly_unit generic map (1) port map (A => stage2_4, B => stage2_5, A_prime => Y(1), B_prime => Y(5));
    BU_stage3_2 : butterfly_unit generic map (2) port map (A => stage2_2, B => stage2_3, A_prime => Y(2), B_prime => Y(6));
    BU_stage3_3 : butterfly_unit generic map (3) port map (A => stage2_6, B => stage2_7, A_prime => Y(3), B_prime => Y(7));
    
    
end Behavioral;
