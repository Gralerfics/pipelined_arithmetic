from nodalhdl.template.core import register_template
from nodalhdl.template.core import TemplateHyperParameters
from nodalhdl.template.core import TemplateArchitecture, TemplateArchMainFile, TemplateArchBehavior
from nodalhdl.template.core import TemplateDescription


def generate_vivado_project(full_params: dict):
    pass


@register_template("addsub")
def generate_description():
    hyperparams = TemplateHyperParameters({
        "width": (int, 16),
        "signed": (bool, False),
        "latency": (int, r"${width}")
    })

    # ports = TemplatePorts(
        # 也许不需要定义端口
        # 实例化渲染模板时是已知具体类型的 (instant_type = True), 即位宽已知,
        # 那么交给解析过程中的运算符重载方法去处理即可,
        # 实例化时需要得出声明、例化、连接等信息, 本身也得编写者了解模板的具体端口,
        # 声明中的端口一律 std_logic(_vector), 已知位宽即可定义, 匹配的问题交给模板,
        # 即, 模板提供者需要提供模板本身, 以及调用模板的模块封装 (重载函数),
        # 重载函数面向高层次的信号类型 (signal.types), 根据输入给出输出, 并渲染模板.
    # )

    arch_0 = TemplateArchitecture(
        name = "vivado_adder",
        content = [
            TemplateArchMainFile("vivado_adder.vhd"), # or ("raw_name", "new_name_with_${...}"). In default, new_name = raw_name_..._..._...
            # TemplateArchFiles([("raw_name", "new_name_with_${...}"), "raw_name", ...]) (TODO)
            # TemplateArchNoRenderingFiles([(..., ...), ...]), (TODO)
            # TemplateArchImportedFiles([(..., ...), ...], from_template = "template_name", params = { ... }), (TODO)
            # TemplateArchImportedNoRenderingFiles([(..., ...), ...], from = "template_name") (TODO)
            TemplateArchBehavior(generate_vivado_project)
        ]
    )

    return TemplateDescription([
        hyperparams,
        arch_0
    ])

