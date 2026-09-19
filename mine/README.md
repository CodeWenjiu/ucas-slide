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

## 预览

作业文件在仓库深处，用相对路径引用仓库根的库文件：

```typ
#import "../../lib.typ": hw
```

Typst 默认把“项目根”当作**待编译文件所在目录**，所以直接编译会被
沙箱拦下（`would escape the project root`）。仓库根的 `Makefile` 会为
每次调用传入 `--root .`：

### 边写边看（浏览器实时预览）

```sh
cd ../..                 # 回到仓库根
make preview             # 默认预览 hw01.typ
make preview FILE=mine/architecture/hw02.typ
```

tinymist 会自动打开浏览器，改文件即时重编。因为是幻灯片模式
（`--preview-mode slide`），可以像 PPT 一样翻页。端口 23625/23626，
Ctrl-C 退出。

Zed 里装好 Typst 扩展后也能预览（命令面板搜 `typst preview`），
但注意它默认把项目根当成当前文件所在目录，`mine/` 下的文件会报
同样的错——这时用上面的 `make preview` 更省事。

### 导出 PNG（截图、贴给别人或 AI 看）

```sh
make png                          # 默认文件、全部页 → .preview/
make png FILE=mine/architecture/hw01.typ PAGES=1
```

产物在 `.preview/`（已 gitignore）。

## 其它命令

```sh
make                             # 编译 FILES 里登记的作业（出 PDF）
make f FILE=mine/architecture/hw02.typ
typst watch --root . mine/architecture/hw01.typ   # 只要 PDF 自动重编
```

> 注意：不要在 shell 里 `export TYPST_ROOT=...`。那会连带影响仓库之外的
> 编译（Typst 会报 `source file must be contained in project root`），
> 所以仓库刻意只在单次命令里传 `--root`。

作业里的姓名、学号写在文档顶部的 `ucas-hw-theme` 参数中，另有 `TODO`
标记提示需要替换的位置。