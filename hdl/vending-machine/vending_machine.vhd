library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity vending_machine is
	port(
	    	clk	: in	std_ulogic;
		rst	: in	std_ulogic;
		nickel	: in	std_ulogic;
		dime	: out	std_ulogic;
		dispense: out	std_ulogic;
		amount	: out	natural range 0 to 15
	);
end entity vending_machine;



architecture arch_vending_machine of vending_machine is
	type State_type is (cent_0, cent_5, cent_10, cent_15);
	signal current_state, next_state : State_Type;


	begin
----------------------------------------------------------------------
		STATE_MEMORY : process (clk, rst)
			begin
				if (rst = '0') then
					current_state <= cent_0;
				elsif (clk'event and clk='1') then
					current_state <= next_state;
				end if;
		end process;

--------------------------------------------------------------------------------------------------------------------------------
		NEXT_STATE_LOGIC : process ( current_state, nickel, dime)
			begin
				case (current_state) is
					when cent_0 => if (nickel = '1' and dime = '0') then
							next_state <= cent_5;
						       elsif (nickel = '0' and dime = '1') then
							next_state <= cent_10;
						       else
							next_state <= cent_0;
						       end if;
					when cent_5 => if (nickel = '1' and dime = '0') then
						        next_state <= cent_10;
						       elsif (nickel = '0' and dime = '1') then
						        next_state <= cent_15;
						       else
						        next_state <= cent_5;
						       end if;
					when cent_10 => if (nickel = '1' or dime = '1') then
						         next_state <= cent_15;
							else
							 next_state <= cent_10;
							end if;
					when cent_15 => next_state <= cent_0;
					when others => next_state <= cent_0;
				end case;
		end process;

--------------------------------------------------------------------------------------------------------------------------------
		OUTPUT_LOGIC : process ( current_state, nickel, dime)
			begin
				case (current_state) is
					when cent_0 => dispense <= '0';  amount <= 0000000000000000;
					when cent_5 => dispense <= '0';  amount <= 0000000000000101;
					when cent_10 => dispense <= '0'; amount <= 0000000000001010;
					when cent_15 => dispense <= '1'; amount <= 0000000000001111;
					when others => dispense <= '0';  amount <= 0000000000000000;
				end case;
		end process;

end architecture;
