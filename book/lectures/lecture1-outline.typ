#import "../book.typ": book-page

#show: book-page.with(title: "講義回アウトライン（旧）")

= 講義回アウトライン（旧）

このページは講義回（コマ）ベースの下書きです。現在の本体は sidebar の "Topics" を正とします。

== 前提とゴール

- 前提
  - Git / GitHub の基礎操作（前日講義でカバー済み）
  - GitHub アカウント
  - Julia / VS Code をインストール可能
- ゴール
  - LLM を相棒に Julia コードを書かせ・読めるようになる
  - 抽象化（関数・型・broadcast）の旨味を体感する
  - プロジェクト環境と GitHub の入り口を経験する

== 第 1 コマ（1.5h）：LLM + Julia を触ってみる

- テーマ：π のモンテカルロ計算で「なんとなく使える」まで
- 構成
  - 導入・環境確認
  - LLM に π 推定コードを書かせて動かす
  - サンプリング数 vs 精度を評価させる
  - 高速化案を出させる（軽い計測）

== 第 2 コマ（1.5h）：抽象化・型・broadcast の意味を理解する

- 前回の π コードを題材に回収
  - 関数化（`estimate_pi(N)`）
  - Julia 基本文法（最小セット）
  - 多重ディスパッチの入り口
  - for ループと broadcast の対応

== 第 3 コマ（1h）：JIT と BenchmarkTools、プロジェクト環境・GitHub

- JIT のざっくり説明（最初が遅い／型で specialize）
- BenchmarkTools の基本（`@btime` と `$` 補間）
- GitHub ワークフロー（Fork → Clone → Activate → 改善 → Push）
- 題材：別プロジェクトの「遅いコード」を LLM と高速化して反映

== 備考

- 詳細は `abstract.md` に集約（後で Typst へ移植）
