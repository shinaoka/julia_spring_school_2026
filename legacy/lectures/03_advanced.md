## 講義3（80分）応用：高速化（計測・型安定性・並列）とRust連携（FFI）

この回のゴールは「遅いときに何を見て、どう直すか」と「必要なら他言語資産（Rust）に繋ぐ」ための入口を作ることです。

### 1. まず計測（BenchmarkTools）（20分）

Juliaは **“計測しない最適化”が危険** です。まずは現状を測ります。

（サンプルは `code/julia_intro/examples/04_perf.jl`）

ポイント:

- `@time` は入門向け（コンパイル時間も混ざる）
- 本格的には `BenchmarkTools.@btime`（ウォームアップ後の安定計測）

### 2. 型安定性と割り当て（25分）

見るもの:

- `@code_warntype f(args...)`（赤くなる＝型が不安定）
- `@allocated f(args...)`（割り当てが多い＝遅くなりやすい）

典型パターン:

- グローバル変数を避ける（関数引数にする）
- ループ内での一時配列生成を避ける（in-place、ビュー、事前確保）
- `AbstractVector`で受けつつ、中で具体型に落ちるように書く

### 3. 並列（スレッド）の入口（15分）

- `Threads.@threads` は入口として便利
- ただし「依存関係」「乱数」「縮約」の扱いに注意

（サンプルは `code/julia_intro/examples/05_threads.jl`）

### 4. Rust連携（FFI）の最小例（20分）

JuliaはC ABIで外部関数を呼べます。Rustは `cdylib` としてビルドして `ccall` で呼ぶのが最小構成です。

この資料では `code/rust_ffi/` に最小例を置きます:

- `code/rust_ffi/rust/`: Rust側（`cdylib`）
- `code/rust_ffi/julia/`: Julia側（`ccall`）

狙い:

- 既存のRust資産（数値計算、パーサ、I/O等）を“必要な所だけ”Juliaから使う
- ただし **最初からRustで書くのではなく、まずJuliaで正しく書いてから** ボトルネックだけ置き換える

--- 

### 付録: 参考（短いメモ）

- 性能Tips: 「関数の中で」「型安定に」「割り当てを減らす」
- プロファイル: `Profile`（標準）や外部ツール（必要になってから）

