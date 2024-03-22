# pipelined_arithmetic

## Introduction

Template pipelines prepared for [`nodalHDL`](https://github.com/Gralerfics/nodalHDL).

The origin purpose is to solve the limitations of `generic` or `parameter` in `VHDL` and `Verilog HDL` in an approach of string substitution. For example when we want to use the adder from Vivado IPs, `generic` can not be used to select from generated IPs with different names. The identifier on the right of `component` can not be changed.

## Template Structure

Each template is stored in a single folder. There should be a `config.json` and the architecture files in the folder (a `README.md` is also welcomed).

The name of the template is in `config.json`. The folder name should be the same as the name of the template.

Only folders those contain `config.json` will be considered as a template.

The name of modules in HDL files should have a prefix same to the name of the architecture, and have a suffix generated by all the hyperparameters' values. For example, the architecture is `pipelined_ripple_adder` and the hyperparameters are `WIDTH` and `STAGE`, the module name should be `pipelined_ripple_adder_32_4` when `WIDTH` is 32 and `STAGE` is 4, i.e. in the file the module name should be `pipelined_ripple_adder_${WIDTH}_${STAGE}`, and the file name should be `pipelined_ripple_adder.vhd` (it will be changed to `pipelined_ripple_adder_32_4.vhd` after instantiated by the backend).

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
        },
        {
            "name": "STRTEST",
            "type": "string",
            "default": "hello"
        }
    ],
    "architectures": {
        "pipelined_ripple_adder": {
            "includes": [
                {
                    "files": [
                        ["pipelined_ripple_adder.vhd", "__main__"],
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

`hyperparameters` is an array of objects, each object contains `name`, `type`, and `default` (optional). Each object represents a hyperparameter. Use `${NAME}` to call HP. If the `default` is not provided, the HP is required.

> Hyperparameters (HP) should be permitted to call previous parameters. For example, one of the HPs' default value is the value of another HP. Available types: `integer`, `string`, `bit`, to be continued ...

`architectures` is an dictionary, where each of the key-value pair represents an available architecture with the function and the interface defined in `description.md`. Key is the name of the architecture and the value is an object, which contains `files`, `stages` and `notice` (optional).

`includes` is a list of objects, each of the object represent a series of included template files that need to be substituded and copyed.

Each of the object should possess a list named `files`. In default these files should be in the folder of this template. If there is `from` and `parameters`, the files are imported from other templates with the provided parameters.

The elements in `files` can also be a list instead of a string. The second element of the list is the custom name of the target file (in default it is `${__TARGET_NAME__}`). It is important that **you must set the second element as `'__main__'` for the main module** of the architecture.

`stages` is the number of pipeline stages. It is an string which needs to be substituded first, and then use `eval` to be calculated as an Python expression.

`notice` is a string, which is used to inform the user about something. It is optional and in default it is an empty string. This information may be used by the backend parsers.

Notice that `default`, values of `parameters` and `stages` are substitude and evaluate required. And `notice` and the content of files are substitude required.

In addition, there will be some built-in parameters:

| Name | Type | Value | Description |
|------|------|-------|-------------|
|`__HYPERPARAMS_JOINED__`|`string`|`'${...}_${...}_..._${...}'`|Joined hyperparameters with `_`.|
|`__CALLER_TEMPLATE_NAME__`|`string`||The name of the template that import the file.|
|`__MASTER_TEMPLATE_NAME__`|`string`||The name of the template where the file lies in.|
|`__CALLER_ARCH_NAME__`|`string`||The name of the architecture that import the file.|
|`__TARGET_NAME__`|`string`||The name of the target file name (without ext name). The main module of the architecture must use this as the module name, while the assistant modules are not required. Because the main module will be called by nodalHDL, while the assistant modules are called by the user itself.|

## TODO: other types like fixed, float, etc.

## TODO: built-in templates indentification. Or regard them all as modules, and use override in `direct`.
