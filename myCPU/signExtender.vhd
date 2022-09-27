-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity signExtender is 

generic(
			n: INTEGER := 16;
			k: INTEGER := 6
		);

port (immediate: in std_logic_vector(k-1 downto 0);
		extended: out std_logic_vector(n-1 downto 0)
		);
end signExtender;

architecture behavioral of signExtender is
begin

	extended <= (n-1 downto k => immediate(k-1)) & (immediate);
	
end behavioral;