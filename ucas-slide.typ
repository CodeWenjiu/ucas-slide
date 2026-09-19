#import "@preview/touying:0.6.1": *
#import "@preview/numbly:0.1.0": numbly


#let ucas-blue = rgb(23, 73, 148)
#let ucas-flag-blue = rgb(14, 87, 156)
#let ucas-light-blue = rgb(0, 155, 222)
#let ucas-red = rgb(96, 14, 18)
#let quality-grey = rgb(135, 135, 135)
#let pro-gold = rgb(210, 160, 95)
#let pro-silver = rgb(209, 211, 211)
#let ucas-blue-grad = gradient.linear(ucas-blue, ucas-blue.lighten(80%))


// 素材用相对路径引用：Typst 中相对路径按“书写它的文件”解析，因此无论本文件
// 是被包（@preview/...）导入，还是被 git 子模块/直接拷贝的方式导入，
// 都能定位到同一份素材。
// 注意：不要改成前导 `/` 的写法——那种路径相对“项目根”解析，
// 在以子模块方式引入时会跑到调用方的项目根去而找不到文件。
#let ucas-logo-blue = "./ucas_fig/国科大标准Logo横式一（蓝色）.png"
#let ucas-logo-white = "./ucas_fig/国科大标准Logo横式一（白色）.png"
#let ucas-logo-white-2 = "./ucas_fig/国科大标准Logo横式二（白色）.png"
#let ucas-badge-white = "./ucas_fig/中国科学院院徽（白色）.png"
#let ucas-badge-white-trans = "./ucas_fig/中国科学院院徽（白色）-半透明.svg"
#let ucas-badge-watermark = "./ucas_fig/中国科学院院徽（白色）-水印.png"

// ============================ 页眉 ============================
#let ucas-header(self) = {
  let block-grad = gradient.linear(
    (self.colors.primary, 0%),
    (white, 95%),
    (white, 100%),
  )
  set text(size: 20pt)
  let body = {
    grid(
      columns: (1fr, auto),
      block(
        fill: block-grad,
        height: 100%,
        width: 100%,
        inset: (left: 1em, right: 1em),
        align(
          left + horizon,
          text(1.5em, fill: white, weight: "bold", utils.display-current-heading(level: 2)),
        ),
      ),
      block(
        height: 100%,
        inset: (right: 1em),
        align(
          right + horizon,
          image(ucas-logo-blue, height: 60%),
        ),
      ),
    )
  }

  body
}

// ============================ 页脚 ============================
#let ucas-footer(self) = {
  set text(size: 20pt)
  let body = context {
    block(
      height: 100%,
      width: 100%,
      inset: (x: 1em),
      align(
        right + horizon,
        text(1em, fill: self.colors.pro-silver, utils.slide-counter.display()),
      ),
    )
  }

  body
}

// ============================ 内容页 ============================
#let slide(
  title: auto,
  config: (:),
  body,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-page(
      header: ucas-header,
      footer: ucas-footer,
    ),
  )
  touying-slide(self: self, body, ..args)
})

// ============================ 封面页 ============================
#let title-slide(
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  set text(size: 20pt)
  let info = self.info + args.named()
  let body = {
    set par(leading: 1.5em)
    grid(
      rows: (4fr, 2fr),
      block(
        fill: self.colors.primary,
        height: 100%,
        width: 100%,
        inset: 3em,
        clip: true,
        {
          set text(fill: white)
          place(
            right + bottom,
            dx: 2.5em,
            dy: 2.5em,
            image(ucas-badge-watermark, height: 10em),
          )
          align(
            left + top,
            image(ucas-logo-white, height: 3em)
              + text(2em, weight: "bold", info.title)
              + (
                if info.subtitle != none {
                  linebreak()
                  text(1.5em, info.subtitle)
                }
              ),
          )
        },
      ),
      block(
        height: 100%,
        width: 100%,
        inset: (x: 3em, y: 1em),
        {
          set text(1em, fill: self.colors.primary)
          align(
            left + horizon,
            (
              if info.author != none {
                info.author
              }
            )
              + (
                if info.institution != none {
                  h(2.5em)
                  text(fill: self.colors.primary, "|")
                  h(2.5em)
                  info.institution
                }
              )
              + (
                if info.date != none {
                  linebreak()
                  utils.display-info-date(self)
                }
              ),
          )
        },
      ),
    )
  }
  touying-slide(self: self, body)
})

// ============================ 章节页 ============================
#let new-section-slide(
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  set text(size: 20pt)
  let body = {
    grid(
      rows: (1fr, 3fr, 1fr),
      block(
        width: 100%,
        height: 100%,
        place(
          bottom,
          dy: -0.5em,
          rect(
            width: 100%,
            height: 0.25em,
            stroke: none,
            fill: self.colors.primary,
          ),
        )
          + place(
            left + horizon,
            dx: 1em,
            dy: -0.25em,
            image(ucas-logo-blue, height: 40%),
          ),
      ),
      block(
        height: 100%,
        width: 100%,
        fill: self.colors.primary,
        inset: (left: 8em, right: 3em),
        clip: true,
        align(
          horizon,
          grid(
            columns: (auto, 4em, auto),
            align: horizon + center,
            text(5em, fill: white, weight: "bold", utils.display-current-heading-number(numbering: "01")),
            line(angle: 90deg, length: 5em, stroke: (paint: white, thickness: 2.5pt, cap: "round")),
            move(
              dy: 0.2em,
              text(3em, fill: white, weight: "bold", utils.display-current-heading(level: 1, numbered: false)),
            ),
          ),
        )
          + place(
            right + horizon,
            dx: 10em,
            image(ucas-badge-white-trans, height: 20em),
          ),
      ),
      block(
        width: 100%,
        height: 100%,
        place(
          top,
          dy: 0.5em,
          rect(
            width: 100%,
            height: 0.25em,
            stroke: none,
            fill: self.colors.primary,
          ),
        ),
      ),
    )
  }
  touying-slide(self: self, body)
})

// ============================ 目录页 ============================
#let outline-slide(
  config: (:),
  title: utils.i18n-outline-title,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  set text(size: 20pt)
  let block-grad = gradient.linear(
    dir: ttb,
    (self.colors.primary, 0%),
    (self.colors.primary-light, 40%),
    (self.colors.primary-light, 60%),
    (self.colors.primary-lightest, 100%),
  )
  let circled-numbering(..nums) = {
    let n = nums.pos().last()
    box(
      baseline: 0.4em,
      inset: (right: 0.5em),
      circle(
        radius: 0.8em,
        stroke: none,
        inset: 0pt,
        fill: self.colors.primary-light,
        align(
          center + horizon,
          text(1em, fill: white, weight: "bold", str(n)),
        ),
      ),
    )
  }
  let body = {
    grid(
      columns: (2fr, 5fr),
      block(
        height: 100%,
        width: 100%,
        fill: block-grad,
        inset: (top: 1.5em, bottom: 1em, x: 1em),
        place(
          center + top,
          image(ucas-logo-white-2, width: 100%),
        )
          + place(
            center + horizon,
            text(2.5em, fill: white, weight: "bold", title),
          ),
      ),
      block(
        height: 100%,
        width: 100%,
        inset: (left: 5em),
        align(
          center + horizon,
          text(
            1.8em,
            fill: self.colors.primary-light,
            weight: "bold",
            components.custom-progressive-outline(
              depth: 1,
              vspace: (0em,),
              numbered: (true,),
              numbering: (circled-numbering,),
            ),
          ),
        ),
      ),
    )
  }
  touying-slide(self: self, body)
})

// ============================ 结束页 ============================
#let end-slide(
  remark: [谢谢聆听],
  config: (:),
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  set text(size: 20pt)
  let body = {
    grid(
      rows: (1fr, 3fr, 1fr),
      block(
        width: 100%,
        height: 100%,
        place(
          bottom,
          dy: -0.5em,
          rect(
            width: 100%,
            height: 0.25em,
            stroke: none,
            fill: self.colors.primary,
          ),
        )
          + place(
            left + horizon,
            dx: 1em,
            dy: -0.25em,
            image(ucas-logo-blue, height: 40%),
          ),
      ),
      block(
        height: 100%,
        width: 100%,
        fill: self.colors.primary,
        place(
          center + horizon,
          image(ucas-badge-watermark, height: 90%),
        )
          + place(
            center + horizon,
            text(2.5em, fill: white, weight: "bold", remark),
          ),
      ),
      block(
        height: 100%,
        width: 100%,
        fill: white,
        place(
          top,
          dy: 0.5em,
          rect(
            width: 100%,
            height: 0.25em,
            stroke: none,
            fill: self.colors.primary,
          ),
        )
          + place(
            top + left,
            dy: 1.5em,
            dx: 1.5em,
            text(1em, fill: self.colors.primary, self.info.author),
          )
          + (
            if self.info.date != none {
              place(
                top + right,
                dy: 1.5em,
                dx: -1.5em,
                text(1em, fill: self.colors.primary, utils.display-info-date(self)),
              )
            }
          ),
      ),
    )
  }
  touying-slide(self: self, body)
})

// ============================ 主题配置 ============================
#let ucas-theme(
  aspect-ratio: "16-9",
  ..args,
  body,
) = {
  set text(size: 20pt)
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (x: 2em, bottom: 30pt, top: 70pt),
      header-ascent: 17.5pt,
      footer-descent: 0pt,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-colors(
      primary: ucas-blue,
      primary-light: ucas-blue.lighten(20%),
      primary-lighter: ucas-blue.lighten(50%),
      primary-lightest: ucas-blue.lighten(80%),
      secondary: ucas-flag-blue,
      tertiary: ucas-light-blue,
      ucas-red: ucas-red,
      quality-grey: quality-grey,
      pro-gold: pro-gold,
      pro-silver: pro-silver,
      primary-grad: ucas-blue-grad,
    ),
    config-info(
      date: datetime.today(),
    ),

    ..args,
  )
  set heading(numbering: numbly("{1}.", default: "1.1"))
  set par(justify: true)
  body
}


#let color-block(self: none, title: none, custom-color: none, it) = {
  let (head-color, body-color) = {
    if custom-color != none {
      let head = gradient.linear(custom-color, custom-color.lighten(80%))
      let body = custom-color.lighten(90%)
      (head, body)
    } else {
      let head = self.colors.primary-grad
      let body = self.colors.primary.lighten(90%)
      (head, body)
    }
  }
  grid(
    columns: 1,
    row-gutter: 0pt,
    block(
      fill: head-color,
      width: 100%,
      height: 1.5em,
      radius: (top: 10pt),
      inset: (left: 1em),
      align(
        horizon,
        text(fill: white, weight: "bold", title),
      ),
    ),
    block(
      fill: body-color,
      width: 100%,
      radius: (bottom: 10pt),
      inset: 1em,
      it,
    ),
  )
}

#let tblock(title: none, body) = touying-fn-wrapper(
  color-block.with(
    title: title,
    custom-color: none,
    body,
  ),
)

#let rblock(title: none, body) = color-block(
  self: none,
  title: title,
  custom-color: ucas-red,
  body,
)

#let gblock(title: none, body) = color-block(
  self: none,
  title: title,
  custom-color: pro-gold,
  body,
)

#let sblock(title: none, body) = color-block(
  self: none,
  title: title,
  custom-color: pro-silver.darken(20%),
  body,
)


#let _lblock(self: none, body) = block(
  stroke: (paint: self.colors.primary, thickness: 1pt),
  inset: (x: 0.5em, y: 1em),
  align(
    center + top,
    body,
  ),
)

#let lblock(body) = touying-fn-wrapper(
  _lblock.with(body),
)

#let _article-title(
  self: none,
  article-fig: none,
  core-research: none,
  authors: none,
  institution: none,
  journal: none,
  quartile: none,
  impf: none,
  pub-date: none,
) = {
  grid(
    rows: (1fr, auto),
    row-gutter: 0.5em,
    grid(
      columns: (auto, 1fr),
      align(
        center + horizon,
        block(
          inset: 1pt,
          article-fig,
        ),
      ),
      grid(
        rows: (1fr, 1fr, 1fr),
        columns: 1fr,
        column-gutter: 0.5em,
        inset: 0.5em,
        {
          text(fill: self.colors.primary, weight: "bold", [研究方向])
          linebreak()
          h(1em)
          core-research
        },
        {
          text(fill: self.colors.primary, weight: "bold", [作者])
          linebreak()
          h(1em)
          authors
        },
        {
          text(fill: self.colors.primary, weight: "bold", [机构])
          linebreak()
          h(1em)
          institution
        },
      ),
    ),
    block(
      stroke: (paint: self.colors.primary, thickness: 1pt),
      width: 100%,
      grid(
        inset: (x: 1em, y: 0.5em),
        columns: (auto, auto, 1fr, auto),
        column-gutter: 1em,
        text(fill: self.colors.primary, [期刊: ]) + linebreak() + journal,
        text(fill: self.colors.primary, [分区: ]) + linebreak() + quartile,
        text(fill: self.colors.primary, [影响因子: ]) + linebreak() + impf,
        text(fill: self.colors.primary, [发表时间: ]) + linebreak() + pub-date,
      ),
    ),
  )
}

#let article-title(
  article-fig: none,
  core-research: none,
  authors: none,
  institution: none,
  journal: none,
  quartile: none,
  impf: none,
  pub-date: none,
) = touying-fn-wrapper(_article-title.with(
  article-fig: article-fig,
  core-research: core-research,
  authors: authors,
  institution: institution,
  journal: journal,
  quartile: quartile,
  impf: impf,
  pub-date: pub-date,
))

#let _horz-block(self: none, ..items) = {
  let content-list = items.pos()
  grid(
    columns: (1fr,) * content-list.len(),
    align: center + horizon,
    column-gutter: 0.5em,
    inset: (x: 0.5em, y: 1em),
    stroke: (paint: self.colors.primary-light, thickness: 1pt),
    ..content-list
  )
}

#let horz-block(..items) = touying-fn-wrapper(
  _horz-block.with(..items),
)
