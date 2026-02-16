---
marp: true
paginate: true
---

# 講義1（80分）

基本 + ベンチ（BenchmarkTools / FLOPs）

---

## 自己紹介：品岡 寛

- **所属**: 埼玉大学学術院・大学院理工学研究科
- **GitHub**: `https://github.com/shinaoka`
- **研究/開発**: 計算物理・量子多体・凝縮系（実装を伴う研究OSS）
- **代表的OSS（例）**:
  - `SparseIR.jl`（Julia） / `sparse-ir`（Python）/ `sparse-ir-rs`（Rust）
  - `DCore`（DMFT software）
  - `TensorCrossInterpolation.jl`（Julia）
  - `CT-HYB` / `SpM` など
- **言語**: Julia, Python, Rust, C++/C, Fortran...
- **最近の活動**: `https://tensor4all.org`, Rustによる計算物理エコシステム構築
- **補足（一次情報）**: `https://shinaoka.github.io`

---

## Juliaの得意なこと

- **OSS**：誰でも入手・配布・改善でき、教育でも環境を揃えやすい（対比：MATLABは強力だが商用）
- **コミュニティの道具箱**：微分方程式、可視化、最適化、自動微分…パッケージが豊富
- **パッケージシステム** : パッケージを簡単にインストール・配布可能
- **速いコードも書ける**：JIT + 型情報で最適化しやすい
- **ガーベージコレクション**: 自動でメモリ管理を行う (`segmentation fault` が起きにくい)

--- 

## Juliaが苦手なこと


- **最高速追求の難しさ**：GCのため、細粒度の並列計算で遅くなりやすい
- **大規模開発の難しさ**：動的型付けゆえ、設計・保守コスト増
- **他言語からの再利用の難しさ**：Python以外は現状ハードル高め

---

## 私が思うJuliaの現状

* 人間とのインターフェースとしての強み。ただ, 生成AIが発展し, 人間とのインターフェースは段々不要になってきている.
* 大規模案件：他言語連携の検討（例：Rusty Julia）。 Juliaで全部エコシステムを作ろうという試みがあるが, 個人的には必要ないと思う.

---

## この講義の方針

- Juliaの基本を学ぶ
- 正しくプロジェクトを管理する
- 最適化

最近のAIコーディングエージェントの発展は素晴らしいので, その利用を前提に進めます.

AIエージェントを操るのに十分な基礎知識を身につけることが目標. 自分で今後成長していけるように.

--- 

## 目次: lecture 1

- 型とはなにか？動的型づけとは？ (C++との比較)
- 抽象型 / 具体型 / 型階層
- 構造体 / parametric type
- mutable / immutable / reference / GC
- 関数とはなにか？多重ディスパッチとは？
- JuliaのJITコンパイル
