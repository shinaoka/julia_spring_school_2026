#import "../book.typ": book-page

#show: book-page.with(title: "性能評価と改善サイクル")

= 性能評価と改善サイクル

狙いは、計測の落とし穴を避けつつ、LLM と一緒に「改善→再計測→共有」を回すことです。

== ここで扱うこと

- JIT：最初が遅い／型で specialize される
- BenchmarkTools：`@btime` と `$` 補間
- 題材Aの復習：プロジェクト環境と `instantiate` の意識
- 「遅いコード」を高速化：提案→適用→再計測→コミット

== 最後に残す問い

*いま測っているのは「プログラムのどの時間」？（コンパイル？実行？）*
