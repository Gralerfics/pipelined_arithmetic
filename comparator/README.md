# comparator

## Hyperparameters

| Name | Type | Description | Default |
|------|------|-------------|---------|
|`WIDTH`|integer|bit width of the operands|`32`|
|`SIGNED`|bit|whether the operands are signed|`0`|

## Ports

| Name | Direction | Type in VHDL | Description |
|------|-----------|--------------|-------------|
|`clock`|`in`|`std_logic`|clock signal|
|`reset`|`in`|`std_logic`|asynchronous reset signal|
|`enable`|`in`|`std_logic`|clock enable signal (TODO: use enable&(~clock) to remove hazard?)|
|`flush`|`in`|`std_logic`|pipeline flush signal|
|`a, b`|`in`|`std_logic_vector(${WIDTH} - 1 downto 0)`|operands|
|`valid`|`out`|`std_logic`|valid signal|
|`gt`|`out`|`std_logic`|flag for `a > b`|
|`eq`|`out`|`std_logic`|flag for `a = b`|
|`lt`|`out`|`std_logic`|flag for `a < b`|
|`geq`|`out`|`std_logic`|flag for `a >= b`|
|`leq`|`out`|`std_logic`|flag for `a <= b`|
|`neq`|`out`|`std_logic`|flag for `a != b`|

## Architectures

### pipelined_comparator

TODO
