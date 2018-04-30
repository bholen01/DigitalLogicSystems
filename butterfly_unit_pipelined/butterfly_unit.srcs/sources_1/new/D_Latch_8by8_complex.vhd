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

entity D_Latch_8by8_complex is
    Port (  D       : in complex_array;
            Q       : out complex_array;
            clk     : in std_logic
    );
end D_Latch_8by8_complex;
    
architecture Behavioral of D_Latch_8by8_complex is

begin
    process (D, clk)
    begin
        if (rising_edge(clk)) then
            Q <= D;
        end if;
    end process;

end Behavioral;
