-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity ADD_16bits is 
port (A, B: in std_logic_vector(15 downto 0);
		carryin: in std_logic;
		sum: out std_logic_vector(15 downto 0);
		carryout: out std_logic);
end ADD_16bits;

architecture structural of ADD_16bits is

component ADD_1bit
	port (in1, in2, carryin: in std_logic;
			sum, carryout: out std_logic);
end component;

signal C: std_logic_vector(15 downto 0);

begin
	V0: ADD_1bit port map(A(0), B(0), carryin, sum(0), C(0));
	V1: ADD_1bit port map(A(1), B(1), C(0), sum(1), C(1));
	V2: ADD_1bit port map(A(2), B(2), C(1), sum(2), C(2));
	V3: ADD_1bit port map(A(3), B(3), C(2), sum(3), C(3));
	V4: ADD_1bit port map(A(4), B(4), C(3), sum(4), C(4));
	V5: ADD_1bit port map(A(5), B(5), C(4), sum(5), C(5));
	V6: ADD_1bit port map(A(6), B(6), C(5), sum(6), C(6));
	V7: ADD_1bit port map(A(7), B(7), C(6), sum(7), C(7));
	V8: ADD_1bit port map(A(8), B(8), C(7), sum(8), C(8));
	V9: ADD_1bit port map(A(9), B(9), C(8), sum(9), C(9));
	V10: ADD_1bit port map(A(10), B(10), C(9), sum(10), C(10));
	V11: ADD_1bit port map(A(11), B(11), C(10), sum(11), C(11));
	V12: ADD_1bit port map(A(12), B(12), C(11), sum(12), C(12));
	V13: ADD_1bit port map(A(13), B(13), C(12), sum(13), C(13));
	V14: ADD_1bit port map(A(14), B(14), C(13), sum(14), C(14));
	V15: ADD_1bit port map(A(15), B(15), C(14), sum(15), C(15));
	
	carryout <= C(15);
	
end structural;

--Φτιάξαμε το κύκλωμα πρόσθεση 16 bits χρησιμοποιώντας το κύκλωμα ADD για 1 bit