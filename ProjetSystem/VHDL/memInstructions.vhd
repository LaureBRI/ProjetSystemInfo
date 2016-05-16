----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:40:09 04/11/2016 
-- Design Name: 
-- Module Name:    memInstructions - Behavioral 
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

entity memInstructions is
    Port ( Addr : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           CLK : in  STD_LOGIC;
           OUTI : out  STD_LOGIC_VECTOR (SIZEDATAI downto 0));
end memInstructions;

architecture Behavioral of memInstructions is
	type MEMINST is array(0 to SIZEMEMI) of STD_LOGIC_VECTOR(SIZEDATAI downto 0);
	signal memI : MEMINST := 
		( 0 => X"00030A06", -- AFC 10 03
			1 => X"00020106", -- AFC 01 02
			2 => X"00010206",-- AFC 02 01
			3 => X"00000609", --JMP 06
			4 => X"02010301", -- ADD 03 01 02
			5 => X"03020402", -- MUL 04 02 03
			6 => X"000A0308", -- STORE 03 10 (Addr 3 dans registre 10)
			7 => X"00070C06", -- AFC 12 07
			8 => X"010A0902", -- MUL 09 10 01
			9 => X"00020B05", -- COP 11 02
			10 => X"010A0503", -- SUB 05 10 01
			11 => X"00030007",-- LOAD 00 03 (Addr 3 dans registre 00)
		others => (others => '0'));

begin
	process
	begin
		wait until CLK'EVENT and CLK='1';
		OUTI <= memI(conv_integer(Addr));
	end process;

end Behavioral;

