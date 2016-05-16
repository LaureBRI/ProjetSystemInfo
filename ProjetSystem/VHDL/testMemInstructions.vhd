--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:52:59 04/11/2016
-- Design Name:   
-- Module Name:   /home/grabot/4A/S2/ProjetSysInfo/SystemeInfo/testMemInstructions.vhd
-- Project Name:  SystemeInfo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memInstructions
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testMemInstructions IS
END testMemInstructions;
 
ARCHITECTURE behavior OF testMemInstructions IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memInstructions
    PORT(
         Addr : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         OUTI : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Addr : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal OUTI : std_logic_vector(31 downto 0);


BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memInstructions PORT MAP (
          Addr => Addr,
          CLK => CLK,
          OUTI => OUTI
        );
	
		--tests :
	CLK <= not CLK after 20ns;
	Addr <= "00000001";--, "00000010" after 80ns, "00000001" after 160ns ;

END;
