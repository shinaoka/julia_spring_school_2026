## 講義1（80分）基本 + ベンチ（BenchmarkTools / FLOPs）

### この回のゴール

- Project環境でコードを動かす
- `A*B`や`sin.(x)`の速度感を測り、**FLOPs/GFLOPs**の直観を持つ
- Juliaの基本（配列・関数・多重ディスパッチ）に入る

### 使うProject（通し番号）

- `projects/01_linalg_bench/`: 行列積ベンチ（BenchmarkTools、FLOPs）
- `projects/02_broadcast_bench/`: `sin.(x)`ベンチ（BenchmarkTools、broadcast）
- `projects/03_core_basics/`: 基礎文法・配列
- `projects/04_functions_dispatch/`: 関数・多重ディスパッチ

### 0. まず動かす（Project環境）

（例）`projects/01_linalg_bench/`：

```julia
using Pkg
Pkg.activate("projects/01_linalg_bench")
Pkg.instantiate()
Pkg.test()
```

Notebook標準: `projects/01_linalg_bench/notebook.ipynb` を開く。

### 1. 線形代数ベンチ：行列積で速度感（BenchmarkTools + FLOPs）

`projects/01_linalg_bench/` を使う。

- `BenchmarkTools.@btime` の作法（`$`補間）
- `A*B` の実測
- FLOPs/GFLOPs（目安 \(2n^3\) ）の概念

### 2. broadcastの速度感：`sin.(x)`

`projects/02_broadcast_bench/` を使う。

- `sin.(x)` を測る（要素/秒）
- dot/broadcastの直観

### 3. 基本：配列と制御構文（最低限）

`projects/03_core_basics/` を使う。

- 配列、range、for/if
- viewとコピーの違い（軽く）

### 4. 関数と多重ディスパッチ

`projects/04_functions_dispatch/` を使う。

- 関数定義
- メソッド追加（`f(::Int)`など）

### 5. 予告：GC / allocation

allocation/GCの詳説は講義3で扱う（「なぜallocationを減らすと効くか」もそこで回収）。

