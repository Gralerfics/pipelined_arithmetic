library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;


entity tb_pipelined_ripple_adder is
end entity;


architecture defaults of tb_pipelined_ripple_adder is
    component pipelined_ripple_adder is
        generic (
            DATA_WIDTH: integer
        );
        port (
            clock, reset, enable: in std_logic;
            flush: in std_logic;
            a, b: in std_logic_vector(DATA_WIDTH - 1 downto 0);
            c_in: in std_logic;
            valid: out std_logic;
            s: out std_logic_vector(DATA_WIDTH - 1 downto 0);
            c_out: out std_logic
        );
    end component;

    for UUT: pipelined_ripple_adder use entity work.pipelined_ripple_adder(defaults);

    constant PERIOD: time := 10 ns;
    constant DATA_WIDTH: integer := 5;

    signal clock, reset, enable: std_logic;
    signal flush: std_logic;
    signal a, b: integer; -- std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal c_in: std_logic;
    signal valid: std_logic;
    signal s: std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal c_out: std_logic;
begin
    -- UUT
    UUT: pipelined_ripple_adder
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            clock => clock,
            reset => reset,
            enable => enable,
            flush => flush,
            a => conv_std_logic_vector(a, DATA_WIDTH),
            b => conv_std_logic_vector(b, DATA_WIDTH),
            c_in => c_in,
            valid => valid,
            s => s,
            c_out => c_out
        );
    
    -- clock
    process is
    begin
        clock <= '0';
        wait for PERIOD / 2;
        clock <= '1';
        wait for PERIOD / 2;
    end process;

    -- reset
    reset <= '1', '0' after PERIOD;

    -- enable
    enable <= '1';

    -- flush
    flush <= '0', '1' after 3 * PERIOD, '0' after 4 * PERIOD;

    -- operands
    a <= 0, 12 after PERIOD, -5 after 2 * PERIOD, -12 after 3 * PERIOD, 8 after 4 * PERIOD, 0 after 5 * PERIOD;
    b <= 0, 3 after PERIOD, 5 after 2 * PERIOD, -8 after 3 * PERIOD, -14 after 4 * PERIOD, 0 after 5 * PERIOD;
    c_in <= '0';
end architecture;