library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use IEEE.numeric_std_unsigned.all;

entity clk_gen_tb is
end entity clk_gen_tb;

architecture testbench of clk_gen_tb is

  constant CLK_PERIOD : time := 10 ns;

	component clk_gen is
		port (
			clk         	: in std_ulogic;
			rst 	        : in std_ulogic;
			base_period     : in unsigned(7 downto 0);
			pttnb_clk	: out std_ulogic;
			pttn0_clk        : out std_ulogic;
			pttn1_clk       : out std_ulogic;
			pttn2_clk        : out std_ulogic;
			pttn3_clk        : out std_ulogic;
			pttn4_clk        : out std_ulogic
		);
	end component clk_gen;

  signal clk_tb                  : std_ulogic := '0';
  signal rst_tb                  : std_ulogic := '1';
  signal base_period_tb          : unsigned(7 downto 0) := "00000000";
  signal pttnb_clk_tb            : std_ulogic := '0';
  signal pttn0_clk_tb            : std_ulogic := '0';
  signal pttn1_clk_tb            : std_ulogic := '0';
  signal pttn2_clk_tb            : std_ulogic := '0';
  signal pttn3_clk_tb            : std_ulogic := '0';
  signal pttn4_clk_tb            : std_ulogic := '0';


begin

  dut : component clk_gen
  port map(
	clk => clk_tb,
	rst => rst_tb,
	base_period => base_period_tb,
	pttnb_clk => pttnb_clk_tb,
	pttn0_clk => pttn0_clk_tb,
	pttn1_clk => pttn1_clk_tb,
	pttn2_clk => pttn2_clk_tb,
	pttn3_clk => pttn3_clk_tb,
	pttn4_clk => pttn4_clk_tb
  );

  clk_make : process is
  begin

    clk_tb <= not clk_tb;
    wait for CLK_PERIOD / 2;

  end process clk_make;

    base_period_tb <= "00000001";

end architecture testbench;
