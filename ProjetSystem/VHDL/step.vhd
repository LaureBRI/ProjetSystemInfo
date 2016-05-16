----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:33:12 04/15/2016 
-- Design Name: 
-- Module Name:    step - Behavioral 
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
use work.constante.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity step is
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
end step;

architecture Behavioral of step is

begin

process
	begin
		wait until CLK'EVENT and CLK='1';
		OUTA <= INA;
		OUTB <= INB;
		OUTOP <= INOP;
		OUTC <= INC;
			
	end process;

end Behavioral;

