library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
--use work.assert_pkg.all;
--use work.print_pkg.all;
--use work.tb_pkg.all;

entity led_pattern is
	port(
	    	clk		: in	std_ulogic;
		rst		: in	std_ulogic;
		SW		: in	std_ulogic_vector(3 downto 0);
		PB		: in	std_ulogic;
		HPS_LED_control : in 	std_logic;
		SYS_CLKs_sec 	: in 	std_logic_vector(31 downto 0);
		Base_rate 	: in 	std_logic_vector(7 downto 0);
		LED_reg 	: in 	std_logic_vector(7 downto 0);
		LED 		: out 	std_logic_vector(7 downto 0)
	);
end entity led_pattern;


architecture LED of led_pattern is

	component timed_counter is 
	generic(
		clk_period : time; -- lets you specify how long the timer should count before asserting its done output.
		count_time : time -- lets you specify the system?s clock period. In our case, the FPGA?s clock has a period of 1 sec.
	);
	port (
		clk           : in  std_ulogic;
		enable        : in  boolean;
		done          : out boolean);
	end component;


	component aysnc_conditioner is
		port (
			clk : in std_ulogic;
			rst : in std_ulogic;
			async : in std_ulogic;
			sync : out std_ulogic
		);
	end component;

	component clk_gen is
		port (
			clk         	   : in std_ulogic;
			rst 	           : in std_ulogic;
			base_period        : in unsigned(7 downto 0);
			pttnb_clk	: out std_ulogic;
			pttn0_clk       : out std_ulogic;
			pttn1_clk       : out std_ulogic;
			pttn2_clk       : out std_ulogic;
			pttn3_clk       : out std_ulogic;
			pttn4_clk       : out std_ulogic
		);
	end component;

	component pttn_gen is
		port (
			clk         	   : in std_ulogic;
			rst 	           : in std_ulogic;
			base_period	   : in std_ulogic;
			half_base_period   : in std_ulogic;
			x2_base_period     : in std_ulogic;
			fourth_base_period : in std_ulogic;
			eight_base_period  : in std_ulogic;
			x4_base_period     : in std_ulogic;
			pttnb		   : out std_ulogic;
			pttn0		   : out std_ulogic_vector(6 downto 0);
			pttn1		   : out std_ulogic_vector(6 downto 0);
			pttn2		   : out std_ulogic_vector(6 downto 0);
			pttn3		   : out std_ulogic_vector(6 downto 0);
			pttn4		   : out std_ulogic_vector(6 downto 0)
		);
	end component;

	--input for timed counter
	signal enable : boolean;

	-- output for timed counter	
	signal done : boolean;
	
	-- output from async
	signal sync_out    : std_ulogic;

	--output from clock generator
	signal clk_gen_outb : std_ulogic;
	signal clk_gen_out0 : std_ulogic;
	signal clk_gen_out1 : std_ulogic;
	signal clk_gen_out2 : std_ulogic;
	signal clk_gen_out3 : std_ulogic;
	signal clk_gen_out4 : std_ulogic;

	--output for pattern generator
	signal patternb : std_ulogic;
	signal pattern0 : std_ulogic_vector(6 downto 0);
	signal pattern1 : std_ulogic_vector(6 downto 0);
	signal pattern2 : std_ulogic_vector(6 downto 0);
	signal pattern3 : std_ulogic_vector(6 downto 0);
	signal pattern4 : std_ulogic_vector(6 downto 0);
	
	-- output for the led FSM
	signal fsm_output : std_ulogic_vector(7 downto 0);

	-- for the fsm
	type State_type is (s_0, display, s_1, s_2, s_3, s_4);
	signal current_state, next_state, prev_state : State_Type;


	begin
		U1 : aysnc_conditioner  port map(clk => clk, rst => rst,async => PB, sync => sync_out);

		U2 : clk_gen 		port map(clk => clk, rst => rst, base_period => unsigned(base_rate), pttnb_clk => clk_gen_outb,
						 pttn0_clk => clk_gen_out0, pttn1_clk => clk_gen_out1, pttn2_clk => clk_gen_out2, pttn3_clk => clk_gen_out3,
						 pttn4_clk => clk_gen_out4);

		U3 : pttn_gen 		port map(clk => clk, rst => rst, base_period => clk_gen_outb, half_base_period => clk_gen_out0,
						 x2_base_period => clk_gen_out1, fourth_base_period => clk_gen_out2,
						 eight_base_period =>  clk_gen_out3, x4_base_period => clk_gen_out4, 
						 pttnb => patternb, pttn0 => pattern0, pttn1 => pattern1, pttn2 => pattern2, pttn3 => pattern3,
						 pttn4 => pattern4);

		U4 : timed_counter	generic map(clk_period => 20 ns, count_time => 1 sec)
					port map(clk => clk, enable => enable, done => done);
--------------------------------------------------------------------------------------------------------------------------------
		choice : process(HPS_LED_control, LED_reg, fsm_output)
			begin
				if (HPS_LED_control = '1') then
					LED <= LED_reg;
				else
					LED <= std_logic_vector(fsm_output);

				end if;
		end process;

--------------------------------------------------------------------------------------------------------------------------------
		STATE_MEMORY : process (clk, rst)
			begin
				if (rst = '0') then
					current_state <= s_0;
				elsif (clk'event and clk='1') then
					if(current_state /= display) then
						prev_state <= current_state;
					end if;
					current_state <= next_state;
				end if;
		end process;
--------------------------------------------------------------------------------------------------------------------------------
	NEXT_STATE_LOGIC : process (current_state, prev_state, SW, PB, done)
			begin
				case (current_state) is
					when s_0 => if(PB = '1') then
						     	next_state <= display;
						     else
							 next_state <= s_0;
						     end if;
					when s_1 => if(PB = '1') then
						     	next_state <= display;
						     else
							 next_state <= s_1;
						     end if;
					when s_2 => if(PB = '1') then
						     	next_state <= display;
						     else
							 next_state <= s_2;
						     end if;
					when s_3 => if(PB = '1') then
						     	next_state <= display;
						     else
							 next_state <= s_3;
						     end if;
					when s_4 => if(PB = '1') then
						     	next_state <= display;
						     else
							 next_state <= s_4;
						     end if;
					when display => if(done = false) then
								next_state <= display;
								else
									if(SW = "0000") then
										next_state <= s_0;
									elsif(SW = "0001") then
										next_state <= s_1;
									elsif(SW = "0010") then
										next_state <= s_2;
									elsif(SW = "0011") then
										next_state <= s_3;
									elsif(SW = "0100") then
										next_state <= s_4;
									else
										next_state <= prev_state;
									end if;
								end if;
					when others => next_state <= s_0;
				end case;
		end process;
--------------------------------------------------------------------------------------------------------------------------------
	OUTPUT_LOGIC : process (current_state,patternb, pattern0, pattern1, pattern2, pattern3, pattern4, fsm_output, SW)
		begin
			case (current_state) is
				when s_0 => fsm_output <= patternb & pattern0; enable <= false;
				when s_1 => fsm_output <= patternb & pattern1; enable <= false;
				when s_2 => fsm_output <= patternb & pattern2; enable <= false;
				when s_3 => fsm_output <= patternb & pattern3; enable <= false;
				when s_4 => fsm_output <= patternb & pattern4; enable <= false;
				when display => fsm_output <= patternb & "000" & SW; enable <= true;
				when others => fsm_output <= patternb & "0000000"; enable <= false;
			end case;
	end process;
end architecture;