# UCAS 标识版权声明 / UCAS Logo Copyright Notice

[中文](#中文) | [English](#english)

---

## 中文

### 版权归属

本包中位于 `ucas_fig/` 目录下的中国科学院院徽、中国科学院大学校徽/标准字等
视觉标识（下称“标识”）**不在本项目的 MIT 许可证覆盖范围内**。
这些标识的版权归**中国科学院**及**中国科学院大学**所有。

### 涉及的文件

`ucas_fig/` 目录下所有包含院徽、校徽、标准字、校训与书法字样的图片，
例如：

- `中国科学院院徽.png`、`中国科学院院徽（白色）.png`
- `中国科学院院徽（白色）-水印.png`、`中国科学院院徽（白色）-半透明.svg`
- `国科大标准Logo横式一（蓝色）.png`、`国科大标准Logo横式一（白色）.png`
- `国科大标准Logo横式二（蓝色）.png`、`国科大标准Logo横式二（白色）.png`
- `国科大标准Logo横式三.png`、`国科大标准Logo竖式（蓝色）.png` 等
- `国科大书法字（红色）.png`、`国科大书法字（白色）.png`、`国科大校训.png`

### 使用限制与合理使用

根据校方公开发布的声明，形象标识的版权归中国科学院及中国科学院大学所有，
未经批准或授权不得擅自使用，否则视为侵权；**为个人学习使用以及课堂教学使用
等合理使用的情况除外**。

本模板作为学术报告与作业排版工具，属于个人学习与课堂教学的合理使用范畴。
若需将相关标识用于其他用途，请自行联系校方相关部门取得授权。

### 免责声明

使用者应自行了解并遵守相关版权法律法规。因违规使用上述标识而产生的法律
责任，由使用者自行承担。

### 不想使用官方标识？

主题中所有涉及标识的位置都可以替换：

- **封面 / 章节页的水印与徽标**：修改 `ucas-slide.typ` 顶部的
  `ucas-logo-white`、`ucas-badge-watermark`、`ucas-badge-white-trans`
  等变量，指向你自己的图片即可。
- **页眉的校名标识**：修改 `ucas-logo-blue`。
- **作业纸的水印与页脚**：`ucas-hw-theme` 的 `watermark`、`header-logo`、
  `footer-logo` 参数均可传入自定义路径。

---

## English

### Copyright Ownership

The visual identity elements of the Chinese Academy of Sciences and the
University of Chinese Academy of Sciences (UCAS), located in the `ucas_fig/`
directory, are **NOT covered by the MIT License** that applies to the rest of
this project. Their copyright belongs to the **Chinese Academy of Sciences**
and the **University of Chinese Academy of Sciences**.

### Affected Files

All images in `ucas_fig/` that contain the CAS emblem, the UCAS logo, the
official logotype, the university motto, or the calligraphic wordmark.
See the Chinese section above for an itemized list.

### Permitted Use

According to the official statement of the university, these identity elements
may not be used without authorization; **use for personal study and classroom
teaching is considered reasonable use and is permitted**.

This template serves as a tool for academic presentations and homework
typesetting, which falls under personal study and classroom teaching. For any
other use, please obtain authorization from the university.

### Disclaimer

Users are responsible for understanding and complying with applicable copyright
laws. Any liability arising from unauthorized use of these identity elements
rests with the user.

### Want to avoid the official logos?

Every place a logo appears can be overridden: rebind `ucas-logo-white`,
`ucas-logo-blue`, `ucas-badge-watermark`, `ucas-badge-white-trans` in
`ucas-slide.typ`, or pass custom paths to `ucas-hw-theme`'s `watermark`,
`header-logo` and `footer-logo` parameters.