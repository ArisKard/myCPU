-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity Selector is

	generic (
		n: INTEGER := 16
	);
	
	port(
		Reg, Memory, WriteBack: IN std_logic_vector(n-1 downto 0);
		operation: IN std_logic_vector(1 downto 0);
		
		output: OUT std_logic_vector(n-1 downto 0)
	);
	
end Selector;

architecture behavioral of Selector is

begin

   with operation select
	output <= Reg when "00",
				 WriteBack when "01",
				 Memory when "10",
				 "0000000000000000" when "11";

end behavioral;	
		
	