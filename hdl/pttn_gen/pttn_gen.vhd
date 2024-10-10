library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
--use work.assert_pkg.all;
--use work.print_pkg.all;
--use work.tb_pkg.all;


entity pttn_gen is
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
end entity pttn_gen;

architecture Patterns of pttn_gen is
	signal temp1  : std_ulogic_vector(6 downto 0) := "1000000";
	signal temp2  : std_ulogic_vector(6 downto 0) := "0000011";
	signal temp3  : std_ulogic_vector(6 downto 0) := "0000000";
	signal temp4  : std_ulogic_vector(6 downto 0) := "1111111";
	signal countb : Integer := 0;
	signal count0 : Integer := 0;
	signal count1 : Integer := 0;
	signal count2 : Integer := 0;
	signal count3 : Integer := 0;
	signal count4 : Integer := 0;
	begin

		patternb : process (rst, base_period)
			begin
				if(rst = '0') then
					pttnb <= '0';
					countb <= 0;
				elsif(rising_edge(base_period)) then
					if(countb = 0) then
						pttnb <= '0';
						countb <= 1;
					else
						pttnb <= '1';
						countb <= 0;
					end if;
				end if;
		end process;

		pattern0 : process (rst, half_base_period)
			begin
				if(rst = '0') then
					count0 <= 0;
					pttn0 <= "0000000";
				elsif(half_base_period'event and half_base_period = '1') then
					if(count0 = 7) then
						count0 <= 0;
						pttn0 <= "1000000";
						temp1 <= "1000000";
					else
						count0 <= count0 + 1;
						temp1 <= std_ulogic_vector(shift_right(unsigned(temp1), 1));
						pttn0 <= temp1;
					end if;
				end if;
		end process;

		pattern1 : process (rst, fourth_base_period)
			begin
				if(rst = '0') then
					count1 <= 0;
					pttn1 <= "0000000";
				elsif(rising_edge(fourth_base_period)) then
					if(count1 = 7) then
						count1 <= 0;
						pttn1 <= "0000011";
						temp2 <= "0000011";
					else
						count1 <= count1 + 1;
						temp2 <= std_ulogic_vector(shift_left(unsigned(temp2), 1));
						pttn1 <= temp2;
					end if;
				end if;
		end process;

		pattern2 : process (rst, x2_base_period)
			begin
				if(rst = '0') then
					count2 <= 0;
					pttn2 <= "0000000";
				elsif(x2_base_period'event and x2_base_period = '1') then
					if(count2 = 127) then
						count2 <= 0;
						pttn2 <= "0000000";
						temp3 <= "0000000";
					else
						count2 <= count2 + 1;
						temp3 <= std_ulogic_vector(to_unsigned(count2, temp3'length));
						pttn2 <= temp3;
					end if;
				end if;
		end process;

		pattern3 : process (rst, eight_base_period)
			begin
				if(rst = '0') then
					count3 <= 0;
					pttn3 <= "0000000";
				elsif(eight_base_period'event and eight_base_period = '1') then
					if(count3 = 0) then
						count3 <= 127;
						pttn3 <= "1111111";
						temp4 <= "1111111";
					else
						count3 <= count3 - 1;
						temp4 <= std_ulogic_vector(to_unsigned(count3, temp4'length));
						pttn3 <= temp4;
					end if;
				end if;
		end process;

		pattern4 : process (rst, x4_base_period)
			begin
				if(rst = '0') then
					count4 <= 0;
					pttn4 <= "0000000";
				elsif(x4_base_period'event and x4_base_period = '1') then
					if(count4 = 2) then
						count4 <= 0;
						pttn4 <= "0001000";
					elsif(count4 = 1) then
						count4 <= count4 + 1;
						pttn4 <= "0010100";
					else
						count4 <= count4 + 1;
						pttn4 <= "1000001";
					end if;
				end if;
		end process;
end architecture Patterns;