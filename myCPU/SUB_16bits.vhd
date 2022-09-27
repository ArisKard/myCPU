-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity SUB_16bits is 
port (A, B: in std_logic_vector(15 downto 0);
		carryin: in std_logic;
		sub: out std_logic_vector(15 downto 0);
		carryout: out std_logic);
end SUB_16bits;

architecture structural of SUB_16bits is

component ADD_16bits
port (A, B: in std_logic_vector(15 downto 0);
		carryin: in std_logic;
		sum: out std_logic_vector(15 downto 0);
		carryout: out std_logic);
end component;

signal temp1, temp2, temp3: std_logic_vector(15 downto 0);
begin
	
	temp1 <= B;
	temp2 <= "0000000000000000";
	temp3 <= temp2 - temp1;
	
	V0: ADD_16bits port map(A, temp3, carryin, sub, carryout);

end structural;