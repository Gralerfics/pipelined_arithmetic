from nodalhdl.template.core import register_template, TemplateHyperParameters, TemplateArchitecture, TemplateArchMainFile, TemplateDescription




@register_template("test")
def generate_description():
    hyperparams = TemplateHyperParameters({
        "width": (int, 16),
        "signed": (bool, False),
        "latency": (int, r"${width}")
    })

    arch_0 = TemplateArchitecture(
        name = "vivado_adder",
        content = [
            TemplateArchMainFile("vivado_adder.vhd"), # or ("raw_name", "new_name_with_${...}"). In default, new_name = raw_name_..._..._...
            # TemplateArchFiles([("raw_name", "new_name_with_${...}"), "raw_name", ...]) (TODO)
            # TemplateArchNoRenderingFiles([(..., ...), ...]), (TODO)
            # TemplateArchImportedFiles([(..., ...), ...], from_template = "template_name", params = { ... }), (TODO)
            # TemplateArchImportedNoRenderingFiles([(..., ...), ...], from = "template_name") (TODO)
            # TemplateArchBehavior(fn = lambda params: { ... }), (TODO, 例如用于导出生成 Vivado IP 核的 TCL 脚本并执行)
        ]
    )

    return TemplateDescription([
        hyperparams,
        arch_0
    ])

