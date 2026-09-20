# 本仓库的常用构建入口。
#
# 主要用途是 mine/ 下的作业：那些文件在仓库深处，用 `../../lib.typ` 引用
# 仓库根的库文件，而 Typst 默认把“项目根”当作待编译文件所在目录，会以
# “would escape the project root” 拒绝。这里为每次调用传入 `--root .`，
# 把可用范围限定在这条命令内——不设 TYPST_ROOT 环境变量，免得连带影响
# 编译仓库之外的文件。
#
# just 会自动切到本文件所在目录（从子目录调用亦可），所以 `--root .`
# 始终指向仓库根。

# 已录入的课程作业，空格分隔。新增作业时在这里追加。
files := "mine/architecture/hw01.typ"

# 不带参数时操作的文件（preview / png / f 用这个）
default_file := "mine/architecture/hw01.typ"

# ---------------------------------------------------------------- 编译

# 编译 files 里登记的全部作业
all:
    #!/usr/bin/env bash
    set -euo pipefail
    for f in {{files}}; do
      typst compile --root . "$f"
    done

# 编译指定文件，默认 default_file
f src=default_file:
    typst compile --root . {{src}}

# 编译仓库自带示例（需 devShell）
examples:
    typst compile main.typ
    typst compile main-hw.typ

# ---------------------------------------------------------------- 预览

# zathura 由 devShell 提供（仅 Linux），它在 PDF 变化时会自动刷新，于是
# typst watch 一重编就立即可见。没有 zathura 时回退到 mupdf；两者都没有
# 就只跑 watch 并提示。
#
# just 只把注释块的最后一行当作 --list 的说明，所以摘要必须写在最后。
#
# 实时预览：zathura 打开 PDF，随 typst watch 自动刷新（关窗即结束）
preview src=default_file out='.preview/preview.pdf':
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p .preview
    typst compile --root . "{{src}}" "{{out}}"

    viewer=""
    if command -v zathura >/dev/null 2>&1; then
      viewer=zathura
    elif command -v mupdf >/dev/null 2>&1; then
      viewer=mupdf
    fi

    if [ -z "$viewer" ]; then
      echo "未找到 PDF 阅读器；PDF 会持续更新：{{out}}" >&2
      exec typst watch --root . "{{src}}" "{{out}}"
    fi

    # watch 放后台、阅读器放前台：关掉窗口或按 Ctrl-C 都会走到 trap，
    # 顺带把 watch 收掉。之前 watch 独占前台，关窗后它还一直跑，
    # 终端就卡在那儿。
    typst watch --root . "{{src}}" "{{out}}" &
    watch_pid=$!
    trap 'kill "$watch_pid" 2>/dev/null || true' EXIT INT TERM

    "$viewer" "{{out}}"

# 导出 PNG 到 .preview/：just png 1 mine/architecture/hw01.typ
png pages='' src=default_file:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p .preview
    args=()
    if [ -n "{{pages}}" ]; then args+=(--pages "{{pages}}"); fi
    typst compile --root . "{{src}}" -f png --ppi 144 "${args[@]}" ".preview/{0p}.png"
    echo "→ .preview/*.png"

# ---------------------------------------------------------------- 其它

# 删除编译产物、.preview/ 与预览用的 PDF
clean:
    #!/usr/bin/env bash
    set -euo pipefail
    for f in {{files}} main.typ main-hw.typ; do
      rm -f "${f%.typ}.pdf"
    done
    rm -rf .preview

# 列出可用命令
help:
    @just --list --unsorted

# 默认动作
default: all