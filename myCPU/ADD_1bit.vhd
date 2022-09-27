--Μαγδαληνή Κυριακίδου 3130108

library ieee;
use ieee.std_logic_1164.all;

entity ADD_1bit is 

	port (in1, in2, carryin: in std_logic;
			sum, carryout: out std_logic);
		
end ADD_1bit;

architecture structural of ADD_1bit is

	component myAND
		port (in1, in2: in std_logic;
				out1: out std_logic);
	end component;

	component myOR3
		port (in1, in2, in3: in std_logic;
				out1: out std_logic);
	end component;

	component myXOR
		port (in1, in2, in3: in std_logic;
				out1: out std_logic);
	end component;

	signal s1, s2, s3: std_logic;

	begin
		V0: myXOR port map(in1, in2, carryin, sum);
		V1: myAND port map(in1, in2, s1);
		V2: myAND port map(in1, carryin, s2);
		V3: myAND port map(in2, carryin, s3);
		V4: myOR3 port map(s1, s2, s3, carryout);
end structural;

--Φτιάξαμε το κύκλωμα ADD για 1 bit χρησιμοποιώντας τα κυκλώματα myAND , myOR και myXOR