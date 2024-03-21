-- +--------------------------------------------------------------------+
--   Vivado IP Adder
-- +--------------------------------------------------------------------+
--   Parameters:
--       DATA_WIDTH     data width
-- +--------------------------------------------------------------------+
--   Ports:
--       clock          clock signal
--       reset          asynchronous reset signal
--       enable         clock enable signal
--       flush          flush signal
--       a, b           operands
--       valid          valid signal
--       s              sum of a and b
-- +--------------------------------------------------------------------+
--   Description:
--       Vivado IP `Adder/Subtracter`. Configurations:
--           Component Name:            vivado_ip_adder_<DATA_WIDTH>
--           Input Type:                Unsigned, Unsigned
--           Input Width:               <DATA_WIDTH>, <DATA_WIDTH>
--           Add Mode:                  Add
--           Output Width:              <DATA_WIDTH>
--           Latency Configuration:     Manual
--           Latency:                   <DATA_WIDTH>
--           Clock Enable:              Checked
-- +--------------------------------------------------------------------+

library IEEE;
use IEEE.std_logic_1164.all;


entity vivado_ip_adder is
    generic (
        DATA_WIDTH: integer := 32
    );
    port (
        clock, reset, enable: in std_logic;
        flush: in std_logic;
        a, b: in std_logic_vector(DATA_WIDTH - 1 downto 0);
        valid: out std_logic;
        s: out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
end entity;


architecture defaults of vivado_ip_adder is
    component 

begin

end architecture;