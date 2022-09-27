-- ΚΑΡΔΑΣΗΣ ΑΡΗΣ						3130086
-- ΚΥΡΙΑΚΙΔΟΥ ΜΑΓΔΑ				        3130108
-- ΓΑΛΙΑΤΣΑΤΟΥ ΒΑΣΙΛΙΚΗ                 3120024
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity myCPU is -- set as TOP-LEVEL ENTITY


	generic(
		n : integer:= 16;
		k: integer:= 6;
		regNum: INTEGER := 8;
		addressSize: integer := 3
	);

	port( 
			clock : in std_logic;
			keyData, fromData, instruction : in std_logic_vector(n-1 downto 0);
			
			printEnable, keyEnable, DataWriteFlag: out std_logic;
			dataAD, toData, printCode, printData, instructionAD: out std_logic_vector(n-1 downto 0);
			regOUT: out std_logic_vector(n*9 - 1 downto 0)
			
		 );
end myCPU;

architecture LogicFunc of myCPU is

	component trapUnit is 
		port(
			opcode: IN std_logic_vector (3 downto 0);
			
			EOR: OUT std_logic
	);
	end component;
	
	component JRSelector is 
		port(
			jumpAD, branchAD, PCP2AD: IN std_logic_vector(n-1 downto 0);
			JRopcode: IN std_logic_vector(1 downto 0);
			
			result: OUT std_logic_vector(n-1 downto 0)
	);
	end component;
	
	component reg16b is
		port(
			input: IN std_logic_vector(15 downto 0);
			enable, clock: IN std_logic;
			
			output: OUT std_logic_vector(15 downto 0)
		);
	end component;
	
	component register_MEM_WB is
		port(
			Result: IN std_logic_vector(n-1 downto 0);
			RegAD: IN std_logic_vector(addressSize-1 downto 0);
			clock: IN std_logic;
			
			writeData: OUT std_logic_vector(n-1 downto 0);
			writeAD: OUT std_logic_vector(addressSize-1 downto 0)
	);
	end component;
	
	component register_IF_ID is
		port(
			inPC, inInstruction: IN std_logic_vector(n-1 downto 0);
			clock, IF_Flush, IF_ID_Enable: IN std_logic;
		
			outPC, outInstruction: OUT std_logic_vector(n-1 downto 0)
	);
	end component;
	
	
	component Forwarder is
		port(
			R1AD, R2AD, RegAD_EXMEM, RegAD_MEMWB: IN std_logic_vector(addressSize-1 downto 0);
			
			S1, S2: OUT std_logic_vector(1 downto 0)
	);
	end component;
	
	component Selector is
		port(
			Reg, Memory, WriteBack: IN std_logic_vector(n-1 downto 0);
			operation: IN std_logic_vector(1 downto 0);
			
			output: OUT std_logic_vector(n-1 downto 0)
	);
	end component;
	
	component aluControl is
		port (opCode: in std_logic_vector(3 downto 0);
			func: in std_logic_vector(2 downto 0);
			
			output: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component signExtender is
		port (immediate: in std_logic_vector(k-1 downto 0);
		
				extended: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component myAlu is
		port( 
				input1, input2 : in std_logic_vector(n-1 downto 0);
				operation : in std_logic_vector(3 downto 0);
				
				output : out std_logic_vector(n-1 downto 0)
		 );
	end component;
	
	component hazardUnit is
		port(
			isJR, isJump, wasJump, mustBranch: IN std_logic;
			
			flush, wasJumpOut: OUT std_logic;
			JRopcode: OUT std_logic_vector(1 downto 0)
	);
	end component;
	
	component Controller is
		port(
			opCode: IN std_logic_vector(3 downto 0);
			func : IN std_logic_vector (2 downto 0);
			flush: IN std_logic;
			
			isMPFC, isJumpD, isReadDigit, isPrintDigit, isR, isLW, isSW, isBranch, isJR: OUT std_logic
	);
	end component;

	component regFile is
		port (clock: in std_logic;
			write1: in std_logic_vector (n-1 downto 0);
			write1AD, read1AD, read2AD: in std_logic_vector (addressSize-1 downto 0);
			read1, read2: out std_logic_vector(n-1 downto 0);
			outall: out std_logic_vector(n*regNum-1 downto 0)
		);
	end component;
	
	component register_ID_EX is
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
	end component;
	
	component register_EX_MEM is
		port(
			clock, isLW, WriteEnable, ReadDigit, PrintDigit: IN std_logic;
			R2Reg, Result: IN std_logic_vector(n-1 downto 0);
			RegAD : IN std_logic_vector (addressSize-1 downto 0);
			
			isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM: OUT std_logic;
			R2Reg_EXMEM, Result_EXMEM: OUT std_logic_vector(n-1 downto 0);
			RegAD_EXMEM: OUT std_logic_vector(addressSize-1 downto 0)
	);
	end component;
	
	component mux2 is
		port (in1, in2: in std_logic_vector(n-1 downto 0);
		choice: in std_logic;
		
		output: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component mux2_3bits is
	port (in1, in2: in std_logic_vector(addressSize-1 downto 0);
			choice: in std_logic;
		
			output: out std_logic_vector(addressSize-1 downto 0)
		);
	end component;
	
	----------------------------------------------------PC-------------------------------------------------------------------------------------------------------------------
	signal outputFromPC: std_logic_vector(n-1 downto 0);
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------register_IF_ID-------------------------------------------------------------------------------------------------------------------
	signal outPC, outInstruction: std_logic_vector(n-1 downto 0);
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------register_ID_EX-------------------------------------------------------------------------------------------------------------------
	signal isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX: std_logic;
	signal ALUFunc_IDEX : std_logic_vector(3 downto 0);
	signal R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX: std_logic_vector(n-1 downto 0);
	signal R1AD_IDEX, R2AD_IDEX: std_logic_vector(addressSize-1 downto 0);
	signal jumpShortAddr_IDEX: std_logic_vector (11 downto 0);
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------register_EX_MEM-------------------------------------------------------------------------------------------------------------------
	signal isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM: std_logic;
	signal R2Reg_EXMEM, Result_EXMEM: std_logic_vector(n-1 downto 0);
	signal RegAD_EXMEM: std_logic_vector(addressSize-1 downto 0);
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------register_MEM_WB-------------------------------------------------------------------------------------------------------------------
	signal writeData: std_logic_vector(n-1 downto 0);
	signal writeAD: std_logic_vector(addressSize-1 downto 0);
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------ALU_Controller-------------------------------------------------------------------------------------------------------------------
	signal outputAluControl: std_logic_vector(3 downto 0);
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------sign_extender-------------------------------------------------------------------------------------------------------------------
	signal extended: std_logic_vector(n-1 downto 0);
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------controller-------------------------------------------------------------------------------------------------------------------
	signal isMPFC, isJumpD, isReadDigit, isPrintDigit, isR, isLW, isSW, isBranch, isJR: std_logic;
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	----------------------------------------------------keyData or LW mu/xes-------------------------------------------------------------------------------------------------------------------
	signal outMux2_first, outMux2_second: std_logic_vector(n-1 downto 0);
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	----------------------------------------------------selectors-------------------------------------------------------------------------------------------------------------------
	signal outputSelector1, outputSelector2: std_logic_vector(n-1 downto 0);
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	----------------------------------------------------ALU inputs and output-------------------------------------------------------------------------------------------------------------------
	signal ALUInput1, ALUInput2, outputALU: std_logic_vector(n-1 downto 0);
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   ----------------------------------------------------forwarder-------------------------------------------------------------------------------------------------------------------
	signal S1, S2: std_logic_vector(1 downto 0);
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	----------------------------------------------------hazard_unit-------------------------------------------------------------------------------------------------------------------
	signal flushHazardUnit, wasJumpOutHazardUnit: std_logic;
	signal JROpcode: std_logic_vector(1 downto 0);
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------jr_selector-------------------------------------------------------------------------------------------------------------------
	signal resultJRSelector: std_logic_vector(n-1 downto 0);
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	----------------------------------------------------EOR, enable and flush------------------------------------------------------------------------------------------------------------------
	signal trapUnitEOR, enable, flushOrNot: std_logic;
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------R2_address-------------------------------------------------------------------------------------------------------------------
	signal rt: std_logic_vector(addressSize-1 downto 0);
	----------------------------------------------------R2_address-------------------------------------------------------------------------------------------------------------------
	
	----------------------------------------------------regFile------------------------------------------------------------------------------------------------------------------
	signal read1_regFile, read2_regFile: std_logic_vector(n-1 downto 0);
	signal outputAll_regFile: std_logic_vector(n*regNum - 1 downto 0);
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	
	begin
		
		PC: reg16b port map(resultJRSelector, enable, clock, outputFromPC);
		
		JR_SELECTOR: JRSelector port map((outputFromPC(n-1 downto n-3) & jumpShortAddr_IDEX & '0'), immediate16_IDEX, outPC, JROpcode, resultJRSelector); 
		TRAP_UNIT: trapUnit port map(outInstruction(n-1 downto n-4), trapUnitEOR);
				
		IF_ID_REG: register_IF_ID port map(outputFromPC, instruction, clock, '0', '1', outPC, outInstruction);
		ID_EX_REG: register_ID_EX port map(clock, trapUnitEOR, wasJumpOutHazardUnit, isJumpD, isJR, isBranch, isR, isMPFC, isLW, isSW, isReadDigit, isPrintDigit, outputAluControl, read1_regFile, read2_regFile, extended, outInstruction(n-5 downto n-7), rt, outInstruction(n-5 downto 0), isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX, ALUFunc_IDEX, R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX, R1AD_IDEX, R2AD_IDEX, jumpShortAddr_IDEX);	
		EX_MEM_REG: register_EX_MEM port map(clock, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX, R2Reg_IDEX, OutputALU, R2AD_IDEX, isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM, R2Reg_EXMEM, Result_EXMEM, RegAD_EXMEM); 
		MEM_WB_REG: register_MEM_WB port map(outMux2_second, RegAD_EXMEM, clock, writeData, writeAD);
				
		SIGN_EXTENDER: signExtender port map(outInstruction(k-1 downto 0), extended);
		CONTROL_UNIT: Controller port map (outInstruction(n-1 downto n-4), outInstruction(2 downto 0), flushOrNot, isMPFC, isJumpD, isReadDigit, isPrintDigit, isR, isLW, isSW, isBranch, isJR);
		
		KEYDATA_RESULT: mux2 port map(result_EXMEM, keyData, ReadDigit_EXMEM, outMux2_first);
		LW_RESULT: mux2 port map(outMux2_first, fromData, isLW_EXMEM, outMux2_second);
		
		SELECTOR_1: Selector port map(R1Reg_IDEX, outMux2_second, writeData, S1, outputSelector1);
		SELECTOR_2: Selector port map(R2Reg_IDEX, outMux2_second, writeData, S2, outputSelector2);
		
		ALU_CONTROLLER: aluControl port map(outInstruction(n-1 downto n-4), outInstruction(2 downto 0), outputAluControl);
		
		ALUINPUT_1: mux2 port map(outPC, outputSelector1, isMFPC_IDEX, ALUInput1);
		ALUINPUT_2: mux2 port map(outputSelector2, immediate16_IDEX, isR_IDEX, ALUInput2);
		
		ALU: myAlu port map(ALUInput1, ALUInput2, ALUFunc_IDEX, OutputALU);
		
		FORWARDING_UNIT: Forwarder port map(R1AD_IDEX, R2AD_IDEX, RegAD_EXMEM, writeAD, S1, S2);
		
		HAZARD_UNIT: hazardUnit port map(isJR, isJumpD, wasJumpOut_IDEX, isBranch_IDEX, flushHazardUnit, wasJumpOutHazardUnit, JROpcode);
		
		REG2_AD: mux2_3bits port map("000", outInstruction(5 downto 3), isR, rt);	
		REG_FILE: regFile port map(clock, writeData, writeAD, outInstruction(n-5 downto n-7), rt, read1_regFile, read2_regFile, outputAll_regFile);
		
		flushOrNot <= flushHazardUnit OR isEOR_IDEX;
		
		enable <= NOT (trapUnitEOR OR isEOR_IDEX);
		
		instructionAD <= outputFromPC;
		printEnable <= printDigit_EXMEM;
		keyEnable <= readDigit_EXMEM;
		DataWriteFlag <= writeEnable_EXMEM;
		dataAD <= R2Reg_EXMEM;
		toData <= result_EXMEM;
		printCode <= R2Reg_EXMEM;
		printData <= result_EXMEM;
		regOUT <= outputAll_regFile & outputFromPC;
		

end LogicFunc;