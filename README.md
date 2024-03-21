# pipelined_arithmetic

## Introduction

Template pipelines prepared for [`nodalHDL`](https://github.com/Gralerfics/nodalHDL).

The origin purpose is to solve the limitations of `generic` or `parameter` in `VHDL` and `Verilog HDL` in an approach of string substitution. For example when we want to use the adder from Vivado IPs, `generic` can not be used to select from generated IPs with different names. The identifier on the right of `component` can not be changed.

## Template Structure

Each template is stored in a single folder. There should be a `config.json` and the architecture files in the folder (a `README.md` is also welcomed).

The name of the template is decided by the information in `config.json`, instead of the folder name.

Only folders those contain `config.json` will be considered as a template.

### About `config.json`

Example:

```json
{
    "name": "adder",
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
                        "WIDTH": "${WIDTH}"
                    }
                }
            ],
            "stages": "${STAGE}",
            "notice": "This is a pipelined ripple adder with WIDTH = ${WIDTH}."
        }
    }
}
```

The root object contains `name`, `hyperparameters` and `architectures`.

`hyperparameters` is an array of objects, each object contains `name (str)`, `type (str)`, and `default (str)`. Each object represents a hyperparameter. Use `${NAME}` to call HP.

> Hyperparameters (HP) should be permitted to call previous parameters. For example, one of the HPs' default value is the value of another HP.

`architectures` is an dictionary, where each of the key-value pair represents an available architecture with the function and the interface defined in `description.md`. Key is the name of the architecture and the value is an object, which contains `files`, `stages` and `notice` (optional).

`includes` is a list of objects, each of the object represent a series of included template files that need to be substituded and copyed.

> Each of the object should possess a list named `files`. In default these files should be in the folder of this template. If there is `from` and `parameters`, the files are imported from other templates with the provided parameters.

`stages` is the number of pipeline stages. It is an string which needs to be substituded first, and then use `eval` to be calculated as an Python expression.

`notice` is a string, which is used to inform the user about something. It is optional and in default it is an empty string. This information may be used by the backend (TemplateInstantiator).
