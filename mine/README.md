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
沙箱拦下（`would escape the project root`）。仓库根的 `justfile` 会为
每次调用传入 `--root .`：

### 边写边看

```sh
cd ../..                    # 回到仓库根
just preview                # 默认预览 hw01.typ
just preview mine/architecture/hw02.typ
```

`just preview` 先编译一次，用 zathura 打开 PDF，再启动 `typst watch`。
zathura 会在 PDF 变化时自动刷新，所以改文件就能立刻看到结果。Ctrl-C 退出。

just 会自动切到 `justfile` 所在目录，所以**在任意子目录里都能用**，
`--root .` 始终指向仓库根。

> 为什么不用编辑器内预览？Zed 无法在编辑器内渲染 Typst——它的扩展只能提供
> 语言、主题、调试器等能力，没有 webview；typst 扩展的 “Open Preview”
> 其实就是交给浏览器打开一个本地页面。而 tinymist 自带的浏览器预览
> 在当前版本的 CLI 下渲染不出内容（前端收不到页面数据，只有空白）。
> 因此改走外部 PDF 阅读器这条路。

### 导出 PNG（截图、贴给别人或 AI 看）

```sh
just png                          # 默认文件、全部页 → .preview/
just png 1                        # 只要第 1 页
just png 1,2 mine/architecture/hw01.typ
```

产物在 `.preview/`（已 gitignore）。

## 其它命令

```sh
just                             # 编译 files 里登记的作业（出 PDF）
just f mine/architecture/hw02.typ
just examples                    # 编译仓库自带示例
typst watch --root . mine/architecture/hw01.typ   # 只要 PDF 自动重编
```

> 注意：不要在 shell 里 `export TYPST_ROOT=...`。那会连带影响仓库之外的
> 编译（Typst 会报 `source file must be contained in project root`），
> 所以仓库刻意只在单次命令里传 `--root`。

作业里的姓名、学号写在文档顶部的 `ucas-hw-theme` 参数中，另有 `TODO`
标记提示需要替换的位置。