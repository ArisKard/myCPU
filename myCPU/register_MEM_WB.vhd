-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_MEM_WB is

	generic (
		n: INTEGER := 16;
		addressSize: INTEGER := 3
	);
	
	port(
		Result: IN std_logic_vector(n-1 downto 0);
		RegAD: IN std_logic_vector(addressSize-1 downto 0);
		clock: IN std_logic;
		
		writeData: OUT std_logic_vector(n-1 downto 0);
		writeAD: OUT std_logic_vector(addressSize-1 downto 0)
	);
	
end register_MEM_WB;

architecture behavioral of register_MEM_WB is

begin

pc: process(clock)
	begin
		
		if clock = '1' then
			writeData <= Result;
			writeAD <= regAD;
		else 
			writeData <= (others => '0');
			writeAD <= (others => '0');
		end if;
end process pc;

end behavioral;	
		
	