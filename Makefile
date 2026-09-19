# 本仓库的常用构建入口。
#
# 主要用途是 mine/ 下的作业：那些文件在仓库深处，用 `../../lib.typ` 引用
# 仓库根的库文件，而 Typst 默认把“项目根”当作待编译文件所在目录，会以
# “would escape the project root” 拒绝。这里为每次调用传入 `--root .`，
# 把可用范围限定在这条命令内——不设 TYPST_ROOT 环境变量，免得连带影响
# 编译仓库之外的文件。

# 主题库文件。改它们会触发所有作业重编。
LIB := lib.typ ucas-slide.typ ucas-hw.typ

# 已录入的课程作业。新增作业时在这里追加。
FILES := mine/architecture/hw01.typ

# 默认预览/导出的文件（preview、png 用这个）
FILE ?= $(firstword $(FILES))
PAGES ?=

.DEFAULT_GOAL := all

# 编译：目标就是 PDF 本身，因此 make 会按时间戳判断是否需要重编；
# 改了 $(LIB) 里的任何文件也会连带重编。
all: $(FILES:.typ=.pdf)

%.pdf: %.typ $(LIB)
	typst compile --root . $<

# 仓库自带示例。它们的导入写死了 @preview/...，需要 devShell 提供的
# 本地包副本，因此必须在 devShell（或 nix develop）里执行。
examples:
	typst compile main.typ
	typst compile main-hw.typ

# 任意文件：make f FILE=mine/architecture/hw02.typ
f:
	typst compile --root . $(FILE)

# 网页实时预览：改文件即自动重编，浏览器里点一下就能翻页。
# tinymist 自带编译器；端口 23625（数据）/ 23626（控制台）。退出：Ctrl-C。
preview:
	tinymist preview --preview-mode slide --root . $(FILE)

# 把页面导成 PNG，供人直接看、或附给 AI。
# 产物落在 .preview/ 下（已 gitignore）。
png:
	@mkdir -p .preview
	typst compile --root . $(FILE) -f png --ppi 144 $(if $(PAGES),--pages $(PAGES) )".preview/{0p}.png"
	@echo "→ .preview/*.png"

clean:
	rm -f $(FILES:.typ=.pdf) main.pdf main-hw.pdf
	rm -rf .preview

help:
	@echo "make                        编译 PDF（FILES 里登记的作业）"
	@echo "make examples               编译仓库自带示例（需 devShell）"
	@echo "make f FILE=x               编译指定文件"
	@echo "make preview [FILE=x]       浏览器实时预览（tinymist，可翻页）"
	@echo "make png [FILE=x] [PAGES=1] 导出 PNG 到 .preview/"
	@echo "make clean                  清理产物"

.PHONY: all examples f preview png clean help