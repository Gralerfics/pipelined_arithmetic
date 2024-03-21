-- +--------------------------------------------------------------------+
--   Vivado Multiplier IP
-- +--------------------------------------------------------------------+
--   Description:
--       Using IP core for multiplication from Vivado.
-- +--------------------------------------------------------------------+
--   Ports:
--       clock          clock signal
--       reset          asynchronous reset signal
--       enable         clock enable signal
--       flush          flush signal
--       a, b           operands
--       valid          valid signal
--       p              product of a and b
-- +--------------------------------------------------------------------+
--   Comments:
--       Vivado IP `Adder/Subtracter` configurations:
--           Component Name:            ip_vivado_multiplier_${WIDTH}_${STAGE}_${SIGNED}_${OUTPUT_MSB}_${OUTPUT_LSB}
--           Data Type:                 (Un)signed, (Un)signed (related to ${SIGNED})
--           Width:                     ${WIDTH}, ${WIDTH}
--           Use Custom Output Width:   Checked
--           Output MSB:                ${OUTPUT_MSB}
--           Output LSB:                ${OUTPUT_LSB}
--           Pipeline Stages:           ${STAGE}
--           Clock Enable:              Checked
-- +--------------------------------------------------------------------+

library IEEE;
use IEEE.std_logic_1164.all;


entity vivado_multiplier_${WIDTH}_${STAGE}_${SIGNED}_${OUTPUT_MSB}_${OUTPUT_LSB} is
    port (
        clock, reset, enable: in std_logic;
        flush: in std_logic;
        a, b: in std_logic_vector(${WIDTH} - 1 downto 0);
        valid: out std_logic;
        p: out std_logic_vector(${OUTPUT_MSB} - ${OUTPUT_LSB} downto 0)
    );
end entity;


architecture defaults of vivado_multiplier_${WIDTH}_${STAGE}_${SIGNED}_${OUTPUT_MSB}_${OUTPUT_LSB} is
    component ip_vivado_multiplier_${WIDTH}_${STAGE}_${SIGNED}_${OUTPUT_MSB}_${OUTPUT_LSB} is
        port (
            CLK: in std_logic;
            CE: in std_logic;
            A, B: in std_logic_vector(${WIDTH} - 1 downto 0);
            P: out std_logic_vector(${OUTPUT_MSB} - ${OUTPUT_LSB} downto 0)
        );
    end component;

    constant EOP: integer := ${WIDTH} - 1;

    type BitArray is array (0 to EOP) of std_logic;

    signal valid_reg, valid_next: BitArray;
begin
    multiplier: ip_vivado_multiplier_${WIDTH}_${STAGE}_${SIGNED}_${OUTPUT_MSB}_${OUTPUT_LSB}
        port map (
            CLK => clock,
            CE => enable,
            A => a,
            B => b,
            P => p
        );
    
    process (clock, reset) is
    begin
        if reset = '1' then
            valid_reg <= (others => '0');
        elsif rising_edge(clock) and enable = '1' then
            valid_reg <= valid_next;
        end if;
    end process;
    
    -- validity
    valid_next(0) <= enable; -- Theoretically, this is always true because clock ticks only when enable is true
    valid_relations: for i in 1 to EOP generate
        valid_next(i) <= valid_reg(i - 1) when flush = '0' else '0';
    end generate;

    -- output
    valid <= valid_reg(EOP);
end architecture;