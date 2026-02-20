#import "book.typ": book-page

#show: book-page.with(title: "Home")

= 計算物理 春の学校 2026 — Julia 入門

このサイトは「計算物理 春の学校 2026 — Julia 入門」の講義ノートです。

== 講義の概要

LLM（GitHub Copilot など）を *相棒* にしながら Julia プログラミングの基礎を学びます。「自分で全部書く」のではなく「LLM と協働しながら、コードの設計意図を読み書きできる」ことを目指します。

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
