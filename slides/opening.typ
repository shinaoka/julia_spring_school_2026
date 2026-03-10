#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [計算物理学のための Julia 入門],
    subtitle: [良い AI 開発をJuliaで学ぶ],
    author: [H. Shinaoka],
    date: [Spring 2026],
    institution: [Julia Spring School 2026],
  ),
  config-colors(
    primary: rgb("#eb811b"),
    primary-light: rgb("#d6c6b7"),
    secondary: rgb("#23373b"),
    neutral-lightest: white,
    neutral-darkest: rgb("#23373b"),
  ),
  config-page(fill: white),
  footer: context {
    let slides = query(heading.where(level: 2))
    let cur = here().page()
    let next = slides.filter(h => h.location().page() > cur)
    if next.len() > 0 [
      #text(size: 0.75em, fill: gray)[Next: #next.first().body]
    ]
  },
)

#set text(font: "Hiragino Sans")
#set par(justify: false)

#let hl(body) = text(fill: rgb("#cc0000"), body)
#let muted(body) = text(size: 0.84em, fill: rgb("#667085"))[#body]

#title-slide()

== よくある AI の使い方

#text(size: 0.92em, fill: rgb("#475467"))[
  みんな ChatGPT でこういうことをやっていないか？
]

#v(0.2em)

#align(center)[
  #image("../book/figures/ai-development-bad.svg", width: 98%)
]

#v(0.05em)

#align(center)[
  #text(size: 0.82em, fill: rgb("#475467"))[
    質問 -> 即コード -> とりあえず実行 -> なんとなく前進
  ]
]

== しかし研究では、これでは足りない

#text(size: 0.9em, fill: rgb("#475467"))[
  計算物理では、コードも研究ワークフローの一部。
  必要なのは、指示の一発勝負ではなく、設計・実装・実行・検証・解釈のループ。
]

#v(0.15em)

#align(center)[
  #image("assets/ai-development-good-slide.svg", width: 100%)
]

#v(0.1em)

#align(center)[
  #text(size: 0.82em)[#hl[ブレーンストーミング (BS)を通じてベストプラクティスを学ぶ + ループの高速化]]
]

== Julia はその題材である

- 小規模な数値計算コードなら、Julia では手軽に速いコードを書きやすい
- 配列、関数、型、環境管理、テストまで一通り触れられる
- AI と協調しながら計算コードを育てる題材としてちょうどよい

#v(1.0em)

#align(right)[
  #muted([なお私は最近、Julia と Rust を組み合わせる "Rusty Julia" の方向を目指している。])
]

== 講義の進め方

- 2次元イジングモデルを、AI と一緒に step ごとに構築する
- 各 step では、短い execution spell で実行し、その直後に explanation spell で理解する
- セッション 1 では環境構築からメトロポリス更新まで進む
- セッション 2 では構造化、性能計測、温度スキャン、プロットまで扱う

#v(0.7em)

#table(
  columns: (auto, 1fr),
  stroke: none,
  row-gutter: 0.45em,
  [*Session 1*], [環境の作成、格子の初期化、物理量の計算、メトロポリス更新],
  [*Session 2*], [構造化、パフォーマンス計測と最適化、温度スキャン、可視化],
)
