// ============================================================================
// 体系结构 · 第一次作业
//
// 编译（在仓库根目录）：
//     typst compile mine/architecture/hw01.typ
//
// 若不在 devShell 内，需显式指定项目根：
//     typst compile --root . mine/architecture/hw01.typ
// ============================================================================

#import "../../lib.typ": hw

#show: hw.ucas-hw-theme.with(
  course: [计算机体系结构],
  name: [张三], // TODO: 改成你的名字
  student-id: [2024E8012345678], // TODO: 改成你的学号
)

#hw.hw-title(
  [第一次作业],
  subtitle: [定量分析基础],
  note: [提交时间：待定],
)

= 习题一　性能指标

#hw.hw-problem(
  number: [第 1 题],
  title: [CPU 时间与 CPI],
)[
  某程序在 2 GHz 的处理器上运行，共执行 $1.2 times 10^9$ 条指令，
  平均时钟周期数（CPI）为 1.5。

  + 求该程序的 CPU 执行时间；
  + 若把时钟频率提高到 3 GHz 而 CPI 不变，执行时间变为多少？
  + 若想在不提高频率的前提下把执行时间缩短 20%，CPI 需降到多少？
]

*解答.*

由 $T_"cpu" = "指令数" times "CPI" slash f$：

$ T_"cpu" = (1.2 times 10^9 times 1.5) / (2 times 10^9) = 0.9 upright("s") $

频率提到 3 GHz 后：

$ T_"cpu"' = (1.2 times 10^9 times 1.5) / (3 times 10^9) = 0.6 upright("s") $

执行时间缩短 20% 即变为 $0.9 times 0.8 = 0.72$ s，故

$ "CPI"' = (0.72 times 2 times 10^9) / (1.2 times 10^9) = 1.2 $

= 习题二　Amdahl 定律

#hw.hw-problem(
  number: [第 2 题],
  title: [加速比的上限],
)[
  某程序中 40% 的执行时间可以并行化。若把该部分加速 10 倍，
  整体加速比是多少？理论上限又是多少？
]

*解答.*

设串行部分为 $1 - p$、并行部分为 $p$，则整体加速比为

$ S = 1 / ((1 - p) + p slash n) $

代入 $p = 0.4$、$n = 10$：

$ S = 1 / (0.6 + 0.4 slash 10) = 1 / 0.64 approx 1.56 $

当 $n -> infinity$ 时得到上限 $S_max = 1 slash (1 - p) = 1 slash 0.6 approx 1.67$。

#hw.hw-note(title: [注意])[
  Amdahl 定律假设问题规模固定。若问题规模随处理器数量增长，则适用
  Gustafson 定律，上限结论会不同。
]

= 习题三　存储层次

#hw.hw-problem(
  number: [第 3 题],
  title: [平均访存时间],
)[
  某系统 L1 命中时间为 1 个时钟周期，命中率 95%；缺失时的访存开销为
  50 个时钟周期。求平均访存时间（AMAT）。
]

*解答.* 由 $"AMAT" = "命中时间" + "缺失率" times "缺失开销"$：

$ "AMAT" = 1 + 0.05 times 50 = 3.5 upright("周期") $

可见即使命中率高达 95%，平均访存时间仍是命中时间的 3.5 倍——
这正是存储层次设计要着力降低缺失率与缺失开销的原因。