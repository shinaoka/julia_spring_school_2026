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

Julia：人間とのインターフェースとしての強み。
大規模案件：他言語連携の検討（例：Rusty Julia）。


---

## この講義の方針

- Juliaの基本を学ぶ
- 正しくプロジェクトを管理する
- 最適化

最近のAIコーディングエージェントの発展は素晴らしいので, その利用を前提に進めます.

--- 

## 目次: lecture 1

- 型とはなにか？動的型づけとは？ (C++との比較)
- 関数とはなにか？多重ディスパッチとは？
- JuliaのJITコンパイル
- 構造体とはなにか？

---

## 型とはなにか？（Juliaの「動的型づけ」）

- **変数に型**ではなく、**値に型**がつく
- 関数は「入力の型」に応じて最適化されうる
- 型は性能と表現力の両方に効く

---

## 型とはなにか？（C++との比較・イメージ）

- C++：`int x`（変数が型を持つ）
- Julia：`x = 1`（値 `1::Int` が型を持つ）
- Juliaでも **局所変数は `x::Float64` のように型を制約**できる

```julia
x = 1          # Int
x = 1.0        # Float64 に置き換わる（変数の型固定ではない）

y::Float64 = 1.0 # Float64 に型を制約できる
y = 1.0 + 2.0im # InexactError（Float64へ変換できない）
```

柔軟な記述と静的型付けのメリットの両立

---

## 関数とはなにか？（メソッドの集合）

- Juliaの「関数」は **メソッドの集合**
- 引数の型に応じて **多重ディスパッチ**で呼び分け
- 「型 × 振る舞い」の設計が自然

---

## 多重ディスパッチ（最小例）

```julia
f(x::Int) = x + 1
f(x::Float64) = x + 0.5

f(1)    # Int用
f(1.0)  # Float64用
```

---

## JuliaのJITコンパイル（なにが起きる？）

- 最初の呼び出しで **コンパイル**（遅い）
- 2回目以降は **最適化済みコード**（速い）
- なので、計測は **ウォームアップ後**が基本

---

## JITと計測（BenchmarkToolsの意味）

- “一回だけ実行” はコンパイル時間が混ざりがち
- `@btime` は **繰り返して安定した時間**を測る（＋`$`補間）

（→ `projects/01_linalg_bench/`, `projects/02_broadcast_bench/` で体験）

---

## 構造体とはなにか？（データのまとまり）

- 名前のある「型」を自分で作る仕組み
- フィールド（属性）をまとめ、意味を持たせる
- 型がはっきりすると、コードも速く・安全に

---

## 構造体（最小例）

```julia
struct Particle
    x::Float64
    v::Float64
end

p = Particle(0.0, 1.0)
```

---

## 使うProject（通し番号）

- `projects/01_linalg_bench/`: 行列積ベンチ（BenchmarkTools、FLOPs）
- `projects/02_broadcast_bench/`: `sin.(x)`ベンチ（BenchmarkTools、broadcast）
- `projects/03_core_basics/`: 基礎文法・配列
- `projects/04_functions_dispatch/`: 関数・多重ディスパッチ

---

## 0. まず動かす（Project環境）

例：`projects/01_linalg_bench/`

```julia
using Pkg
Pkg.activate("projects/01_linalg_bench")
Pkg.instantiate()
Pkg.test()
```

Notebook標準：各Projectの `notebook.ipynb` を開く。

---

## 1. 線形代数ベンチ：行列積（BenchmarkTools + FLOPs）

使うProject：`projects/01_linalg_bench/`

- `BenchmarkTools.@btime` の作法（`$`補間）
- `A*B` の実測
- FLOPs/GFLOPs（目安 \(2n^3\) ）の概念

---

## 2. broadcastの速度感：`sin.(x)`

使うProject：`projects/02_broadcast_bench/`

- `sin.(x)` を測る（要素/秒）
- dot/broadcastの直観

---

## 3. 基本：配列と制御構文（最低限）

使うProject：`projects/03_core_basics/`

- 配列、range、for/if
- viewとコピーの違い（軽く）

---

## 4. 関数と多重ディスパッチ

使うProject：`projects/04_functions_dispatch/`

- 関数定義
- メソッド追加（`f(::Int)`など）

---

## 5. 予告：GC / allocation

allocation/GCの詳説は講義3で扱う（「なぜallocationを減らすと効くか」もそこで回収）。

