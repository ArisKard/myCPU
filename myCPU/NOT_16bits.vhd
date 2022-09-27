-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity NOT_16bits is 
port (in1: in std_logic_vector(15 downto 0);
	  out1: out std_logic_vector(15 downto 0));	  
end NOT_16bits;

architecture behavioral of NOT_16bits is

--signal temp: std_logic_vector(15 downto 0);
signal temp: std_logic;

begin
	
	process(in1)
	begin
	if (in1 = (in1'range => '0')) then
		temp <= '1';
	else
		temp <= '0';
	end if;
	end process;
	
	out1 <= (15 downto 1 => '0', others => temp);

end behavioral;