-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity myReg_16bits is 

generic(
			n: INTEGER := 16
		);

port (input: in std_logic_vector(n-1 downto 0);
		enable, clock: in std_logic;
		output: out std_logic_vector(n-1 downto 0)
		);
end myReg_16bits;

architecture structural of myReg_16bits is

component myReg
	port (input, clock, enable: in std_logic;
			output: out std_logic);
end component;

begin
	V0: myReg port map(input(0), clock, enable, output(0));
	V1: myReg port map(input(1), clock, enable, output(1));
	V2: myReg port map(input(2), clock, enable, output(2));
	V3: myReg port map(input(3), clock, enable, output(3));
	V4: myReg port map(input(4), clock, enable, output(4));
	V5: myReg port map(input(5), clock, enable, output(5));
	V6: myReg port map(input(6), clock, enable, output(6));
	V7: myReg port map(input(7), clock, enable, output(7));
	V8: myReg port map(input(8), clock, enable, output(8));
	V9: myReg port map(input(9), clock, enable, output(9));
	V10: myReg port map(input(10), clock, enable, output(10));
	V11: myReg port map(input(11), clock, enable, output(11));
	V12: myReg port map(input(12), clock, enable, output(12));
	V13: myReg port map(input(13), clock, enable, output(13));
	V14: myReg port map(input(14), clock, enable, output(14));
	V15: myReg port map(input(15), clock, enable, output(15));
	
end structural;