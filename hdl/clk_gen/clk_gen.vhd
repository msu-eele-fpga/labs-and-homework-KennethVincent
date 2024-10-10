library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
--use work.assert_pkg.all;
--use work.print_pkg.all;
--use work.tb_pkg.all;


entity clk_gen is
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
end entity clk_gen;

architecture clock of clk_gen is
	--signal pttnb_clk : std_ulogic;
	signal trunk  : unsigned(29 downto 0);
	signal countb : Integer := 0;
	signal count0 : Integer := 0;
	signal count1 : Integer := 0;
	signal count2 : Integer := 0;
	signal count3 : Integer := 0;
	signal count4 : Integer := 0;
	signal clk_freq : unsigned(25 downto 0) := "10111110101111000010000000";
	-- 50 Mhz "10111110101111000010000000"
	-- TEST "00000000000000000111110100"
	signal period_base : unsigned(33 downto 0);
	signal half_base_period : unsigned(29 downto 0); 
	signal x2_base_period : unsigned(29 downto 0); 
	signal fourth_base_period : unsigned(29 downto 0); 
	signal eight_base_period : unsigned(29 downto 0); 
	signal x4_base_period : unsigned(29 downto 0); 

	signal pB_clk_temp : std_ulogic := '1';
	signal p0_clk_temp : std_ulogic := '1';
	signal p1_clk_temp : std_ulogic := '1';
	signal p2_clk_temp : std_ulogic := '1';
	signal p3_clk_temp : std_ulogic := '1';
	signal p4_clk_temp : std_ulogic := '1';

	begin

		period_base <=  clk_freq * base_period;
		trunk <= period_base(33 downto 4);

		half_base_period <= shift_right(trunk, 1);
		x2_base_period <=  shift_left(trunk ,1);
		fourth_base_period <= shift_right(trunk ,2);
		eight_base_period <= shift_right(trunk ,3);
		x4_base_period <= shift_left(trunk ,2);
		
		clk_counterB : process (clk, rst)
			begin
				if(rst = '0') then
					countb <= 0;
				elsif(clk'event and clk = '1') then
					if(countb = shift_right(trunk, 1)) then
						pb_clk_temp <= not pb_clk_temp;
						countb <= 0;
					else
						countb <= countb + 1;
						pb_clk_temp <= pb_clk_temp;
					end if;
				end if;
		end process;
		pttnb_clk <= pb_clk_temp;

		clk_counter0 : process (clk, rst)
			begin
				if(rst = '0') then
					count0 <= 0;
				elsif(clk'event and clk = '1') then
					if(count0 = shift_right(half_base_period, 1)) then
						p0_clk_temp <= not p0_clk_temp;
						count0 <= 0;
					else
						count0 <= count0 + 1;
						p0_clk_temp <= p0_clk_temp;
					end if;
				end if;
		end process;
		pttn0_clk <= p0_clk_temp;

		clk_counter1 : process (clk, rst)
			begin
				if(rst = '0') then
					count1 <= 0;
				elsif(clk'event and clk = '1') then
					if(count1 = shift_right(fourth_base_period, 1)) then
						p1_clk_temp <= not p1_clk_temp;
						count1 <= 0;
					else
						count1 <= count1 + 1;
						p1_clk_temp <= p1_clk_temp;
					end if;
				end if;

		end process;
		pttn1_clk <= p1_clk_temp;

		clk_counter2 : process (clk, rst)
			begin
				if(rst = '0') then
					count2 <= 0;
				elsif(clk'event and clk = '1') then
					if(count2 = shift_right(x2_base_period, 1)) then
						p2_clk_temp <= not p2_clk_temp;
						count2 <= 0;
					else
						count2 <= count2 + 1;
						p2_clk_temp <= p2_clk_temp;
					end if;
				end if;

		end process;
		pttn2_clk <= p2_clk_temp;

		clk_counter3 : process (clk, rst)
			begin
				if(rst = '0') then
					count3 <= 0;
				elsif(clk'event and clk = '1') then
					if(count3 = shift_right(eight_base_period, 1)) then
						p3_clk_temp <= not p3_clk_temp;
						count3 <= 0;
					else
						count3 <= count3 + 1;
						p3_clk_temp <= p3_clk_temp;
					end if;
				end if;

		end process;
		pttn3_clk <= p3_clk_temp;

		clk_counter4 : process (clk, rst)
			begin
				if(rst = '0') then
					count4 <= 0;
				elsif(clk'event and clk = '1') then
					if(count4 = shift_right(x4_base_period, 1)) then
						p4_clk_temp <= not p4_clk_temp;
						count4 <= 0;
					else
						count4 <= count4 + 1;
						p4_clk_temp <= p4_clk_temp;
					end if;
				end if;

		end process;
		pttn4_clk <= p4_clk_temp;
		
end architecture clock;