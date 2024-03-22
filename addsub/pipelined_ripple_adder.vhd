-- +--------------------------------------------------------------------+
--   Pipelined Ripple Adder
-- +--------------------------------------------------------------------+
--   Description:
--       A pipelined ripple adder.
-- +--------------------------------------------------------------------+
--   Ports:
--       clock          clock signal
--       reset          asynchronous reset signal
--       enable         clock enable signal
--       flush          flush signal
--       a, b           operands
--       (c_in           carry in)
--       valid          valid signal
--       s              sum of a and b
--       (c_out          carry out)
--           Notice that c_out can not be simply concatenated with s 
--           when the result is parsed as a signed number. It is 
--           recommended to ignore c_out.
-- +--------------------------------------------------------------------+
--   Comments:
--       1. A template for a 3-stage pipeline is shown below:
--               | +--+     | +--+     | +--+     |
--           in -|>|  |--[]-|>|  |--[]-|>|  |--[]-|> out
--              .|.|  |  .. | |  |  .. | |  |  .. |
--           in -|>|  |--[]-|>|  |--[]-|>|  |--[]-|> out
--               | +--+     | +--+     | +--+     |
--               |  Stage0  |  Stage1  |  Stage2  |
--           ('[]' represents combinational logic; indexing starts at 0)
--       2. The number of stages in the pipeline equals ${WIDTH}.
-- +--------------------------------------------------------------------+
--   TODO:
--       1. create only necessary signals, not a whole matrix.
--       2. description.
-- +--------------------------------------------------------------------+

library IEEE;
use IEEE.std_logic_1164.all;


entity ${__TARGET_NAME__} is
    port (
        clock, reset, enable: in std_logic;
        flush: in std_logic;
        a, b: in std_logic_vector(${WIDTH} - 1 downto 0);
        -- c_in: in std_logic;
        valid: out std_logic;
        s: out std_logic_vector(${WIDTH} - 1 downto 0)
        -- c_out: out std_logic
    );
end entity;


architecture defaults of ${__TARGET_NAME__} is
    constant EOP: integer := ${WIDTH} - 1;

    type BitsArray is array (0 to EOP) of std_logic_vector(EOP downto 0);
    type BitArray is array (0 to EOP) of std_logic;

    signal valid_reg, valid_next: BitArray;
    signal a_reg, a_next, b_reg, b_next: BitsArray;
    signal s_reg, s_next: BitsArray;
    signal c_reg, c_next: BitArray;

    signal a_xor_b: BitArray;
begin
    process (clock, reset) is
    begin
        if reset = '1' then
            valid_reg <= (others => '0');
            a_reg <= (others => (others => '0'));
            b_reg <= (others => (others => '0'));
            s_reg <= (others => (others => '0'));
            c_reg <= (others => '0');
        elsif rising_edge(clock) and enable = '1' then
            valid_reg <= valid_next;
            a_reg <= a_next;
            b_reg <= b_next;
            s_reg <= s_next;
            c_reg <= c_next;
        end if;
    end process;
    
    -- validity
    valid_next(0) <= enable; -- Theoretically, this is always true because clock ticks only when enable is true
    valid_relations: for i in 1 to EOP generate
        valid_next(i) <= valid_reg(i - 1) when flush = '0' else '0';
    end generate;
    
    -- adder
    xor_relations: for i in 0 to EOP generate
        a_xor_b(i) <= a_reg(i)(i) xor b_reg(i)(i);
    end generate;
    
    s_next(0) <= (others => '0');
    sum_relations: for i in 1 to EOP generate
        s_next(i)(EOP downto i) <= (others => '0');
        s_next(i)(i - 1) <= a_xor_b(i - 1) xor c_reg(i - 1);
        sum_reservation: if i > 1 generate
            s_next(i)(i - 2 downto 0) <= s_reg(i - 1)(i - 2 downto 0);
        end generate;
    end generate;

    a_next(0) <= a;
    b_next(0) <= b;
    c_next(0) <= '0'; -- c_in;
    adder_relations: for i in 1 to EOP generate
        a_next(i) <= a_reg(i - 1);
        b_next(i) <= b_reg(i - 1);
        c_next(i) <= (a_reg(i - 1)(i - 1) and b_reg(i - 1)(i - 1)) or (c_reg(i - 1) and a_xor_b(i - 1));
    end generate;

    -- output
    valid <= valid_reg(EOP);
    s(EOP - 1 downto 0) <= s_reg(EOP)(EOP - 1 downto 0);
    s(EOP) <= a_xor_b(EOP) xor c_reg(EOP);
    -- c_out <= (a_reg(EOP)(EOP) and a_reg(EOP)(EOP)) or (c_reg(EOP) and a_xor_b(EOP));
end architecture;