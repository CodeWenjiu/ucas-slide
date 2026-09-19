// ============================================================================
// 中国科学院大学演示文稿（slides）—— 起始文件
//
// `typst init @preview/ucas-slide:0.1.0` 会生成这份文件；
// 编译方式：
//     typst compile main.typ
// 依赖（touying / numbly）由 Typst 自动下载，无需手动安装。
// ============================================================================

#import "@preview/ucas-slide:0.1.0": *

// 模板的默认字体交给 Typst：它内置的字体 + 系统字体回退能覆盖中英文，
// 且不会因为指定了本机不存在的字体而产生警告。
// 如需指定字体，自行取消注释并按需修改（不存在的字体会产生警告）：
// #set text(font: ("Times New Roman", "Noto Sans CJK SC"))

#show: ucas-theme.with(
  config-info(
    title: [UCAS Theme: Input Your Slide Title],
    subtitle: [人生苦短，我用Typst做slides（非官方）],
    author: [Authors],
    date: datetime.today(),
    institution: [中国科学院大学 xx所],
  ),
)

#title-slide()   // 封面
#outline-slide() // 目录

// 一级标题（= 章节）会自动生成章节页，二级标题（== 小节）作为内容页标题。
= Section 1

== Article title

// 论文信息页；article-fig 接收任意内容，这里用占位方块代替论文插图。
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

== 两栏内容

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  block(width: 100%, inset: (top: 1em), [#lorem(50)]),
  block(width: 100%, inset: (top: 1em), [#lorem(50)]),
)

= Section 2

== 彩色卡片

#lorem(20)
#tblock(title: [Title])[#lorem(20)]
#rblock(title: [Title])[#lorem(20)]

== 更多配色

#lorem(20)
#gblock(title: [Title])[#lorem(20)]
#sblock(title: [Title])[#lorem(20)]

= Section 3

== 横向等分内容块

#lorem(10)
#horz-block()[
  #lorem(15)
][
  #lorem(15)
][
  #lorem(15)
]

== 细边框卡片

#lorem(20)
#lblock[#lorem(30)]

= Section 4

== 最后一节

#lorem(30)

#end-slide() // 结束页（谢谢聆听）