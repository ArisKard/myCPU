-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity hazardUnit is
	
	port(
		isJR, isJump, wasJump, mustBranch: IN std_logic;
		
		flush, wasJumpOut: OUT std_logic;
		JRopcode: OUT std_logic_vector(1 downto 0)
	);
	
end hazardUnit;

architecture behavioral of hazardUnit is

begin

 process(isJR, isJump, wasJump, mustBranch)
	begin
		
		flush <= '0';
		
		if isJR = '1' or isJump = '1' or wasJump = '1' or mustBranch = '1' then
			flush <= '1';
		end if;
	
		if isJump = '1' or isJR = '1' then
			JRopcode <= "01";
		elsif mustBranch = '1' then
			JRopcode <= "10";
		else
			JRopcode <= "00";
		end if;
		
 end process;
 
	wasJumpOut <= isJump;

end behavioral;	
		
	