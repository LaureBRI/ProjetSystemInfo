--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:24:08 04/11/2016
-- Design Name:   
-- Module Name:   /home/grabot/4A/S2/ProjetSysInfo/SystemeInfo/testMemDonnees.vhd
-- Project Name:  SystemeInfo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memDonnees
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
 
ENTITY testMemDonnees IS
END testMemDonnees;
 
ARCHITECTURE behavior OF testMemDonnees IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal Addr : std_logic_vector(7 downto 0) := (others => '0');
   signal IND : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal OUTD : std_logic_vector(7 downto 0);

   -- Clock period definitions
  -- constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memDonnees PORT MAP (
          Addr => Addr,
          IND => IND,
          RW => RW,
          RST => RST,
          CLK => CLK,
          OUTD => OUTD
        );
		  
	CLK <= not CLK after 20ns;
	RST <= '1', '0' after 40ns ; 
	Addr <= "00000001", "00000010" after 160ns, "00000001" after 250ns ;
	IND <= "11110110";
	RW <= '0', '1' after 80ns;
		  

--   -- Clock process definitions
--   CLK_process :process
--   begin
--		CLK <= '0';
--		wait for CLK_period/2;
--		CLK <= '1';
--		wait for CLK_period/2;
--   end process;
-- 
--
--   -- Stimulus process
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for CLK_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;

END;
