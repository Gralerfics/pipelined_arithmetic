# addsub

Adder & subtractor for signed or unsigned integers.

## Hyperparameters

> Parameters to be substituted, use ${name} to quote.

| Name | Type | Description | Default |
|------|------|-------------|---------|
|`WIDTH`|integer|bit width of the operands|`32`|
|`STAGE`|integer|number of pipeline stages, only works for `vivado_adder`|`${WIDTH}`|

## Ports

Ports except pipeline standard ports (`clock`, `reset`, `enable`, `flush`, `valid`) are as follows:

| Name | Direction | Type in VHDL | Description |
|------|-----------|--------------|-------------|
|`a, b`|`in`|`std_logic_vector(${WIDTH} - 1 downto 0)`|operands|
|`s`|`out`|`std_logic_vector(${WIDTH} - 1 downto 0)`|result|

## Architectures

### pipelined_ripple_adder

TODO

### vivado_adder

TODO
