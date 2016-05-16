----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:30:16 05/02/2016 
-- Design Name: 
-- Module Name:    Mux - Behavioral 
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

entity Mux is
    Port ( OP : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           IN1 : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           IN2 : in  STD_LOGIC_VECTOR (SIZEDATA downto 0);
           SOut : out  STD_LOGIC_VECTOR (SIZEDATA downto 0));
end Mux;

architecture Behavioral of Mux is

begin
	SOut <= IN2 when OP = "00000001" --ADD
					or OP = "00000010" --MUL
					or OP = "00000011" --SUB
					or OP = "00000100" --DIV
					or OP = "00000101" --COP
				--	or OP = X"06"
				else IN1;


end Behavioral;

