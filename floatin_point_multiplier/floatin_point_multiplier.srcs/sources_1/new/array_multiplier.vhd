------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 02/20/2018 03:19:33 PM
---- Design Name: 
---- Module Name: array_multiplier - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--entity array_multiplier is
--    Generic (N: integer:=4);
--    Port (  X : in STD_LOGIC_VECTOR (N-1 downto 0);
--            Y : in STD_LOGIC_VECTOR (N-1 downto 0);
--            P : out STD_LOGIC_VECTOR (2*N-1 downto 0)
--    );
--end array_multiplier;

--architecture Behavioral of array_multiplier is

--component summation_unit is
--    Port ( Sum_in : in STD_LOGIC;
--           X : in STD_LOGIC;
--           Y : in STD_LOGIC;
--           Cin : in STD_LOGIC;
--           Sum_out : out STD_LOGIC;
--           Cout : out STD_LOGIC);
--end component;

--type partial_carry is array (N-1 downto 0) of STD_LOGIC_VECTOR(N-1 downto 0);
--signal carry: partial_carry;

--type partial_sum is array (N-1 downto 0) of STD_LOGIC_VECTOR(N-1 downto 0);
--signal sum: partial_sum;


--begin
--    top_right: summation_unit port map 
--        (Sum_in => '0', X => X(0), Y => Y(0), Cin => '0', Sum_out => P(0), Cout => carry(0)(0));
--    top_left: summation_unit port map 
--        (Sum_in => '0', X => X(N-1), Y => Y(0), Cin => '0', Sum_out => sum(N-1)(0), Cout => carry(N-1)(0));
        
--    bottom_right: summation_unit port map 
--        (Sum_in => sum(1)(N-2), X => X(0), Y => Y(N-1), Cin => carry(0)(N-2), Sum_out => P(N-1));
--    bottom_left: summation_unit port map 
--        (Sum_in => '0', X => X(N-1), Y => Y(N-1), Cin => carry(N-1)(N-2), Sum_out => P((2*N)-2), Cout => P((2*N)-1));
        
--    top_row: for i in 1 to N-2 generate
--        top_row_adders: summation_unit port map
--            (Sum_in => '0', X => X(i), Y => Y(0), Cin => '0', Sum_out => sum(i)(0), Cout => carry(i)(0));
--    end generate; 
--    bottom_row: for i in 1 to N-2 generate
--        bottom_row_adders: summation_unit port map
--            (Sum_in => sum(i+1)(N-2), X => X(i), Y => Y(N-1), Cin => carry(i)(N-2), Sum_out => P(N+i-1));
--    end generate;
--    right_col: for i in 1 to N-2 generate
--        right_col_adders: summation_unit port map
--            (Sum_in => sum(1)(i-1), X => X(0), Y => Y(i), Cin => carry(0)(i-1), Sum_out => P(i), Cout => carry(0)(i));
--    end generate;
--    left_col: for i in 1 to N-2 generate
--        left_col_adders: summation_unit port map
--            (Sum_in => '0', X => X(N-1), Y => Y(i), Cin => carry(N-1)(i-1), Sum_out => sum(N-1)(i), Cout => carry(N-1)(i));
--    end generate;

--    center_block_i: for i in 1 to N-2 generate -- X
--        center_block_j: for j in 1 to N-2 generate -- Y
--            center_block_adders: summation_unit port map
--                (Sum_in => sum(i+1)(j-1), X => X(i), Y => Y(j), Cin => carry(i)(j-1), Sum_out => sum(i)(j), Cout => carry(i)(j));
--        end generate;
--    end generate; 

--    --P <= X * Y;
--end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2018 03:19:33 PM
-- Design Name: 
-- Module Name: array_multiplier - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity array_multiplier is
    Generic (N: integer:=4);
    Port (  X : in STD_LOGIC_VECTOR (N-1 downto 0);
            Y : in STD_LOGIC_VECTOR (N-1 downto 0);
            P : out STD_LOGIC_VECTOR (2*N-1 downto 0)
    );
end array_multiplier;

architecture Behavioral of array_multiplier is

component summation_unit is
    Port ( Sum_in : in STD_LOGIC;
           X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Sum_out : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;

type partial_carry is array (N-1 downto 0) of STD_LOGIC_VECTOR(N-1 downto 0);
signal carry: partial_carry;

type partial_sum is array (N-1 downto 0) of STD_LOGIC_VECTOR(N-1 downto 0);
signal sum: partial_sum;


begin

    top_right: summation_unit port map 
        (Sum_in => '0', X => X(0), Y => Y(0), Cin => '0', Sum_out => P(0), Cout => carry(0)(0));
    top_left: summation_unit port map 
        (Sum_in => '0', X => X(N-1), Y => Y(0), Cin => '0', Sum_out => sum(N-1)(0), Cout => carry(N-1)(0));
        
    bottom_right: summation_unit port map 
        (Sum_in => sum(1)(N-2), X => X(0), Y => Y(N-1), Cin => '0', Sum_out => P(N-1), Cout => carry(0)(N-1));
    bottom_left: summation_unit port map 
        (Sum_in => carry(N-1)(N-2), X => X(N-1), Y => Y(N-1), Cin => carry(N-2)(N-1), Sum_out => P((2*N)-2), Cout => P((2*N)-1));
        
    top_row: for i in 1 to N-2 generate
        top_row_adders: summation_unit port map
            (Sum_in => '0', X => X(i), Y => Y(0), Cin => '0', Sum_out => sum(i)(0), Cout => carry(i)(0));
    end generate; 
    bottom_row: for i in 1 to N-2 generate
        bottom_row_adders: summation_unit port map
            (Sum_in => sum(i+1)(N-2), X => X(i), Y => Y(N-1), Cin => carry(i-1)(N-1), Sum_out => P(N+i-1), Cout => carry(i)(N-1));
    end generate;
    right_col: for i in 1 to N-2 generate
        right_col_adders: summation_unit port map
            (Sum_in => sum(1)(i-1), X => X(0), Y => Y(i), Cin => '0', Sum_out => P(i), Cout => carry(0)(i));
    end generate;
    left_col: for i in 1 to N-2 generate
        left_col_adders: summation_unit port map
            (Sum_in => carry(N-1)(i-1), X => X(N-1), Y => Y(i), Cin => carry(N-2)(i), Sum_out => sum(N-1)(i), Cout => carry(N-1)(i));
    end generate;

    center_block_i: for i in 1 to N-2 generate -- X
        center_block_j: for j in 1 to N-2 generate -- Y
            center_block_adders: summation_unit port map
                (Sum_in => sum(i+1)(j-1), X => X(i), Y => Y(j), Cin => carry(i-1)(j), Sum_out => sum(i)(j), Cout => carry(i)(j));
        end generate;
    end generate; 
--    top_right: summation_unit port map 
--        (Sum_in => '0', X => X(0), Y => Y(0), Cin => '0', Sum_out => P(0), Cout => carry(0)(0));
--    top_left: summation_unit port map 
--        (Sum_in => '0', X => X(N-1), Y => Y(0), Cin => '0', Sum_out => sum(N-1)(0), Cout => carry(N-1)(0));
        
--    bottom_right: summation_unit port map 
--        (Sum_in => sum(1)(N-2), X => X(0), Y => Y(N-1), Cin => carry(0)(N-2), Sum_out => P(N-1));
--    bottom_left: summation_unit port map 
--        (Sum_in => '0', X => X(N-1), Y => Y(N-1), Cin => carry(N-1)(N-2), Sum_out => P((2*N)-2), Cout => P((2*N)-1));
        
--    top_row: for i in 1 to N-2 generate
--        top_row_adders: summation_unit port map
--            (Sum_in => '0', X => X(i), Y => Y(0), Cin => '0', Sum_out => sum(i)(0), Cout => carry(i)(0));
--    end generate; 
--    bottom_row: for i in 1 to N-2 generate
--        bottom_row_adders: summation_unit port map
--            (Sum_in => sum(i+1)(N-2), X => X(i), Y => Y(N-1), Cin => carry(i)(N-2), Sum_out => P(N+i-1));
--    end generate;
--    right_col: for i in 1 to N-2 generate
--        right_col_adders: summation_unit port map
--            (Sum_in => sum(1)(i-1), X => X(0), Y => Y(i), Cin => carry(0)(i-1), Sum_out => P(i), Cout => carry(0)(i));
--    end generate;
--    left_col: for i in 1 to N-2 generate
--        left_col_adders: summation_unit port map
--            (Sum_in => '0', X => X(N-1), Y => Y(i), Cin => carry(N-1)(i-1), Sum_out => sum(N-1)(i), Cout => carry(N-1)(i));
--    end generate;

--    center_block_i: for i in 1 to N-2 generate -- X
--        center_block_j: for j in 1 to N-2 generate -- Y
--            center_block_adders: summation_unit port map
--                (Sum_in => sum(i+1)(j-1), X => X(i), Y => Y(j), Cin => carry(i)(j-1), Sum_out => sum(i)(j), Cout => carry(i)(j));
--        end generate;
--    end generate; 

    --P <= X * Y;
end Behavioral;
