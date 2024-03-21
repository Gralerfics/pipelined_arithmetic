-- +--------------------------------------------------------------------+
--   Adder (prototype)
-- +--------------------------------------------------------------------+
--   Hyperparameters:
--       DATA_WIDTH     data width
--       (Comment: parameters to be substituted, use {{name}} to call)
-- +--------------------------------------------------------------------+
--   Parameters:
--       None.
-- +--------------------------------------------------------------------+
--   Ports:
--       clock          clock signal
--       reset          asynchronous reset signal
--       enable         clock enable signal, TODO: use enable&(~clock)
--                      to remove hazard?
--       flush          flush signal
--       a, b           operands
--       valid          valid signal
--       s              sum of a and b
-- +--------------------------------------------------------------------+
--   Description:
--       Adder prototype.
-- +--------------------------------------------------------------------+

library IEEE;
use IEEE.std_logic_1164.all;


entity adder is
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


architecture defaults of pipelined_ripple_adder is
begin

end architecture;