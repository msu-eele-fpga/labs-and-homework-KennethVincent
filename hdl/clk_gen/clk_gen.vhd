library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity clk_gen is
	port (
		clk         	   : in std_ulogic;
		rst 	           : in std_ulogic;
		base_period        : in std_ulogic;
		half_base_period   : out std_ulogic;
		x2_base_period     : out std_ulogic;
		fourth_base_period : out std_ulogic;
		eight_base_period  : out std_ulogic;
		x4_base_period     : out std_ulogic;
	);
end entity clk_gen;

architecture clock in clk_gen is

	begin

		new_rate : process (base_period)
			begin
				if(rst = '0') then
					half_base_period <= '0'; 
					x2_base_period <= '0';
					fourth_base_period <= '0'; 
					eight_base_period <= '0';
					x4_base_period <= '0';
				elsif(clk'event and clk = '1') then
					half_base_period <= base_period ror 2; 
					x2_base_period <= base_period rol 2;
					fourth_base_period <= base_period ror 4; 
					eight_base_period <= base_period ror 8;
					x4_base_period <= base_period rol 4;
				end if;
		end process;
end architecture clock;