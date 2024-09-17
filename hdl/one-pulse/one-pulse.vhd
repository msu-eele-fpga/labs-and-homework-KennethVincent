library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity one_pulse is
	port (
		clk : in std_ulogic;
		rst : in std_ulogic;
		input : in std_ulogic;
		pulse : out std_ulogic
	);
end entity one_pulse;

architecture pulse of one_pulse is
	type	State_Type is (p_wait, p_high, p_low);
	signal	current_state, next_state : State_Type;

	begin
---------------------------------------------------------------------------------------------
		STATE_MEMORY : process (clk, rst)
			begin
				if(rst = '0') then
					current_state <= p_wait;
				elsif(clk'event and clk = '1') then
					current_state <= next_state;
				end if;
		end process;
---------------------------------------------------------------------------------------------
		NEXT_STATE_LOGIC : process (current_state, input)
			begin
				case (current_state) is
					when p_wait => if(input = '1') then
							next_state <= p_high;
						       else
							next_state <= p_wait;
						       end if;
					when p_high => if(input = '1') then
							next_state <= p_low;
						       else
							next_state <= p_high;
						       end if;
					when p_low => if(input = '1') then
							next_state <= p_low;
						       else
							next_state <= p_wait;
						       end if;
					when others => next_state <= p_wait; 
				end case;
		end process;
---------------------------------------------------------------------------------------------
		OUTPUT_LOGIC : process (current_state, input)
			begin
				case (current_state) is
					when p_wait => pulse <= '0';
					when p_high => pulse <= '1';
					when p_low => pulse <= '1';
					when others =>  pulse <= '0';
				end case;
		end process;

end architecture pulse;