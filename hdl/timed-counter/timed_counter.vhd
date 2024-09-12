library ieee;
use ieee.std_logic_1164.all;

entity timed_counter is 
	generic(
		clk_period : time; -- lets you specify how long the timer should count before asserting its done output.
		count_time : time -- lets you specify the system?s clock period. In our case, the FPGA?s clock has a period of 20 ns.
	);
	port (
		clk           : in  std_ulogic;
		enable        : in  boolean;
		done          : out boolean);
end entity timed_counter;

architecture arch_timed_counter of timed_counter is
	constant COUNTER_LIMIT : integer := count_time / clk_period;
	signal count : integer;

	begin
		COUNTER : process (clk)
			begin
				if (rising_edge(clk)) then
					if (enable) then
						if (count = COUNTER_LIMIT) then
							count <= 0;
							done <= true;
						else
							done <= false;
							count <= count + 1;
						end if;
					else
						count <= 0;
						done <= false;
					end if;
				end if;
		end process;

end architecture arch_timed_counter;
