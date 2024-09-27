library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;


entity pttn_gen is
	port (
		clk         	   : in std_ulogic;
		rst 	           : in std_ulogic;
		half_base_period   : in std_ulogic;
		x2_base_period     : in std_ulogic;
		fourth_base_period : in std_ulogic;
		eight_base_period  : in std_ulogic;
		x4_base_period     : in std_ulogic;
		pttn0		   : out std_ulogic_vector(6 downto 0);
		pttn1		   : out std_ulogic_vector(6 downto 0);
		pttn2		   : out std_ulogic_vector(6 downto 0);
		pttn3		   : out std_ulogic_vector(6 downto 0);
		pttn4		   : out std_ulogic_vector(6 downto 0);
	);
end entity pttn_gen;

architecture Patterns in pttn_gen is

	begin

		pattern0 : process (base_period)
			begin
				if(rst = '0') then
				elsif(clk'event and clk = '1') then

				end if;
		end process;

		pattern1 : process (base_period)
			begin
				if(rst = '0') then
				elsif(clk'event and clk = '1') then

				end if;
		end process;

		pattern2 : process (base_period)
			begin
				if(rst = '0') then
				elsif(clk'event and clk = '1') then

				end if;
		end process;

		pattern3 : process (base_period)
			begin
				if(rst = '0') then
				elsif(clk'event and clk = '1') then

				end if;
		end process;

		pattern4 : process (base_period)
			begin
				if(rst = '0') then
				elsif(clk'event and clk = '1') then

				end if;
		end process;
end architecture Patterns;