-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_EX_MEM is

	generic (
		n: INTEGER := 16;
		addressSize : INTEGER := 3
	);
	
	port(
		clock, isLW, WriteEnable, ReadDigit, PrintDigit: IN std_logic;
		R2Reg, Result: IN std_logic_vector(n-1 downto 0);
		RegAD : IN std_logic_vector (addressSize-1 downto 0);
		
		isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM: OUT std_logic;
		R2Reg_EXMEM, Result_EXMEM: OUT std_logic_vector(n-1 downto 0);
		RegAD_EXMEM: OUT std_logic_vector(addressSize-1 downto 0)
	);
	
end register_EX_MEM;

architecture behavioral of register_EX_MEM is

begin

pc: process(clock)
	begin
		
		if clock = '1' then
		
			RegAD_EXMEM <= RegAD;
			R2Reg_EXMEM <= R2Reg;
			Result_EXMEM <= Result;
			isLW_EXMEM <= isLW;
			WriteEnable_EXMEM <= WriteEnable;
			ReadDigit_EXMEM <= ReadDigit;
			PrintDigit_EXMEM <= PrintDigit;
			
		else
		
			RegAD_EXMEM <= (others => '0');
			R2Reg_EXMEM <= (others => '0');
			Result_EXMEM <= (others => '0');
			isLW_EXMEM <= '0';
			WriteEnable_EXMEM <= '0';
			ReadDigit_EXMEM <= '0';
			PrintDigit_EXMEM <= '0';
			
		end if;
end process pc;

end behavioral;	
		
	