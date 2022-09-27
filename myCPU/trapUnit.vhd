-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity trapUnit is
	
	port(
		opcode: IN std_logic_vector (3 downto 0);
		
		EOR: OUT std_logic
	);
	
end trapUnit;

architecture behavioral of trapUnit is

begin

 process(opcode)
	begin
		
		if opcode = "1110" then
			EOR <= '1';
		else
			EOR <= '0';
		end if;
		
 end process;

end behavioral;	
		
	