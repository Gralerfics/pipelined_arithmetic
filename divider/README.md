# divider

## Hyperparameters

| Name | Type | Description | Default |
|------|------|-------------|---------|
|`WIDTH`|integer|bit width of the operands|`32`|
<!-- |`STAGE`|integer|number of pipeline stages|`${}`| -->
|`SIGNED`|bit|whether the operands are signed|`0`|
<!-- TODO -->

## Ports

Ports except pipeline standard ports (`clock`, `reset`, `enable`, `flush`, `valid`) are as follows:

| Name | Direction | Type in VHDL | Description |
|------|-----------|--------------|-------------|
|`a, b`|`in`|`std_logic_vector(${WIDTH} - 1 downto 0)`|operands|
TODO

## Architectures

### vivado_divider

TODO
