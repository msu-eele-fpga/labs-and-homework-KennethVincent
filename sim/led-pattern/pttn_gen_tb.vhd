library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use IEEE.numeric_std_unsigned.all;

entity pttn_gen_tb is
end entity pttn_gen_tb;

architecture testbench of pttn_gen_tb is

  constant CLK_PERIOD : time := 10 ns;

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
			pttnb		   : out std_ulogic_vector(6 downto 0);
			pttn0		   : out std_ulogic_vector(6 downto 0);
			pttn1		   : out std_ulogic_vector(6 downto 0);
			pttn2		   : out std_ulogic_vector(6 downto 0);
			pttn3		   : out std_ulogic_vector(6 downto 0);
			pttn4		   : out std_ulogic_vector(6 downto 0)
		);
	end component pttn_gen;

  signal clk_tb                  : std_ulogic := '0';
  signal rst_tb                  : std_ulogic := '1';
  signal base_period_tb		 : std_ulogic := '1';
  signal half_base_period_tb     : std_ulogic := '1';
  signal x2_base_period_tb       : std_ulogic := '1';
  signal fourth_base_period_tb   : std_ulogic := '1';
  signal eight_base_period_tb    : std_ulogic := '1';
  signal x4_base_period_tb       : std_ulogic := '1';
  signal pttnb_tb		 : std_ulogic_vector(6 downto 0);
  signal pttn0_tb		 : std_ulogic_vector(6 downto 0);
  signal pttn1_tb		 : std_ulogic_vector(6 downto 0);
  signal pttn2_tb		 : std_ulogic_vector(6 downto 0);
  signal pttn3_tb		 : std_ulogic_vector(6 downto 0);
  signal pttn4_tb		 : std_ulogic_vector(6 downto 0);

begin

  dut : component pttn_gen
  port map(
	clk => clk_tb,
	rst => rst_tb,
	base_period => base_period_tb,
	half_base_period => half_base_period_tb,
	x2_base_period => x2_base_period_tb,
	fourth_base_period => fourth_base_period_tb,
	eight_base_period => eight_base_period_tb,
	x4_base_period => x4_base_period_tb,
	pttnb => pttnb_tb,
	pttn0 => pttn0_tb,
	pttn1 => pttn1_tb,
	pttn2 => pttn2_tb,
	pttn3 => pttn3_tb,
	pttn4 => pttn4_tb
  );

  pttn_make : process is
  begin

    clk_tb <= not clk_tb;
    wait for CLK_PERIOD / 2;

  end process pttn_make;

  base_period_tb 	<= not base_period_tb after 1 ms;
  half_base_period_tb 	<= not half_base_period_tb after 0.5 ms;
  x2_base_period_tb 	<= not x2_base_period_tb after 2 ms;
  fourth_base_period_tb <= not fourth_base_period_tb after 0.25 ms;
  eight_base_period_tb  <= not eight_base_period_tb after 0.125 ms;
  x4_base_period_tb	<= not  x4_base_period_tb after 4 ms;



end architecture testbench;
