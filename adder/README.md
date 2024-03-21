# adder

## Hyperparameters

> parameters to be substituted, use ${name} to quote.

| Name | Description | Default |
|------|-------------|---------|
|`WIDTH`|bit width of the operands|`32`|

## Ports

| Name | Type in VHDL | Description |
|------|--------------|-------------|
|`clock`|`std_logic`|clock signal|
|`reset`|`std_logic`|asynchronous reset signal|
|`enable`|`std_logic`|clock enable signal (TODO: use enable&(~clock) to remove hazard?)|
|`flush`|`std_logic`|pipeline flush signal|
|`a, b`|`std_logic_vector(${WIDTH} - 1 downto 0)`|operands|
|`valid`|`std_logic`|valid signal|
|`s`|`std_logic_vector(${WIDTH} - 1 downto 0)`|summation of `a` and `b`|
