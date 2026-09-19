# 本仓库的常用构建入口。
#
# 主要用途是 mine/ 下的作业：那些文件在仓库深处，用 `../../lib.typ` 引用
# 仓库根的库文件，而 Typst 默认把“项目根”当作待编译文件所在目录，会以
# “would escape the project root” 拒绝。这里为每次调用传入 `--root .`，
# 把可用范围限定在这条命令内——不设 TYPST_ROOT 环境变量，免得连带影响
# 编译仓库之外的文件。

# 已录入的课程作业。新增课程时在这里加一条，或在命令行用 FILE=... 覆盖。
FILES := mine/architecture/hw01.typ

.PHONY: all $(FILES) clean
.DEFAULT_GOAL := all

all: $(FILES)

# 逐个编译（不写成批量循环，方便并排看每条命令的输出）
$(FILES):
	typst compile --root . $@

# 仓库自带示例。它们的导入写死了 @preview/...，需要 devShell 提供的
# 本地包副本，因此必须在 devShell（或 nix develop）里执行。
.PHONY: examples
examples:
	typst compile main.typ
	typst compile main-hw.typ

# 任意文件：make f FILE=mine/architecture/hw02.typ
.PHONY: f
f:
	typst compile --root . $(FILE)

clean:
	rm -f mine/*/*.pdf

help:
	@echo "make           编译 FILES 中列出的作业"
	@echo "make examples  编译仓库自带示例（需 devShell）"
	@echo "make f FILE=x  编译指定文件"
	@echo "make clean     删除 mine/ 下的产物"