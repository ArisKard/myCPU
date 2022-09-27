-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity AND_16bits is 
port (in1, in2: in std_logic_vector(15 downto 0);
		out1: out std_logic_vector(15 downto 0));
end AND_16bits;

architecture structural of AND_16bits is

component myAND
	port (in1, in2: in std_logic;
			out1: out std_logic);
end component;

begin
	V0: myAND port map(in1(0), in2(0), out1(0));
	V1: myAND port map(in1(1), in2(1), out1(1));
	V2: myAND port map(in1(2), in2(2), out1(2));
	V3: myAND port map(in1(3), in2(3), out1(3));
	V4: myAND port map(in1(4), in2(4), out1(4));
	V5: myAND port map(in1(5), in2(5), out1(5));
	V6: myAND port map(in1(6), in2(6), out1(6));
	V7: myAND port map(in1(7), in2(7), out1(7));
	V8: myAND port map(in1(8), in2(8), out1(8));
	V9: myAND port map(in1(9), in2(9), out1(9));
	V10: myAND port map(in1(10), in2(10), out1(10));
	V11: myAND port map(in1(11), in2(11), out1(11));
	V12: myAND port map(in1(12), in2(12), out1(12));
	V13: myAND port map(in1(13), in2(13), out1(13));
	V14: myAND port map(in1(14), in2(14), out1(14));
	V15: myAND port map(in1(15), in2(15), out1(15));	
	
end structural;