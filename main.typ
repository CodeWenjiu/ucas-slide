// ============================================================================
// 示例：在仓库内直接编译的演示文稿
//
// 这里刻意使用与终端用户完全一致的导入方式，用来验证包本身是否正常：
//
//     #import "@preview/ucas-slide:0.1.0": *
//
// 尚未发布到 Universe 时，flake devShell 会把本仓库挂载为
// `@preview/ucas-slide:0.1.0` 的本地副本（见 flake.nix 的 shellHook），
// 因此进入 `nix develop` / direnv 环境后即可直接编译：
//
//     typst compile main.typ
//
// 发布之后，同一份文件无需改动也能正常编译。
// ============================================================================

#import "@preview/ucas-slide:0.1.0": *

// 默认不指定字体：交给 Typst 的内置字体 + 系统回退，免得本机缺少某个字体
// 就发一堆警告。缺点是不指定中文家族时会回退成无衬线的繁体字形，中文正文
// 需要的话自行打开下面这行（Windows 用 SimSun、macOS 用 Songti SC）：
// #set text(font: ("Source Han Sans SC",))
//
// 注：不要用 "Noto Sans/Serif CJK SC"——那是可变字体，Typst 会取错实例
// （实测拿到 Thin/ExtraLight），字会变得很细。

#show: ucas-theme.with(
  config-info(
    title: [UCAS Theme: Input Your Slide Title],
    subtitle: [人生苦短，我用Typst做slides（非官方）],
    author: [Authors],
    date: datetime.today(),
    institution: [中国科学院大学 xx所],
  ),
)


#title-slide()

#outline-slide()

= Section 1

== Article title

#let example-article-fig = block(
  stroke: 1pt,
  height: 100%,
  width: 50%,
  [Article Figure],
)

#article-title(
  article-fig: example-article-fig,
  journal: [Science],
  impf: [45.8],
  pub-date: [20XX-XX-XX],
  quartile: [中科院 综合性期刊1区],
  core-research: [#lorem(10)],
  authors: [#lorem(10)],
  institution: [#lorem(10)],
)

== Section 1.2
#grid(
  columns: (1fr, 1fr),
  rows: 1fr,
  column-gutter: 1em,
  align(
    horizon,
    image("./figures/bar_chart.svg"),
  ),
  block(
    width: 100%,
    inset: (top: 1em),
    [#h(2em)#lorem(50)],
  ),
)

== Section 1.3
#grid(
  columns: (2fr, 3fr),
  rows: 1fr,
  column-gutter: 0.5em,
  grid(
    align: center,
    rows: (1fr, 1fr),
    image("./figures/heatmap_field.svg"),
    image("./figures/line_comparison.svg"),
  ),
  block(
    inset: (top: 1em),
    h(2em) + [#lorem(70)],
  ),
)

== Section 1.4
#lorem(20)
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.5em,
  align: center + horizon,
  image("./figures/bar_chart.svg"), image("./figures/heatmap_field.svg"), image("./figures/line_comparison.svg"),
)
#lorem(20)

= Section 2

== Section 2.1
#lorem(20)
#tblock(title: [Title])[#lorem(20)]
#rblock(title: [Title])[#lorem(20)]

== Section 2.2
#lorem(20)
#gblock(title: [Title])[#lorem(20)]
#sblock(title: [Title])[#lorem(20)]

= Section 3

== Section 3.1
#lorem(10)
#horz-block()[
  #image("./figures/bar_chart.svg")
  #lorem(10)
][
  #image("./figures/heatmap_field.svg")
  #lorem(10)
][
  #image("./figures/line_comparison.svg")
  #lorem(10)
]

== Section 3.1
#lorem(20)
#horz-block()[
  #image("./figures/bar_chart.svg")
  #lorem(10)
][
  #image("./figures/bar_chart.svg")
  #lorem(10)
][
  #image("./figures/bar_chart.svg")
  #lorem(10)
][
  #image("./figures/bar_chart.svg")
  #lorem(10)
]

= Section 4

== Section 4.1
#lorem(20)

#end-slide()