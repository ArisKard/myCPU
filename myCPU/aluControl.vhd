-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity aluControl is 

port (opCode: in std_logic_vector(3 downto 0);
		func: in std_logic_vector(2 downto 0);
		output: out std_logic_vector(3 downto 0)
		);
end aluControl;

architecture behavioral of aluControl is

begin
	
	process(opCode, func)
	begin

		case opCode is
		
			when "0000" =>
					output(3) <= '0';
					output(2 downto 0) <= func(2 downto 0);
			when others => output <= opCode;
		
		end case;			
	end process;	
		
end behavioral;