library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;


entity debouncer is
	generic (
		clk_period : time := 20 ns;
		debounce_time : time
	);
	port (
		clk : in std_ulogic;
		rst : in std_ulogic;
		input : in std_ulogic;
		debounced : out std_ulogic
	);
end entity debouncer;


architecture debounce of debouncer is
	signal clock_time : Integer := debounce_time/clk_period;
	signal count : Integer;
	signal count_enable : boolean := false;
	signal count_done : boolean := false;

	type	State_Type is (start, pressed, b_wait, released);
	signal	current_state, next_state : State_Type;

	begin
---------------------------------------------------------------------------------------------
		Counter : process(clk, count)
			begin
				if(count_enable = true) then
					if(count = clock_time) then
						count_done <= true;
						--count_enable <= false;
					else
						count <= count + 1;
					end if;
				else
					count_done <= false;
				end if;
		end process;		
---------------------------------------------------------------------------------------------
		STATE_MEMORY : process (clk, rst)
			begin
				if(rst = '0') then
					current_state <= start;
				elsif(clk'event and clk = '1') then
					current_state <= next_state;
				end if;
		end process;
---------------------------------------------------------------------------------------------
		NEXT_STATE_LOGIC : process (current_state, input)
			begin
				case (current_state) is
					when start => if(input = '1') then
							next_state <= pressed;
						      else
							next_state <= start;
						      end if;
					when pressed => if(count_done = true) then
							 next_state <= b_wait;
							end if;
					when b_wait => if(input = '0') then
							next_state <= released;
						      else
							next_state <= b_wait;
						      end if;
					when released => if(count_done = true) then
							  next_state <= start;
							end if;
					when others => next_state <= start; 
				end case;
		end process;
---------------------------------------------------------------------------------------------
		OUTPUT_LOGIC : process (current_state, input)
			begin
				case (current_state) is
					when pressed => debounced <= '1'; count_enable <= true;
					when b_wait => debounced <= '1'; count_enable <= false;
					when released => debounced <= '0'; count_enable <= true;
					when others => debounced <= '0'; count_enable <= false;
				end case;
		end process;
end architecture debounce;