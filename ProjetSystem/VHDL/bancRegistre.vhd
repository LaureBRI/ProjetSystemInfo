----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:59:38 04/08/2016 
-- Design Name: 
-- Module Name:    bancRegistre - Behavioral 
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

entity bancRegistre is
    Port ( AddrA : in  STD_LOGIC_VECTOR (SIZEADDR downto 0);
           AddrB : in  STD_LOGIC_VECTOR (SIZEADDR downto 0);
           AddrW : in  STD_LOGIC_VECTOR (SIZEADDR downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           QB : out  STD_LOGIC_VECTOR (SIZEDATA downto 0));
end bancRegistre;

architecture Behavioral of bancRegistre is
	type REG is array(0 to SIZETAB) of STD_LOGIC_VECTOR(SIZEDATA downto 0);
	signal tab : REG;

begin

	--tab <= (1 => "00001111", (others => (others => '0')) );
				
	--tab <= (others => (others => '0')) when (RST = '1');
	
	QA <= DATA when AddrA = AddrW else
			tab(conv_integer(AddrA));
	
	QB <= DATA when (AddrB = AddrW) else
			tab(conv_integer(AddrB));
			
	
	
	
	
	process	
	begin 
		wait until CLK'EVENT and CLK='1';
		if(RST = '1') then
			tab <= (others => (others => '0'));
			--QA <= (others => '0') ;
		end if;
--		else 
--			if(AddrA = AddrW) then
--				QA <= DATA ;
--			else 
--				QA <= tab(conv_integer(AddrA));
--			end if;
--			if(AddrB = AddrW) then
--				QB <= DATA ;
--			else 
--				QB <= tab(conv_integer(AddrB));
--			end if;

			-- Ecriture est synchrone 
			if( W = '1') then
				tab(conv_integer(AddrW)) <= DATA;
			end if;
--
--		end if;
--	
	
	end process;


end Behavioral;

