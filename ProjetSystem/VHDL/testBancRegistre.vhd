--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:00:11 04/08/2016
-- Design Name:   
-- Module Name:   /home/grabot/4A/S2/ProjetSysInfo/SystemeInfo/testBancRegistre.vhd
-- Project Name:  SystemeInfo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bancRegistre
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
 
ENTITY testBancRegistre IS
END testBancRegistre;
 
ARCHITECTURE behavior OF testBancRegistre IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal AddrA : std_logic_vector(3 downto 0) := (others => '0');
   signal AddrB : std_logic_vector(3 downto 0) := (others => '0');
   signal AddrW : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(7 downto 0);
   signal QB : std_logic_vector(7 downto 0);

   -- Clock period definitions
  constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bancRegistre PORT MAP (
          AddrA => AddrA,
          AddrB => AddrB,
          AddrW => AddrW,
          W => W,
          DATA => DATA,
          RST => RST,
          CLK => CLK,
          QA => QA,
          QB => QB
        );
		  
		  
	 --CLK <= not CLK after 20ns;
	 RST <= '1', '0' after 40ns ; 
	 W <='1', '0' after 60 ns;
	 AddrW <="0010";
	 DATA <= "00001100";
	 AddrA <= "0010" after 60ns;
	 AddrB <= "0100" after 60ns;
	 
	  
	 

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
