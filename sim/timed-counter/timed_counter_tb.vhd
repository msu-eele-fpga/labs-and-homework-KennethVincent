library ieee;
use ieee.std_logic_1164.all;
use work.print_pkg.all;
use work.assert_pkg.all;
use work.tb_pkg.all;

entity timed_counter_tb is 
end entity timed_counter_tb;

architecture testbench of timed_counter_tb is

	component timed_counter is
		generic (
			clk_period : time;
			count_time : time
		);
		port (
			clk :    in std_ulogic;
			enable : in boolean;
			done :   out boolean
		);
	end component timed_counter;

	signal clk_tb : std_ulogic := '0';
	signal clk_2_tb : std_ulogic := '0';

	signal enable_100ns_tb : boolean := false;
	signal done_100ns_tb   : boolean ;

	signal enable_500ns_tb : boolean := false;
	signal done_500ns_tb   : boolean ;

	constant HUNDRED_NS : time := 100 ns;

	constant five_100 : time := 500 ns;

	procedure predict_counter_done (
		constant count_time : in time;
		signal enable  	    : in boolean;
		signal done	    : in boolean;
		constant count_iter : in natural
	) is
		begin
			if enable then
				if count_iter < (count_time / CLK_PERIOD) then
					assert_false(done, "counter not done");
				else
					assert_true(done, "counter is done");
					print("counter is done");
				end if;
			else
				assert_false(done, "counter not enable");
			end if;
	end procedure predict_counter_done;

begin

	dut_100ns_counter : component timed_counter
		generic map (
			clk_period => CLK_PERIOD,
			count_time => HUNDRED_NS
		)
		port map (
			clk => clk_tb,
			enable => enable_100ns_tb,
			done => done_100ns_tb
		);

		clk_tb <= not clk_tb after CLK_PERIOD / 2;

		stimuli_and_checker : process is
			begin
				-- test 100 ns timer when it's enabled
				print("testing 100 ns timer: enabled");
				wait_for_clock_edge(clk_tb);
				enable_100ns_tb <= true;

				-- loop for the number of clock cycles that is equal to the timer's period
				for i in 0 to (HUNDRED_NS / CLK_PERIOD) loop
					wait_for_clock_edge(clk_tb);
					predict_counter_done(HUNDRED_NS, enable_100ns_tb, done_100ns_tb, i);

				end loop;
				
				-- add other test cases here

				print("testing 100 ns timer twice: disabled");
				--test case two
				wait_for_clock_edge(clk_tb);
				enable_100ns_tb <= false;
				for i in 0 to (2*(HUNDRED_NS / CLK_PERIOD)) loop
					wait_for_clock_edge(clk_tb);
					predict_counter_done(HUNDRED_NS, enable_100ns_tb, done_100ns_tb, i);

				end loop;

				--test case three
				print("testing 100 ns timer 4 times: enabled");
				wait_for_clock_edge(clk_tb);
				enable_100ns_tb <= true;
				for j in 0 to 4 loop
					for i in 0 to ((HUNDRED_NS / CLK_PERIOD)) loop
						wait_for_clock_edge(clk_tb);
						predict_counter_done(HUNDRED_NS, enable_100ns_tb, done_100ns_tb, i);

					end loop;
				end loop;
				-- testbench is done :)
				--std.env.finish;
			wait;
		end process stimuli_and_checker;

	dut_500ns_counter : component timed_counter
		generic map (
			clk_period => CLK_PERIOD,
			count_time => five_100
		)
		port map (
			clk => clk_tb,
			enable => enable_500ns_tb,
			done => done_500ns_tb
		);

		clk_2_tb <= not clk_2_tb after CLK_PERIOD / 2;

		stimuli_and_checker_2 : process is
			begin
				-- test 100 ns timer when it's enabled
				print("testing 500 ns timer: enabled");
				wait_for_clock_edge(clk_2_tb);
				enable_500ns_tb <= true;

				-- loop for the number of clock cycles that is equal to the timer's period
				for i in 0 to (five_100 / CLK_PERIOD) loop
					wait_for_clock_edge(clk_2_tb);
					predict_counter_done(five_100, enable_500ns_tb, done_500ns_tb, i);

				end loop;
				
				-- add other test cases here

				print("testing 100 ns timer twice: disabled");
				--test case two
				wait_for_clock_edge(clk_2_tb);
				enable_500ns_tb <= false;
				for i in 0 to (2*(five_100 / CLK_PERIOD)) loop
					wait_for_clock_edge(clk_2_tb);
					predict_counter_done(five_100, enable_500ns_tb, done_500ns_tb, i);

				end loop;

				--test case three
				print("testing 500 ns timer 4 times: enabled");
				wait_for_clock_edge(clk_2_tb);
				enable_500ns_tb <= true;
				for j in 0 to 4 loop
					for i in 0 to ((five_100 / CLK_PERIOD)) loop
						wait_for_clock_edge(clk_2_tb);
						predict_counter_done(five_100, enable_500ns_tb, done_500ns_tb, i);

					end loop;
				end loop;
				-- testbench is done :)
				std.env.finish;

		end process stimuli_and_checker_2;

end architecture; 