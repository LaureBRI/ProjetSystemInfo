----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:33:23 04/11/2016 
-- Design Name: 
-- Module Name:    pipeLine - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.constante.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY pipeLine IS
END pipeLine;

architecture Behavioral of pipeLine is

	component step is
    Port ( INA : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
			  INB : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
			  INOP : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           OUTA : out  STD_LOGIC_VECTOR (SIZEDATA downto 0);
			  OUTB : out  STD_LOGIC_VECTOR (SIZEDATA downto 0);
			  OUTOP : out  STD_LOGIC_VECTOR (SIZEDATA downto 0);
			  INC : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
			  OUTC : out  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           CLK : in  STD_LOGIC;
			  RST : in	STD_LOGIC);

	end  component;
	
	
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         Ctrl_Alu : IN  std_logic_vector(2 downto 0);
         S : OUT  std_logic_vector(7 downto 0);
         N : OUT  std_logic;
         O : OUT  std_logic;
         Z : OUT  std_logic;
         C : OUT  std_logic
        );
    END COMPONENT;
	 
	 COMPONENT memDonnees
    PORT(
         Addr : IN  std_logic_vector(7 downto 0);
         IND : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         OUTD : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT memInstructions
    PORT(
         Addr : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         OUTI : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

	COMPONENT bancRegistre
    PORT(
         AddrA : IN  std_logic_vector(3 downto 0);
         AddrB : IN  std_logic_vector(3 downto 0);
         AddrW : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

	COMPONENT LC 
		PORT ( OP : IN  STD_LOGIC_VECTOR (7 downto 0);
           W : OUT   STD_LOGIC
			);
	END COMPONENT;


	-- SIGNAUX PIPELINE
	signal LIDI_Ain, LIDI_Aout, LIDI_OPin, LIDI_OPout, LIDI_Bin, LIDI_Bout, LIDI_Cin, LIDI_Cout : STD_LOGIC_VECTOR (SIZEDATA downto 0);
	signal DIEX_Aout, DIEX_OPout, DIEX_Bin, DIEX_Bout, DIEX_Cin, DIEX_Cout : STD_LOGIC_VECTOR (SIZEDATA downto 0);
	signal  EXMEM_Aout, EXMEM_OPout, EXMEM_Bin, EXMEM_Bout : STD_LOGIC_VECTOR (SIZEDATA downto 0);
	signal MEMRE_Aout, MEMRE_OPout,  MEMRE_Bin, MEMRE_Bout : STD_LOGIC_VECTOR (SIZEDATA downto 0);
	--EXMEM_Ain, EXMEM_OPin, MEMRE_Ain, MEMRE_OPin, MEMRE_Bin
	
	-- SIGNAUX BANC DE REGISTRE
	signal QA : STD_LOGIC_VECTOR (SIZEDATA downto 0);
	signal Data : STD_LOGIC_VECTOR (SIZEDATA downto 0);
	
	--SIGNAUX ALU
	signal Ctrl_ALU : STD_LOGIC_VECTOR(2 downto 0);
	signal S : STD_LOGIC_VECTOR (SIZEDATA downto 0);
	
	--SIGNAUX MEMINSTRUCTIONS
	signal Add : STD_LOGIC_VECTOR(SIZEDATA  downto 0) := (others => '0');
	signal OutInst : STD_LOGIC_VECTOR(SIZEDATAI downto 0);
	
	--SIGNAUX MEMOIRE DE DONNEES
	signal OutData : STD_LOGIC_VECTOR(SIZEDATA downto 0);
	signal AddrData : STD_LOGIC_VECTOR(SIZEDATA downto 0);
	signal IND : STD_LOGIC_VECTOR(SIZEDATA downto 0);
	signal RW : STD_LOGIC;
	
	--SIGNAUX COMMUNS
	signal W,RST : STD_LOGIC;
	signal CLK : STD_LOGIC := '0';
	
	-- pour les signaux non utilisés
	signal Cin_Unuse, Cout_Unuse : STD_LOGIC_VECTOR (SIZEDATA downto 0) := X"00"; -- pour les ports que l'on utilise pas 
	signal Unuse : STD_LOGIC_VECTOR (SIZEADDR downto 0) := X"0"; -- pour les ports que l'on utilise pas 
	signal Unuse_2 : STD_LOGIC_VECTOR (SIZEDATA downto 0) := X"00";
	signal U : STD_LOGIC := '0';

	
	BEGIN
		
		CLK <= not CLK after 20ns;	
		
		RST <= '1', '0' after 40ns;
		
		-- parcourir la memoire d'instructions
		Add <= LIDI_Ain when LIDI_OPin = X"09" -- JMP
				else Add + X"1" after 200ns;--, Add + X"1" after 200ns, (others => '0') after 300 ns;
		
		INST : memInstructions port map(Add, CLK, OutInst);
		
		LIDI_OPin <= OutInst( SIZEDATA downto 0) after 50ns;
		LIDI_Ain <= OutInst( (SIZEDATA*2)+1 downto SIZEDATA+1) after 50ns;
		LIDI_Bin <= OutInst( (SIZEDATA*3)+2 downto (SIZEDATA*2)+2) after 50ns;
		LIDI_Cin <= OutInst( (SIZEDATA*4)+3 downto (SIZEDATA*3)+3) after 50ns;

		-- step InA, InB, InOP, OUTA, OUTB, OUTOP, INC, OUTC, CLK
		LIDI: step port map (LIDI_Ain, LIDI_Bin, LIDI_OPin, LIDI_Aout, LIDI_Bout, LIDI_OPout, LIDI_Cin, LIDI_Cout, CLK, RST);
		

		DIEX_Bin <= QA when LIDI_OPout = X"01" --ADD
					or LIDI_OPout = "00000010" --MUL
					or LIDI_OPout = "00000011" --SUB
					or LIDI_OPout = "00000100" --DIV
					or LIDI_OPout = "00000101" --COP
					or LIDI_OPout = X"08" -- STORE
					else LIDI_Bout;
		
		
		DIEX: step port map (LIDI_Aout, DIEX_Bin, LIDI_OPout, DIEX_Aout, DIEX_Bout, DIEX_OPout, DIEX_Cin, DIEX_Cout, CLK, RST ); 
	
		EXMEM_Bin <= S when DIEX_OPout = X"01" --ADD
					or DIEX_OPout = "00000010" --MUL
					or DIEX_OPout = "00000011" --SUB
					or DIEX_OPout = "00000100" --DIV
					else DIEX_Bout;
		
		
		Ctrl_ALU <= DIEX_OPout(2 downto 0) when DIEX_OPout = "00000001" 
					or DIEX_OPout = "00000010" --MUL
					or DIEX_OPout = "00000011" --SUB
					or DIEX_OPout = "00000100" --DIV
					else "000";
		
		--Alu : A, B, CTRL_ALU, S, N, O, Z, C
		CircuitALU : alu port map(DIEX_Bout, DIEX_Cout, Ctrl_ALu, S, U,U,U,U );
		EXMEM: step port map ( DIEX_Aout, EXMEM_Bin, DIEX_OPout, EXMEM_Aout, EXMEM_Bout, EXMEM_OPout, Cin_Unuse, Cout_Unuse, CLK, RST );
		
		AddrData <= EXMEM_Aout when EXMEM_OPout = X"08"
						else EXMEM_Bout when EXMEM_OPout = X"07"
						else "UUUUUUUU";
	
		
		--LogicData: LC port map (EXMEM_OPout, W );
		RW <= '1' when EXMEM_OPout = X"07" else
				'0' when EXMEM_OPout = X"08" else
				'U';	

				
		Data <= OutData when MEMRE_OPout = X"07" 
				else MEMRE_Bout;
		
		IND <= EXMEM_Bout when MEMRE_OPout = X"08" 
				else "UUUUUUUU";
		
		-- MemDonnes : Addr, IND, RW, RST, CLK, OUTD
		Donnes : memDonnees port map (AddrData, IND, RW, RST, CLK, OutData);
		
		MEMRE_Bin <= MEMRE_Bout;
		
		-- step InA, InB, InOP, OUTA, OUTB, OUTOP, INC, OUTC, CLK
		MEMRE: step port map ( EXMEM_Aout,  EXMEM_Bout, EXMEM_OPout, MEMRE_Aout, MEMRE_Bout, MEMRE_OPout, Cin_Unuse, Cout_Unuse, CLK, RST);
		LogicC: LC port map ( MEMRE_OPout, W );
		-- BR : AddA, AddB, AddW, W, DATA, RST, CLK, QA, QB
		BancReg: bancRegistre port map (LIDI_Bout(3 downto 0), LIDI_Cout(3 downto 0), MEMRE_Aout(3 downto 0), W, Data, RST, CLK, QA, DIEX_Cin);
		
	
END Behavioral;

