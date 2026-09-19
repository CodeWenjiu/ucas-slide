// ---------------------------- 配色 ----------------------------
#let ucas-blue = rgb(23, 73, 148)
#let ucas-flag-blue = rgb(14, 87, 156)
#let ucas-light-blue = rgb(0, 155, 222)
#let ucas-red = rgb(96, 14, 18)
#let ucas-grey = rgb(128, 128, 128)
#let ucas-line = ucas-grey.transparentize(55%)

// ---------------------------- 字体 ----------------------------
// 依次回退；列表里不存在的字体会产生 Typst 警告，可按需增删
#let ucas-hw-fonts = (
  "Times New Roman",
  "New Computer Modern",
  "Songti SC",
)

// ---------------------------- 素材 ----------------------------
// 同 ucas-slide.typ：用相对路径，保证以包或子模块两种方式引入时都能定位素材。
#let ucas-logo-blue = "./ucas_fig/国科大标准Logo横式一（蓝色）.png" // 页眉：校名横式标识
#let ucas-badge = "./ucas_fig/中国科学院院徽.png" // 纸张正中水印
#let ucas-calligraphy-red = "./ucas_fig/国科大书法字（红色）.png" // 页脚：书法体“国科大”

// ---------------------------- 版面参数 ----------------------------
#let hw-page-width = 21cm
#let hw-layout = (
  margin-x: 2.4cm,
  margin-top: 7em,
  margin-bottom: 7em,
  header-offset: 0.95cm,
  footer-offset: 1cm,
)


#let hw-rule(color, thickness) = block(
  width: 100%,
  height: thickness,
  fill: color,
)

#let hw-rule-pair(
  color: ucas-blue,
  thick: 1.1pt,
  gap: 0.13em,
  thin: 0.5pt,
) = grid(
  columns: 1,
  rows: (thick, gap, thin),
  row-gutter: 0pt,
  rect(width: 100%, height: 100%, fill: color),
  [],
  rect(width: 100%, height: 100%, fill: color.transparentize(60%)),
)

// 固定高度的纵向占位
#let hw-gap(height) = block(width: 100%, height: height)

#let hw-faded(path, width, aspect: 1, opacity: 12%) = box(
  width: width,
  height: width * aspect,
  [
    #place(center + horizon, image(path, width: width))
    #place(rect(width: 100%, height: 100%, fill: white.transparentize(opacity)))
  ],
)


// ============================ 填写栏 ============================
// 形如“学号：__________”的下划线填写栏；value 为 none 时留白待填。
//
// 值超出一栏可用宽时（例如课程名“计算机体系结构”）自动等比缩字号，
// 保证单行不折行——否则文字会溢出这个固定高度的栏位，被下划线截断。
// 用 layout() 取真实可用宽，而非事先算列宽：列宽随页面边距、
// gutter 等参数变化，写死会在改版式时失准。
#let hw-field(
  label,
  value,
  label-width: 5.1em,
  height: 1.5em,
) = grid(
  columns: (label-width, 1fr),
  column-gutter: 0.25em,
  align(bottom + right, text(weight: "bold", fill: ucas-blue)[#label：]),
  box(
    width: 100%,
    height: height,
    stroke: (bottom: 0.6pt + ucas-line),
    inset: (left: 0.35em, right: 0.35em, bottom: 0.1em),
    align(bottom + left, if value == none {
      []
    } else {
      context layout(area => {
        let natural = measure(text(value)).width
        let size = if natural > 0pt and area.width > 0pt and natural > area.width {
          (area.width / natural) * 1em
        } else {
          1em
        }
        text(size: size, value)
      })
    }),
  ),
)


// ============================ 学号 / 姓名 / 课程 ============================
// 学生信息由主题写入 state；hw-info() 读出来渲染成三栏填写栏。
#let hw-info-state = state("ucas-hw-info", (
  course: none,
  name: none,
  student-id: none,
))

#let hw-info(
  course: auto,
  name: auto,
  student-id: auto,
  gutter: 1.6em,
) = context {
  let info = hw-info-state.get()
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: gutter,
    hw-field([学号], if student-id == auto { info.student-id } else { student-id }),
    hw-field([姓名], if name == auto { info.name } else { name }),
    hw-field([课程名称], if course == auto { info.course } else { course }),
  )
}


// ============================ 页眉 ============================
// 居中一行：校名横式标识 + “作业纸”；其下为蓝色双线
#let ucas-hw-header(
  title: [作业纸],
  logo: ucas-logo-blue,
  offset: hw-layout.header-offset,
  margin-x: hw-layout.margin-x,
) = place(
  top + center,
  dy: offset,
  block(
    width: 100%,
    inset: (x: margin-x),
    grid(
      columns: 1,
      row-gutter: 0.5em,
      align(
        center,
        grid(
          columns: (auto, auto),
          column-gutter: 0.5em,
          align(
            horizon + right,
            if logo == none { [] } else { image(logo, height: 2.4em) },
          ),
          align(horizon + left, text(1.6em, weight: "bold", fill: ucas-blue)[#title]),
        ),
      ),
      hw-rule-pair(),
    ),
  ),
)


// ============================ 页脚 ============================
#let ucas-hw-footer(
  logo: none,
  show-fields: false,
  show-page-number: true,
  offset: hw-layout.footer-offset,
  margin-x: hw-layout.margin-x,
) = {
  let cells = (hw-rule(ucas-line, 0.5pt),)
  if show-fields {
    cells += (hw-info(),)
  }
  if show-page-number or logo != none {
    cells += (
      grid(
        columns: (1fr, 1fr),
        align(
          horizon + left,
          if logo == none { [] } else { image(logo, height: 1.3em) },
        ),
        align(
          horizon + right,
          if show-page-number {
            context {
              text(0.75em, fill: ucas-grey)[第 #counter(page).display() 页]
            }
          } else {
            []
          },
        ),
      ),
    )
  }
  place(
    bottom + center,
    dy: -offset,
    block(
      width: 100%,
      inset: (x: margin-x),
      grid(columns: 1, row-gutter: 0.6em, ..cells),
    ),
  )
}


// ============================ 标题区 ============================
// 标题 / 副标题 / 备注 / 分隔线，分隔线下方为学号、姓名、课程名称填写栏。
#let hw-title(
  title,
  subtitle: none,
  note: none,
  show-info: true,
) = {
  let cells = (align(center, text(1.85em, weight: "bold")[#title]),)
  if subtitle != none {
    cells += (hw-gap(1.1em), align(center, text(1.1em, fill: ucas-blue)[#subtitle]))
  }
  if note != none {
    cells += (hw-gap(1.05em), align(center, text(0.95em, fill: ucas-grey)[#note]))
  }
  cells += (
    hw-gap(1.05em),
    hw-rule(ucas-blue.transparentize(70%), 0.6pt),
  )
  if show-info {
    cells += (hw-gap(0.7em), hw-info())
  }
  block(
    width: 100%,
    above: 0em,
    below: 1.5em,
    grid(columns: 1, row-gutter: 0pt, ..cells),
  )
}


// ============================ 题目 ============================
#let hw-problem(
  body,
  number: none,
  title: none,
) = {
  let cells = ()
  if number != none or title != none {
    cells += (
      text(weight: "bold", fill: ucas-blue, {
        if number != none { number }
        if number != none and title != none { h(0.5em) }
        if title != none { title }
      }),
    )
  }
  cells += (body,)
  block(
    width: 100%,
    above: 1.3em,
    below: 0.6em,
    breakable: true,
    grid(columns: 1, row-gutter: 0.45em, ..cells),
  )
}


// ============================ 提示框 ============================
#let hw-note(
  body,
  title: none,
  color: ucas-blue,
) = {
  let cells = ()
  if title != none {
    cells += (text(weight: "bold", fill: color.darken(15%))[#title],)
  }
  cells += (body,)
  block(
    width: 100%,
    above: 0.8em,
    below: 0.8em,
    breakable: true,
    fill: color.lighten(94%),
    stroke: (left: 3pt + color),
    inset: (left: 1em, right: 0.9em, top: 0.6em, bottom: 0.6em),
    grid(columns: 1, row-gutter: 0.35em, ..cells),
  )
}


// ============================ 主题入口 ============================
#let ucas-hw-theme(
  course: none,
  name: none,
  student-id: none,
  header-title: [作业纸],
  header-logo: ucas-logo-blue,
  footer-logo: ucas-calligraphy-red,
  show-footer-fields: false,
  show-page-number: true,
  show-watermark: true,
  watermark: ucas-badge,
  watermark-size: 46%,
  watermark-aspect: 1,
  watermark-opacity: 12%,
  font: ucas-hw-fonts,
  size: 11pt,
  body,
) = {
  set document(title: "中国科学院大学作业纸")
  set text(font: font, size: size, lang: "zh", region: "cn")
  set par(justify: true, leading: 0.8em, spacing: 1.05em)
  set heading(numbering: "1.1")
  show heading: it => block(
    above: 1.25em,
    below: 0.55em,
    text(weight: "bold", fill: ucas-blue)[#it],
  )
  hw-info-state.update((
    course: course,
    name: name,
    student-id: student-id,
  ))
  set page(
    paper: "a4",
    margin: (
      x: hw-layout.margin-x,
      top: hw-layout.margin-top,
      bottom: hw-layout.margin-bottom,
    ),
    background: [
      #if show-watermark {
        place(
          center + horizon,
          hw-faded(
            watermark,
            hw-page-width * watermark-size,
            aspect: watermark-aspect,
            opacity: watermark-opacity,
          ),
        )
      }
      #ucas-hw-header(title: header-title, logo: header-logo)
      #ucas-hw-footer(
        logo: footer-logo,
        show-fields: show-footer-fields,
        show-page-number: show-page-number,
      )
    ],
  )
  body
}
