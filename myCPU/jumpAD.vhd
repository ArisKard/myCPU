-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jumpAD is 

generic(
			n: INTEGER := 16;
			k: INTEGER := 12
		);

port (jumpADR: in std_logic_vector(k-1 downto 0);
		instrP2AD: in std_logic_vector(n-1 downto 0);
		EjumpAD: out std_logic_vector(n-1 downto 0)
		);
end jumpAD;

architecture behavioral of jumpAD is

signal extended, multed: std_logic_vector(n-1 downto 0);

begin

	extended <= (n-1 downto k => jumpADR(k-1)) & (jumpADR);
	
	process(instrP2AD)
	begin
		multed <= extended(n-2 downto 0) & '0';
		EjumpAD <= std_logic_vector(unsigned(multed) + unsigned(instrP2AD));
	end process;	
		
end behavioral;