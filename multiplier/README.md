# multiplier

## Hyperparameters

| Name | Type | Description | Default |
|------|------|-------------|---------|
|`WIDTH`|integer|bit width of the operands|`32`|
|`STAGE`|integer|number of pipeline stages, only works for `vivado_multiplier`|`${WIDTH}`|
|`SIGNED`|bit|whether the operands are signed|`1`|
|`OUTPUT_MSB`|integer|most significant bit of the output|`${WIDTH} * 2 - 1`|
|`OUTPUT_LSB`|integer|least significant bit of the output|`0`|

## Ports

Ports except pipeline standard ports (`clock`, `reset`, `enable`, `flush`, `valid`) are as follows:

| Name | Direction | Type | Description |
|------|-----------|--------------|-------------|
|`a, b`|`in`|`std_logic_vector(${WIDTH} - 1 downto 0)`|operands|
|`p`|`out`|`std_logic_vector(${OUTPUT_MSB} - ${OUTPUT_LSB} downto 0)`|product of `a` and `b`|

## Architectures

### vivado_multiplier

#### performance

In post-implementation simulation, a multiplier with `WIDTH = 5`, using LUTs, can achieve a minimum period of ~10 ns.

In addition, in simulation, there should be ~150 ns for initialization, i.e., the testbench should send data after a period of time.

TODO
