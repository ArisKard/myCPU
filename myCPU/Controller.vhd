-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity Controller is
	
	port(
		
		opCode: IN std_logic_vector(3 downto 0);
		func : IN std_logic_vector (2 downto 0);
		flush: IN std_logic;
		
		isMPFC, isJumpD, isReadDigit, isPrintDigit, isR, isLW, isSW, isBranch, isJR: OUT std_logic
	);
	
end Controller;

architecture behavioral of Controller is

begin

get_result: process(flush, func, opCode)
	begin
		
			isR <= '0';
			isMPFC <= '0';
			isLW <= '0';
			isSW <= '0';
			isBranch <= '0';
			isReadDigit <= '0';
			isPrintDigit <= '0';
			isJumpD <= '0';
			isJR <= '0';
			
			if flush = '0' then
				case opCode is
					when "0000" =>
						isR <= '1';
						if func = "111" then
							isMPFC <= '1';
						end if;
					when "0001" =>
						isLW <= '1';
					when "0010" =>
						isSW <= '1';
					when "0100" =>
						isBranch <= '1';
					when "0110" =>
						isReadDigit <= '1';
					when "0111" =>
						isPrintDigit <= '1';
					when "1111" =>
						isJumpD <= '1';
					when "1101" =>
						isJR <= '1';
					when others =>
						isR <= '0';
				end case;
			end if;						
			
end process get_result;

end behavioral;	
		
	