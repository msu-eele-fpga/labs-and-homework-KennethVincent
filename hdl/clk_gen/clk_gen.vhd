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
		base_period        : in unsigned;
		pttn0_period       : out unsigned;
		pttn1_period       : out unsigned;
		pttn2_period       : out unsigned;
		pttn3_period       : out unsigned;
		pttn4_period       : out unsigned;
	);
end entity clk_gen;

architecture clock in clk_gen is
	signal count : Integer := '0';
	signal clk_freq : Integer := '50000000';
	half_base_period <= base_period ror 1; 
	x2_base_period <= base_period rol 1;
	fourth_base_period <= base_period ror 2; 
	eight_base_period <= base_period ror 4;
	x4_base_period <= base_period rol 2;
	signal Integer : period_0 := clk_freq * half_base_period;
	signal Integer : period_1 := clk_freq * x2_base_period;
	signal Integer : period_2 := clk_freq * fourth_base_period;
	signal Integer : period_3 := clk_freq * eight_base_period;
	signal Integer : period_4 := clk_freq * x4_base_period;

	begin
		clk_counter0 : process (clk, rst)
			begin
				if(rst = '0') then
					count = '0';
				elsif(clk'event and clk = '1') then
					if(count = (half_base_period ror 1)) then
						pttn0_period <= '1';
						count <= 0;
					else
						pttn0_period <= 0;
						count <= count + 1;
					end if;
				end if;

		end process;

		clk_counter1 : process (clk, rst)
			begin
				if(rst = '0') then
					count = '0';
				elsif(clk'event and clk = '1') then
					if(count = (x2_base_period ror 1)) then
						pttn0_period <= '1';
						count <= 0;
					else
						pttn0_period <= 0;
						count <= count + 1;
					end if;
				end if;

		end process;

		clk_counter2 : process (clk, rst)
			begin
				if(rst = '0') then
					count = '0';
				elsif(clk'event and clk = '1') then
					if(count = (fourth_base_period ror 1)) then
						pttn0_period <= '1';
						count <= 0;
					else
						pttn0_period <= 0;
						count <= count + 1;
					end if;
				end if;

		end process;

		clk_counter3 : process (clk, rst)
			begin
				if(rst = '0') then
					count = '0';
				elsif(clk'event and clk = '1') then
					if(count = (eight_base_period ror 1)) then
						pttn0_period <= '1';
						count <= 0;
					else
						pttn0_period <= 0;
						count <= count + 1;
					end if;
				end if;

		end process;

		clk_counter4 : process (clk, rst)
			begin
				if(rst = '0') then
					count = '0';
				elsif(clk'event and clk = '1') then
					if(count = (x4_base_period ror 1)) then
						pttn0_period <= '1';
						count <= 0;
					else
						pttn0_period <= 0;
						count <= count + 1;
					end if;
				end if;

		end process;
		
end architecture clock;