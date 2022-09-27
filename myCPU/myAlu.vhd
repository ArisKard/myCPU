-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity myAlu is

	generic(
		n : integer:= 16
	);
	
	port( 
			input1, input2 : in std_logic_vector(n-1 downto 0);
			operation : in std_logic_vector(2 downto 0);
			output : out std_logic_vector(n-1 downto 0)
		 );
end myAlu;

architecture LogicFunc of myAlu is

	--write here all the components
	
	--V0 temp0 "000"
	component  ADD_16bits is 
		port (A, B: in std_logic_vector(n-1 downto 0);
				carryin: in std_logic;
				sum: out std_logic_vector(n-1 downto 0);
				carryout: out std_logic);
	end component;
	
	--V1 temp1 "001"
	component SUB_16bits is
		port (a, b: in std_logic_vector(n-1 downto 0);
				carryin: in std_logic;
				sub: out std_logic_vector(n-1 downto 0);
				carryout: out std_logic);
	end component;
	
	--V2 temp2 "010"
	component AND_16bits is 
		port (in1, in2: in std_logic_vector(n-1 downto 0);
				out1: out std_logic_vector(n-1 downto 0));
	end component;
	
	--V3 temp3 "011"
	component OR_16bits is 
		port (in1, in2: in std_logic_vector(n-1 downto 0);
				out1: out std_logic_vector(n-1 downto 0));
	end component;

	--V4 temp4 "100"
	component GEQ_16bits is
		port (
			in1: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0)
		);
	end component;
	
	--V5 temp5 "101"
	component NOT_16bits is
		port (
			in1: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0)
		);
	end component;
	

	
	--signal carryouts : std_logic_vector(n-1 downto 0);
	signal carryout : std_logic;
	signal temp0, temp1, temp2, temp3, temp4, temp5 : std_logic_vector(n-1 downto 0);
	
	begin
		
		VO: ADD_16bits port map(input1, input2, '0', temp0, carryout);
		V1: SUB_16bits port map(input1, input2, '0', temp1, carryout);
		V2: AND_16bits port map(input1, input2, temp2);
		V3: OR_16bits port map(input1, input2, temp3);
		V4: GEQ_16bits port map(input1, temp4);
		V5: NOT_16bits port map(input1, temp5);
		
		with operation select
			output <= temp0 when "000",
						 temp1 when "001",
						 temp2 when "010",
						 temp3 when "011",
						 temp4 when "100",
						 temp5 when "101",
						 "0000000000000000" when others;

end LogicFunc;