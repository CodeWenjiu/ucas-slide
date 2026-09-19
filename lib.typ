// @preview/ucas-slide 的入口文件。
//
// 演示文稿主题的符号直接再导出，所以文档里可以简单地写：
//
//     #import "@preview/ucas-slide:0.1.0": *
//
// 作业纸主题则放在 `hw` 命名空间下再导出。两个文件都定义了 ucas-blue、
// ucas-red、Ucas-logo-* 等同名常量，而 Typst 的 `*` 导入遇到重名只会静默
// 覆盖，所以这里必须把它们隔开：
//
//     #import "@preview/ucas-slide:0.1.0": hw
//
// Typst 不允许直接导入包内的子文件（`@preview/ucas-slide:0.1.0/x.typ`
// 是无效语法），因此所有对外符号都要经由本文件暴露。

#import "ucas-slide.typ": *
#import "ucas-hw.typ" as hw