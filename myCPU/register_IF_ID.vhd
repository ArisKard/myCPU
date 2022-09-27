-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_IF_ID is

	generic (
		n: INTEGER := 16
	);
	
	port(
		inPC, inInstruction: IN std_logic_vector(n-1 downto 0);
		clock, IF_Flush, IF_ID_Enable: IN std_logic;
		
		outPC, outInstruction: OUT std_logic_vector(n-1 downto 0)
	);
	
end register_IF_ID;

architecture behavioral of register_IF_ID is

begin

pc: process(clock, IF_Flush, IF_ID_Enable)
	begin
		
		if clock = '1' and IF_ID_Enable = '1' then
			outPC <= std_logic_vector(unsigned(inPC) + 2);
			outInstruction <= inInstruction;
		elsif clock = '1' and IF_Flush = '1' then
			outPC <= (others => '0');
			outInstruction <= (others => '0');
		end if;
end process pc;

end behavioral;	
		
	