-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity Forwarder is

	generic (
		addr_size: INTEGER := 3
	);
	
	port(
		R1AD, R2AD, RegAD_EXMEM, RegAD_MEMWB: IN std_logic_vector(addr_size-1 downto 0);
		
		S1, S2: OUT std_logic_vector(1 downto 0)
	);
	
end Forwarder;

architecture behavioral of Forwarder is

begin

 process(RegAD_EXMEM, RegAD_MEMWB, R1AD, R2AD)
	begin
		
		S1 <= "00"; -- select R1AD
		S2 <= "00"; -- select R2AD
	
		if (R1AD = RegAD_EXMEM) then
			S1 <= "10"; -- select regAD_EXMEM
		elsif (R1AD = RegAD_MEMWB) then
			S1 <= "01"; -- select regAD_MEMWB
		end if;	
		
		if (R2AD = RegAD_EXMEM) then
			S2 <= "10"; -- select regAD_EXMEM
		elsif (R2AD = RegAD_MEMWB) then
			S2 <= "01"; -- select regAD_MEMWB
		end if;	
		
 end process;

end behavioral;	
		
	