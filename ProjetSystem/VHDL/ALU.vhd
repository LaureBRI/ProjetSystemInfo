----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:36:14 04/01/2016 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0); -- sortie 
           N : out  STD_LOGIC; -- 1 si sortie < 0
           O : out  STD_LOGIC; -- 1 sur overflow taille A OP B > 8
           Z : out  STD_LOGIC; -- 1 si sortie null
           C : out  STD_LOGIC); -- 1 si retenue
end ALU;

architecture Behavioral of ALU is
	signal tmpA : STD_LOGIC_VECTOR(8 downto 0);
	signal tmpB : STD_LOGIC_VECTOR(8 downto 0);
	signal tmpR : STD_LOGIC_VECTOR(8 downto 0);
	signal ResMult : STD_LOGIC_VECTOR(17 downto 0); -- résultat de la multiplication sur 18 bits

begin

	
	tmpA <= "0" & A;
	tmpB <= "0" & B;
	S <= tmpR(7 downto 0);
	ResMult <= tmpA * tmpB;
--	O <= '0';
--	C <= '0';
--	Z <= '0';
--	N <= '0';
	
	tmpR <= (tmpA + tmpB) when Ctrl_Alu = "001" else 
				ResMult(8 downto 0) when Ctrl_Alu = "010" else
				tmpA - tmpB when Ctrl_Alu = "011" 
				else tmpA;--else
				--unsigned(tmpA) / unsigned(tmpB) when Ctrl_Alu = "100" ;
				
	C <= tmpR(8);
	O <= '1' when tmpA(7) = '0' and tmpB(7) = '0' and tmpR(7) = '1' else
			'1' when tmpA(7) = '1' and tmpB(7) = '1' and tmpR(7) = '0' else
			'0';
	Z <= '1' when tmpR = X"0" else 
			'0'; 
	N <= '1' when tmpR(7) = '1' else 
			'0';
	
--	process 
--		begin
--			 Vérification Code opération
--			case Ctrl_Alu is
--				when "001" => -- Addition
--					tmpR <= tmpA + tmpB;
--					C := tmpR(8);
--					O := tmpR(7);
--					
--				when "010" => -- Multiplication
--				
--				when "011" => -- Soustraction
--				
--				when "100" => -- Division
--				
--			end case;
--	end process;
end Behavioral;

