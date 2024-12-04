library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_controller is
	generic (
		CLK_PERIOD 	: time 	  := 20 ns
	);
	port (
		clk : in std_logic;
		rst : in std_logic;
		-- PWM repetition period in milliseconds;
		-- datatype (W.F) is individually assigned
		period : in unsigned(25 downto 0);
		-- PWM duty cycle between [0 1]; out-of-range values are hard-limited
		-- datatype (W.F) is individually assigned
		duty_cycle : in unsigned( 14 downto 0);
		output : out std_logic
	);
end entity pwm_controller;


architecture PWM of pwm_controller is
	signal count : Integer := 0;
	signal clk_freq : unsigned(25 downto 0) := to_unsigned(50000,26);
	-- 50 Mhz "10111110101111000010000000"
	-- TEST "00000000000000000111110100"
	signal p_clk_temp : std_ulogic := '1';
	signal period_base : unsigned(51 downto 0);
	signal trunk  : unsigned(31 downto 0);
	signal trunk2  : unsigned(32 downto 0);
	signal trunkp : unsigned(30 downto 0);
	signal trunkp2 : unsigned(31 downto 0);
	signal high_time : unsigned(66 downto 0);
	
	begin
	period_base <=  clk_freq * period;
	high_time <= duty_cycle * period_base;
	trunk <= high_time(66 downto 35);
	trunk2 <= trunk & "0";
	trunkp <= period_base(51 downto 21);
	trunkp2 <= trunkp & "0";
	clk_counter : process (clk, rst)
			begin
				if(rst = '0') then
					count <= 0;
				elsif(clk'event and clk = '1') then
					if(count < trunk2) then
						p_clk_temp <= '1';
						count <= count + 1;
					elsif(count < trunkp2) then
						p_clk_temp <= '0';
						count <= count + 1;
					else
						count <= 0;
					end if;
				end if;
		end process;
		output <= p_clk_temp;

end architecture PWM;