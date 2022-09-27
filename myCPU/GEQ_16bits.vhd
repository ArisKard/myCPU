-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity GEQ_16bits is 
port (in1: in std_logic_vector(15 downto 0);
	  out1: out std_logic_vector(15 downto 0));	  
end GEQ_16bits;

architecture behavioral of GEQ_16bits is
begin
	
	out1 <= (others => NOT in1(15));

end behavioral;