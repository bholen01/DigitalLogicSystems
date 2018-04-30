----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2018 04:35:00 PM
-- Design Name: 
-- Module Name: array_multiplier_test - Behavioral
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

entity array_multiplier_test is
--  Port ( );
end array_multiplier_test;

architecture Behavioral of array_multiplier_test is

component array_multiplier is
            Generic (N: integer:=4);
            Port (
            X : in STD_LOGIC_VECTOR (N-1 downto 0);
            Y : in STD_LOGIC_VECTOR (N-1 downto 0);
            P : out STD_LOGIC_VECTOR (2*N-1 downto 0)
    );

    
    
end component;
    signal X : STD_LOGIC_VECTOR(3 downto 0);
    signal Y : STD_LOGIC_VECTOR(3 downto 0);
    signal P : STD_LOGIC_VECTOR(7 downto 0);
    signal Real_Product : STD_LOGIC_VECTOR(7 downto 0);
    signal Diff : STD_LOGIC_VECTOR(7 downto 0);

begin
    AM4: array_multiplier generic map (4) port map (X => X, Y => Y, P => P);
    Real_Product <= X * Y;
    Diff <= Real_Product xor P;
    process begin
    X <= "0000";
    Y <= "0000";
    wait for 1 ns;
    for i in 0 to 14 loop
        X <= "0000";
        for j in 0 to 14 loop
        X <= X + "0001";
        wait for 1 ns;
        end loop;
        Y <= Y + "0001";
        wait for 1 ns;
    end loop;
    
    --    wait for 10ns;
    --    for I in 0 to 65535 loop
    --        for J in 0 to 65535 loop
    --           wait for 10ns;
    --           x <= x + "0000000000000001";
    --        end loop;
    --      y <= y + "0000000000000001";
    --    end loop;
--        X <= "0000";
--        Y <= "0000";
--        wait for 10 ns;
--        X <= "0000";
--        Y <= "0001";
--        wait for 10 ns;
--        X <= "0001";
--        Y <= "0000";
--        wait for 10 ns;
--        X <= "0001";
--        Y <= "0001";
--        wait for 10 ns;
--        X <= "0011";
--        Y <= "0001";
--        wait for 10 ns;
--        X <= "0011";
--        Y <= "0010";
--        wait for 10 ns;
--        X <= "1111";
--        Y <= "0011";
--        wait for 10 ns;
--        X <= "1111";
--        Y <= "1111";
--        wait for 10 ns;
--        X <= "0011";
--        Y <= "0011";
--        wait for 10 ns;
--        X <= "0011";
--        Y <= "0100";
--        wait for 10 ns;
--        X <= "0100";
--        Y <= "0100";
--        wait for 10 ns;      
--        X <= "1000";
--        Y <= "0100";
--        wait for 10 ns;
--        X <= "1000";
--        Y <= "1000";
--        wait for 10 ns;    
--        X <= "1000";
--        Y <= "1111";
--        wait for 10 ns;  
--        X <= "1111";
--        Y <= "1000";
--        wait for 10 ns; 
    end process;
end Behavioral;
