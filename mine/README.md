# 我自己的作业

本目录**不随包分发**（`typst.toml` 的 `exclude` 已排除 `mine/`），
只是本仓库内的私人用例。

## 结构

```
mine/
└── architecture/     计算机体系结构
    ├── hw01.typ      第一次作业
    └── README.md
```

新增课程时按同样的方式加一个目录即可，例如 `mine/compiler/`。

## 用法

作业文件在仓库深处，用相对路径引用仓库根的库文件：

```typ
#import "../../lib.typ": hw
```

Typst 默认把“项目根”当作**待编译文件所在目录**，所以直接编译会被
沙箱拦下（`would escape the project root`）。从仓库根用 `make` 编译，
它会给每次调用传入 `--root .`：

```sh
cd ../..            # 回到仓库根
make                # 编译 Makefile 里 FILES 列出的作业
make f FILE=mine/architecture/hw02.typ
```

也可以手动指定：

```sh
typst compile --root . mine/architecture/hw01.typ
typst watch   --root . mine/architecture/hw01.typ   # 改一处自动重编
```

> 注意：不要在 shell 里 `export TYPST_ROOT=...`。那会连带影响仓库之外的
> 编译（Typst 会报 `source file must be contained in project root`），
> 所以仓库刻意只在单次命令里传 `--root`。

作业里的姓名、学号写在文档顶部的 `ucas-hw-theme` 参数中，另有 `TODO`
标记提示需要替换的位置。