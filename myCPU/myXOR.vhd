-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity myXOR is 
port (in1, in2, in3: in std_logic;
		out1: out std_logic);
end myXOR;

architecture structural of myXOR is
begin
	out1 <= in1 XOR in2 XOR in3;
end structural;