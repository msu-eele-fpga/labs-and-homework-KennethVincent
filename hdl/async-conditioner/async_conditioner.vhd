library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity aysnc_conditioner is
	port (
		clk : in std_ulogic;
		rst : in std_ulogic;
		async : in std_ulogic;
		sync : out std_ulogic
	);
end entity aysnc_conditioner;

architecture async of aysnc_conditioner is


	component debouncer is
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
	end component;



	component synchronizer is
		port (
			clk : in std_ulogic;
			async : in std_ulogic;
			sync : out std_ulogic
		);
	end component;


	component one_pulse is
		port (
			clk : in std_ulogic;
			rst : in std_ulogic;
			input : in std_ulogic;
			pulse : out std_ulogic
		);
	end component;

	signal input, pulse, debounced : std_ulogic;
	signal synchronizer_out : std_ulogic;
	signal debouncer_out : std_ulogic;

	begin

	U1 : synchronizer port map (clk => clk, async => async, sync => synchronizer_out);
	U2 : debouncer generic map(debounce_time => 100 ms)
		       port map (clk => clk, rst => rst, input => synchronizer_out, debounced => debouncer_out);
	U3 : one_pulse port map (clk => clk, rst => rst, input => debouncer_out, pulse => sync);

end architecture async;
