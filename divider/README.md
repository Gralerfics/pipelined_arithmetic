# divider

## Hyperparameters

| Name | Type | Description | Default |
|------|------|-------------|---------|
|`WIDTH`|integer|bit width of the operands|`32`|
<!-- |`STAGE`|integer|number of pipeline stages|`${}`| -->
|`SIGNED`|bit|whether the operands are signed|`0`|
<!-- TODO -->

## Ports

| Name | Direction | Type in VHDL | Description |
|------|-----------|--------------|-------------|
|`clock`|`in`|`std_logic`|clock signal|
|`reset`|`in`|`std_logic`|asynchronous reset signal|
|`enable`|`in`|`std_logic`|clock enable signal (TODO: use enable&(~clock) to remove hazard?)|
|`flush`|`in`|`std_logic`|pipeline flush signal|
|`a, b`|`in`|`std_logic_vector(${WIDTH} - 1 downto 0)`|operands|
TODO

## Architectures

### vivado_divider

TODO
