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

	count : Integer;
	
	begin

		pattern0 : process (base_period)
			begin
				if(rst = '0') then
					count <= '0';
					pttn0 <= '0';
				elsif(half_base_period'event and half_base_period = '1') then
					if(count = '0' or count = '7') then
						count <= '0';
						pttn0 <= '64';
					else
						count <= count + 1;
						pttn0 <= pttn0 srl 1;
					end if;
				end if;
		end process;

		pattern1 : process (base_period)
			begin
				if(rst = '0') then
					count <= '0';
					pttn1 <= '0';
				elsif(x2_base_period'event and x2_base_period = '1') then
					if(count = '0' or count = '7') then
						count <= '0';
						pttn1 <= '3';
					else
						count <= count + 1;
						pttn1 <= pttn1 sll 1;
					end if;
				end if;
		end process;

		pattern2 : process (rst, fourth_base_period)
			begin
				if(rst = '0') then
					count <= '0';
					pttn2 <= '0';
				elsif(fourth_base_period'event and fourth_base_period = '1') then
					if(count = '0' or count = '7') then
						count <= '0';
						pttn2 <= '64';
					else
						count <= count + 1;
						pttn2 <= pttn2 ror 1;
					end if;
				end if;
		end process;

		pattern3 : process (rst, eight_base_period)
			begin
				if(rst = '0') then
					count <= '0';
					pttn3 <= '0';
				elsif(eight_base_period'event and eight_base_period = '1') then
					if(count = '0' or count = '7') then
						count <= '0';
						pttn3 <= '1';
					else
						count <= count + 1;
						pttn3 <= pttn3 rol 1;
					end if;
				end if;
		end process;

		pattern4 : process (rst, eight_base_period)
			begin
				if(rst = '0') then
					count <= '0';
					pttn4 <= '0';
				elsif(x4_base_period'event and x4_base_period = '1') then
					if(count = '2') then
						count <= '0';
						pttn4 <= '8';
					elsif(count = '1') then
						count <= count + 1;
						pttn4 <= '20';
					else
						count <= count + 1;
						pttn4 <= '129';
					end if;
				end if;
		end process;
end architecture Patterns;