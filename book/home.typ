#import "book.typ": book-page

#show: book-page.with(title: "Home")

= 計算物理 春の学校 2026 — Julia 入門

このサイトは「計算物理 春の学校 2026 — Julia 入門」の講義ノートです。

== 講師

品岡 寛（埼玉大学 大学院理工学研究科）

- GitHub: #link("https://github.com/shinaoka")[shinaoka]
- 研究・開発：計算物理・量子多体・凝縮系（実装を伴う研究 OSS）
- 代表的 OSS：`SparseIR.jl`（Julia）/ `sparse-ir`（Python）/ `TensorCrossInterpolation.jl` など
- 言語：Julia, Python, Rust, C++/C, Fortran...
- 最近の活動：#link("https://tensor4all.org")[tensor4all.org]、Rust による計算物理エコシステム構築
- 一次情報：#link("https://shinaoka.github.io")[shinaoka.github.io]

== なぜ Julia？

=== 得意なこと

- *OSS*：誰でも入手・配布・改善でき、教育でも環境を揃えやすい（対比：MATLAB は強力だが商用）
- *コミュニティの道具箱*：微分方程式、可視化、最適化、自動微分…パッケージが豊富
- *パッケージシステム*：パッケージを簡単にインストール・配布可能
- *速いコードも書ける*：JIT + 型情報で最適化しやすい
- *ガーベージコレクション*：自動でメモリ管理（`segmentation fault` が起きにくい）

=== 苦手なこと

- *最高速追求の難しさ*：GC のため、細粒度の並列計算で遅くなりやすい
- *大規模開発の難しさ*：動的型付けゆえ、設計・保守コスト増
- *他言語からの再利用の難しさ*：Python 以外は現状ハードル高め

=== 現状についての個人的な見解

- 人間とのインターフェースとしての強みがある。ただし、生成 AI の発展により人間とのインターフェースは段々不要になってきている
- 大規模案件では他言語連携の検討が必要（例：Rusty Julia）。Julia で全部エコシステムを作ろうという試みがあるが、個人的には必要ないと思う

== 講義の概要

LLM（GitHub Copilot など）を *相棒* にしながら Julia プログラミングの基礎を学びます。「自分で全部書く」のではなく「LLM と協働しながら、コードの設計意図を読み書きできる」ことを目指します。

最近の AI コーディングエージェントの発展は素晴らしいので、その利用を前提に進めます。AI エージェントを操るのに十分な基礎知識を身につけることが目標です。

== トピック

+ *受講前提とゴール* — 環境構築・事前準備
+ *まずは GitHub を使ってみよう* — リポジトリの fork・clone・push
+ *プロジェクト環境とは？* — `Project.toml` と再現可能な環境管理
+ *Julia の抽象化を読めるように* — 型・多重ディスパッチ・broadcast
+ *性能評価と改善サイクル* — `@btime` によるベンチマークと最適化
+ *演習：binning で π の推定精度を評価する* — Accumulator 構造体の設計と統計処理
+ *発展演習：2次元イジング模型のモンテカルロ法* — 相転移の観察と自己相関
+ *発展課題：パッケージとは？作り方は？* — パッケージ化と CI

左の sidebar の "Topics" を上から順に読み進めてください。

== リンク

- 講義ノートのソースコード：#link("https://github.com/shinaoka/julia_spring_school_2026")[GitHub リポジトリ]
- サンプルコード（受講者が fork して使う）：#link("https://github.com/shinaoka/julia_spring_school_2026_sample")[サンプルリポジトリ]
