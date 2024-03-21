# pipelined_arithmetic

## Introduction

Template pipelines prepared for `nodalHDL`.

The origin purpose is to solve the limitations of `generic` or `parameter` in `VHDL` and `Verilog HDL` in an approach of string substitution. For example when we want to use the adder from Vivado IPs, `generic` can not be used to select from generated IPs with different names. The identifier on the right of `component` can not be changed.

## Template Structure

Each template is stored in a folder with the same name of the template. There should be a `config.json` and the architecture files in the folder (a `README.md` is also welcomed).

The template information will be used to 

### About `config.json`

Example:

```json
{
    "hyperparameters": [
        {
            "name": "WIDTH",
            "type": "integer",
            "default": "32"
        },
        {
            "name": "STAGE",
            "type": "integer",
            "default": "${WIDTH}"
        }
    ],
    "architectures": {
        "pipelined_ripple_adder": {
            "includes": [
                {
                    "files": [
                        "pipelined_ripple_adder.vhd",
                        "abc/d/e.vhd"
                    ]
                },
                {
                    "files": ["imported_module.vhd"],
                    "from": "other_template",
                    "parameters": {
                        "WIDTH": "$WIDTH"
                    }
                }
            ],
            "stages": "${STAGE}"
        }
    }
}
```

The root object contains two properties, `hyperparameters` and `architectures`.

`hyperparameters` is an array of objects, each object contains `name (str)`, `type (str)`, and `default (str)`. Each object represents a hyperparameter. Use `${NAME}` to call HP.

> Hyperparameters (HP) should be permitted to call previous parameters. For example, one of the HPs' default value is the value of another HP.

`architectures` is an dictionary, where each of the key-value pair represents an available architecture with the function and the interface defined in `description.md`. Key is the name of the architecture and the value is an object, which contains `files` and `stages`.

`includes` is a list of objects, each of the object represent a series of included template files that need to be substituded and copyed.

> Each of the object should possess a list named `files`. In default these files should be in the folder of this template. If there is `from` and `parameters`, the files are imported from other templates with the provided parameters.

`stages` is the number of pipeline stages. It is an string which needs to be substituded first, and then use `eval` to be calculated as an Python expression.
