-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity JRSelector is

	generic (
		n: INTEGER := 16
	);
	
	port(
		jumpAD, branchAD, PCP2AD: IN std_logic_vector(n-1 downto 0);
		JRopcode: IN std_logic_vector(1 downto 0);
		
		result: OUT std_logic_vector(n-1 downto 0)
	);
	
end JRSelector;

architecture behavioral of JRSelector is

begin

 process(JRopcode)
	begin
		
		case JROpcode is
			when "00" =>
				result <= PCP2AD;
			when "01" =>
				result <= jumpAD;
			when "10" =>
				result <= branchAD;
			when others => result <= PCP2AD;
		end case;
		
 end process;

end behavioral;	
		
	