# 体系结构 · 作业

本目录存放体系结构课程的作业，依赖仓库根目录的主题：

```typ
#import "../../lib.typ": hw
```

## 编译

在仓库根目录执行：

```sh
make                                           # 编译 Makefile 中登记的作业
typst compile --root . mine/architecture/hw01.typ
typst watch   --root . mine/architecture/hw01.typ   # 改一处自动重编
```

`--root .` 不能省：Typst 默认把“项目根”当作待编译文件所在目录，
`../../lib.typ` 会被沙箱拦下。详见 `mine/README.md`。

## 说明

- 课程作业**不会**随包分发（`typst.toml` 的 `exclude` 已排除 `mine/`），
  它只是本仓库内的私人用例；
- 作业姓名、学号写在文档顶部 `ucas-hw-theme` 的参数里，改一次即可；
- 写新作业时复制 `hw01.typ` 改名，再把 `Makefile` 的 `FILES` 补一行。