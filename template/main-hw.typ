// ============================================================================
// 中国科学院大学作业纸 —— 起始文件
//
// 作业纸主题与 slides 主题共用同一个包，但符号在 `hw` 命名空间下导出：
//     #import "@preview/ucas-slide:0.1.0": hw
// 编译方式：
//     typst compile main-hw.typ
// ============================================================================

#import "@preview/ucas-slide:0.1.0": hw

#show: hw.ucas-hw-theme.with(
  course: [机器学习基础],
  name: [张三],
  student-id: [2024E8012345678],
)

#hw.hw-title(
  [第一次作业：线性回归与梯度下降],
  subtitle: [第 1 章　线性模型],
  note: [提交时间：2026 年 9 月 20 日 23:59 前],
)

= 习题一　最小二乘法的闭式解

#hw.hw-problem(
  number: [第 1 题],
  title: [正规方程],
)[
  给定 $n$ 个训练样本 $(bold(x)_i, y_i)$，$i = 1, dots, n$，其中
  $bold(x)_i in RR^d$、$y_i in RR$。记
  $bold(X) = (bold(x)_1, dots, bold(x)_n)^top$，
  $bold(y) = (y_1, dots, y_n)^top$。试推导使平方误差
  $L(bold(w)) = 1/2 sum_(i=1)^n (y_i - bold(x)_i^top bold(w))^2$
  最小的最优参数 $bold(w)^*$ 的闭式解。
]

*解答.* 对 $L$ 求梯度并令其为零：

$ nabla L(bold(w)) = bold(X)^top (bold(X) bold(w) - bold(y)) = bold(0), $

整理即得正规方程 $bold(X)^top bold(X) bold(w) = bold(X)^top bold(y)$。

= 习题二　梯度下降的收敛性

#hw.hw-problem(
  number: [第 2 题],
  title: [学习率的选取],
)[
  设目标函数为凸函数，且其梯度满足 $L$-Lipschitz 连续条件。试说明当步长
  $eta <= 1/L$ 时梯度下降法是收敛的，并给出相应的收敛速率。
]

*解答.* 由 $L$-Lipschitz 连续性可得下降引理，因此当 $0 < eta <= 1/L$ 时
目标函数单调不增；进一步结合凸性可得收敛速率 $O(1\/k)$。

= 习题三　编程实现

#hw.hw-problem(
  number: [第 3 题],
  title: [实现批梯度下降],
)[
  请使用 Python 实现批梯度下降，并在给定数据集上绘制损失随迭代次数的变化曲线，
  与闭式解的结果进行对比。
]

*解答.* 关键代码如下：

```python
import numpy as np

def bgd(X, y, lr=0.01, epochs=1000):
    n, d = X.shape
    w = np.zeros(d)
    for _ in range(epochs):
        grad = X.T @ (X @ w - y) / n
        w -= lr * grad
    return w
```

#hw.hw-note(title: [提交要求], color: hw.ucas-flag-blue)[
  代码文件命名为 `学号_姓名_hw1.ipynb`，与本次作业的 PDF 一起打包提交。
]