-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity reg0 is 

generic(
			n: INTEGER := 16
		);

port (input: in std_logic_vector(n-1 downto 0);
		enable, clock: in std_logic;
		output: out std_logic_vector(n-1 downto 0)
		);
end reg0;

architecture behavioral of reg0 is
begin

	output <= (others => '0');
	
end behavioral;