-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024

library ieee;
use ieee.std_logic_1164.all;

entity regFile is 

generic(
			n: INTEGER := 16;
			k: INTEGER := 3;
			regNum: INTEGER := 8
		);


port (clock: in std_logic;
		write1: in std_logic_vector (n-1 downto 0);
		write1AD, read1AD, read2AD: in std_logic_vector (k-1 downto 0);
		read1, read2: out std_logic_vector(n-1 downto 0);
		outall: out std_logic_vector(n*regNum-1 downto 0)
		);
end regFile;

architecture behavioral of regFile is

component reg0 is
	port (input: in std_logic_vector(n-1 downto 0);
			enable, clock: in std_logic;
			output: out std_logic_vector(n-1 downto 0)
		);
end component;

component myReg_16bits is
	port (input: in std_logic_vector(n-1 downto 0);
			enable, clock: in std_logic;
			output: out std_logic_vector(n-1 downto 0)
		);
end component;

component decode3to8 is
	port (input: in std_logic_vector(k-1 downto 0);
		output: out std_logic_vector(regNum-1 downto 0)
		);
end component;

component mux8 is
	port (in0, in1, in2, in3, in4, in5, in6, in7: in std_logic_vector(n-1 downto 0);
		choice: in std_logic_vector(k-1 downto 0);
		output: out std_logic_vector(n-1 downto 0)
		);
end component;

signal enableSigs: std_logic_vector(regNum-1 downto 0);
signal re0, re1, re2, re3, re4, re5, re6, re7: std_logic_vector(n-1 downto 0);

begin

	V0: decode3to8 port map(write1AD, enableSigs);

	V1: reg0 port map(write1, enableSigs(0), clock, re0);
	V2: myReg_16bits port map(write1, enableSigs(1), clock, re1);
	V3: myReg_16bits port map(write1, enableSigs(2), clock, re2);
	V4: myReg_16bits port map(write1, enableSigs(3), clock, re3);
	V5: myReg_16bits port map(write1, enableSigs(4), clock, re4);
	V6: myReg_16bits port map(write1, enableSigs(5), clock, re5);
	V7: myReg_16bits port map(write1, enableSigs(6), clock, re6);
	V8: myReg_16bits port map(write1, enableSigs(7), clock, re7);
	
	V9: mux8 port map(re0, re1, re2, re3, re4, re5, re6, re7, read1AD, read1);
	V10: mux8 port map(re0, re1, re2, re3, re4, re5, re6, re7, read2AD, read2);
	
	outall <= re7 & re6 & re5 & re4 & re3 & re2 & re1 & re0; 
	
end behavioral;