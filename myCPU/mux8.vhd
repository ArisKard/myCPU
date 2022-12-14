-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity mux8 is 

generic(
			n: INTEGER := 16
		);

port (in0, in1, in2, in3, in4, in5, in6, in7: in std_logic_vector(n-1 downto 0);
		choice: in std_logic_vector(2 downto 0);
		output: out std_logic_vector(n-1 downto 0)
		);
end mux8;

architecture behavioral of mux8 is
begin

	with choice select
	
	output <= in0 when "000",
				 in1 when "001",
				 in2 when "010",
				 in3 when "011",
				 in4 when "100",
				 in5 when "101",
				 in6 when "110",
				 in7 when "111",	 
				"0000000000000000" when others;
	
end behavioral;