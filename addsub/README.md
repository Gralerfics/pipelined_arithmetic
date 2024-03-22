# addsub

Adder & subtractor for signed or unsigned integers.

## Hyperparameters

> Parameters to be substituted, use ${name} to quote.

| Name | Type | Description | Default |
|------|------|-------------|---------|
|`WIDTH`|integer|bit width of the operands|`32`|
|`STAGE`|integer|number of pipeline stages, only works for `vivado_adder`|`${WIDTH}`|

## Ports

| Name | Direction | Type in VHDL | Description |
|------|-----------|--------------|-------------|
|`clock`|`in`|`std_logic`|clock signal|
|`reset`|`in`|`std_logic`|asynchronous reset signal|
|`enable`|`in`|`std_logic`|clock enable signal (TODO: use enable&(~clock) to remove hazard?)|
|`flush`|`in`|`std_logic`|pipeline flush signal|
|`a, b`|`in`|`std_logic_vector(${WIDTH} - 1 downto 0)`|operands|
|`valid`|`out`|`std_logic`|valid signal|
|`s`|`out`|`std_logic_vector(${WIDTH} - 1 downto 0)`|sum of `a` and `b`|

## Architectures

### pipelined_ripple_adder

TODO

### vivado_adder

TODO
