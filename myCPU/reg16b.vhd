-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity reg16b is --set as TOP level entity

	port(
		input: IN std_logic_vector(15 downto 0);
		enable, clock: IN std_logic;
		
		output: OUT std_logic_vector(15 downto 0)
	);
	
end reg16b;

architecture behavioral of reg16b is

begin

 process(clock)
 begin
		
		if clock'EVENT and clock = '0' then
			if enable = '1' then
				output <= input;
			end if;
		end if;
		
 end process;

end behavioral;	
		
	