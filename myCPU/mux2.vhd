-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity mux2 is 

generic(
			n: INTEGER := 16
		);

port (in1, in2: in std_logic_vector(n-1 downto 0);
		choice: in std_logic;
		
		output: out std_logic_vector(n-1 downto 0)
		);
end mux2;

architecture behavioral of mux2 is
begin

	with choice select
	
	output <= in1 when '0',
				 in2 when '1';
				 
	
end behavioral;