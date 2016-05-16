----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:04:33 04/11/2016 
-- Design Name: 
-- Module Name:    memDonnees - Behavioral 
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

entity memDonnees is
    Port ( Addr : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           IND : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OUTD : out  STD_LOGIC_VECTOR (SIZEDATA downto 0));
end memDonnees;

architecture Behavioral of memDonnees is
	type MEMDATA is array(0 to SIZEMEMD) of STD_LOGIC_VECTOR(SIZEDATA downto 0);
	signal memD : MEMDATA;

begin

	process
	
	begin
		wait until CLK'EVENT and CLK='1';
		
		if(RST = '1') then
			OUTD <= (others => '0');
			memD <= (others => (others => '0'));	
		else
			-- Lecture
			if(RW = '1') then
				OUTD <= memD(conv_integer(Addr));
			elsif(RW='0')then -- Ecriture
				memD(conv_integer(Addr)) <= IND ;
			end if;
		end if;
	
	end process;

end Behavioral;

