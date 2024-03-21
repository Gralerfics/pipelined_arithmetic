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

| Name | Type in VHDL | Description |
|------|--------------|-------------|
|`clock`|`std_logic`|clock signal|
|`reset`|`std_logic`|asynchronous reset signal|
|`enable`|`std_logic`|clock enable signal (TODO: use enable&(~clock) to remove hazard?)|
|`flush`|`std_logic`|pipeline flush signal|
|`a, b`|`std_logic_vector(${WIDTH} - 1 downto 0)`|operands|
|`valid`|`std_logic`|valid signal|
|`p`|`std_logic_vector(${OUTPUT_MSB} - ${OUTPUT_LSB} downto 0)`|product of `a` and `b`|

## Architectures

### vivado_multiplier

TODO
