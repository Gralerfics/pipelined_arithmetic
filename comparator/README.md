# comparator

## Hyperparameters

| Name | Type | Description | Default |
|------|------|-------------|---------|
|`WIDTH`|integer|bit width of the operands|`32`|
|`SIGNED`|bit|whether the operands are signed|`0`|

## Ports

Ports except pipeline standard ports (`clock`, `reset`, `enable`, `flush`, `valid`) are as follows:

| Name | Direction | Type in VHDL | Description |
|------|-----------|--------------|-------------|
|`a, b`|`in`|`std_logic_vector(${WIDTH} - 1 downto 0)`|operands|
|`gt`|`out`|`std_logic`|flag for `a > b`|
|`eq`|`out`|`std_logic`|flag for `a = b`|
|`lt`|`out`|`std_logic`|flag for `a < b`|
|`geq`|`out`|`std_logic`|flag for `a >= b`|
|`leq`|`out`|`std_logic`|flag for `a <= b`|
|`neq`|`out`|`std_logic`|flag for `a != b`|

## Architectures

### pipelined_comparator

TODO
