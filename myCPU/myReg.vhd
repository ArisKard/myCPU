-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity myReg is 
port (input, clock, enable: in std_logic;
		output: out std_logic);
end myReg;

architecture behavioral of myReg is

signal p1, p2, p3, p4, p5, p6, afterClock: std_logic;
begin

	p3 <= p1 NAND p4;
	p1 <= afterClock NAND p3;
	p2 <= NOT(afterClock AND p1 AND p4);
	p4 <= input NAND p2;
	p5 <= p6 NAND p1;
	p6 <= p2 NAND p5;
	afterClock <= clock AND enable;
	output <= p5;
	
end behavioral;