-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_ID_EX is

	generic (
		n: INTEGER := 16;
		addressSize : INTEGER := 3
	);
	
	port(
		clock, isEOR, wasJumpOut, isJump, isJR, isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isPrintDigit: IN std_logic;
		ALUFunc: IN std_logic_vector(3 downto 0);
		R1Reg, R2Reg, immediate16 : IN std_logic_vector(n-1 downto 0);
		R1AD, R2AD: IN std_logic_vector(addressSize-1 downto 0);
		jumpShortAddr: IN std_logic_vector(11 downto 0);
		
		isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX: OUT std_logic;
		ALUFunc_IDEX : OUT std_logic_vector(3 downto 0);
		R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX: OUT std_logic_vector(n-1 downto 0);
		R1AD_IDEX, R2AD_IDEX: OUT std_logic_vector(addressSize-1 downto 0);
		jumpShortAddr_IDEX: out std_logic_vector(11 downto 0)
	);
	
end register_ID_EX;

architecture behavioral of register_ID_EX is

begin

pc: process(clock)
	begin
		
		if clock = '1' then
		
			isEOR_IDEX <= isEOR;
			wasJumpOut_IDEX <= wasJumpOut;
			isJump_IDEX <= isJump;
			isJR_IDEX <= isJR;
			isR_IDEX <= isR;
			isMFPC_IDEX <= isMFPC;
			ALUFunc_IDEX <= AlUFunc;
			R1Reg_IDEX <= R1Reg;
			R2Reg_IDEX <= R2Reg;
			immediate16_IDEX <= immediate16;
			R1AD_IDEX <= R1AD;
			R2AD_IDEX <= R2AD;
			jumpShortAddr_IDEX <= jumpShortAddr;
			isReadDigit_IDEX <= isReadDigit;
			isPrintDigit_IDEX <= isPrintDigit;
			isLW_IDEX <= isLW;
			isSW_IDEX <= isSW;
			
		else
		
			isEOR_IDEX <= '0';
			wasJumpOut_IDEX <= '0';
			isJump_IDEX <= '0';
			isJR_IDEX <= '0';
			isR_IDEX <= '0';
			isMFPC_IDEX <= '0';
			ALUFunc_IDEX <= (others => '0');
			R1Reg_IDEX <= (others => '0');
			R2Reg_IDEX <= (others => '0');
			immediate16_IDEX <= (others => '0');
			R1AD_IDEX <= (others => '0');
			R2AD_IDEX <= (others => '0');
			jumpShortAddr_IDEX <= (others => '0');
			isReadDigit_IDEX <= '0';
			isPrintDigit_IDEX <= '0';
			isLW_IDEX <= '0';
			isSW_IDEX <= '0';
			
		end if;
end process pc;

end behavioral;	
		
	