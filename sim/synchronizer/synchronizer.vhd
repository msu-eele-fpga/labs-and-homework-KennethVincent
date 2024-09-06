library IEEE;
use IEEE.std_logic_1164.all
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;

entity synchronizer is
	port (
		clk : in std_ulogic;
		async : in std_ulogic;
		sync : out std_ulogic
	);
end entity synchronizer;

architecture architecture_synchronizer of synchronizer is
	signal transfer : std_logic;

	begin
	
		proc_sync : process(clk)
			begin
				if rising_edge(clk) then 
					transfer <= async; sync <= transfer;
				end if
		end process;
	
end architecture;


