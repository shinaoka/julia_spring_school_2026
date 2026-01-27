// lecture1.typ (slydst version)
// Based on `lecture1.marp.md`

#import "@preview/slydst:0.1.5": *
#import "@preview/zebraw:0.6.1": *

#show: slides.with(
  title: "講義1（80分）",
  subtitle: "基本 + ベンチ（BenchmarkTools / FLOPs）",
  date: none,
  authors: ("Hiroshi Shinaoka",),
  layout: "medium",
  ratio: 16/9,
  title-color: none,
)

// Add a bit more space below each slide title (level-2 heading).
#show heading.where(level: 2): it => [
  #it
  #v(0.6em)
]

#set text(
  font: (
    "Hiragino Sans",
    "BIZ UDGothic",
    "YuGothic",
    "Apple SD Gothic Neo",
  ),
  size: 1.25em,
)

#show raw: set text(
  font: (
    "Menlo",
    "Monaco",
  ),
)

#show raw.where(block: true): set text(size: 0.85em)

#set raw(theme: auto)
#show: zebraw.with(..zebraw-themes.zebra)

#let code(lang, src) = raw(src, lang: lang, block: true)

= 導入

== 自己紹介：品岡 寛

- *所属*: 埼玉大学学術院・大学院理工学研究科
- *GitHub*: `https://github.com/shinaoka`
- *研究/開発*: 計算物理・量子多体・凝縮系（実装を伴う研究OSS）
- *代表的OSS（例）*:
  - `SparseIR.jl`（Julia） / `sparse-ir`（Python）/ `sparse-ir-rs`（Rust）
  - `DCore`（DMFT software）
  - `TensorCrossInterpolation.jl`（Julia）
  - `CT-HYB` / `SpM` など
- *言語*: Julia, Python, Rust, C++/C, Fortran...
- *最近の活動*: `https://tensor4all.org`, Rustによる計算物理エコシステム構築
- *補足（一次情報）*: `https://shinaoka.github.io`

== Juliaの得意なこと

- *OSS*: 誰でも入手・配布・改善でき, 教育でも環境を揃えやすい（対比：MATLABは強力だが商用）
- *コミュニティの道具箱*: 微分方程式, 可視化, 最適化, 自動微分…パッケージが豊富
- *パッケージシステム*: パッケージを簡単にインストール・配布可能
- *速いコードも書ける*: JIT + 型情報で最適化しやすい
- *ガーベージコレクション*: 自動でメモリ管理（`segmentation fault` が起きにくい）

== Juliaが苦手なこと

- *最高速追求の難しさ*: GCのため, 細粒度の並列計算で遅くなりやすい
- *大規模開発の難しさ*: 動的型付けゆえ, 設計・保守コスト増
- *他言語からの再利用の難しさ*: Python以外は現状ハードル高め

== 私が思うJuliaの現状

- 人間とのインターフェースとしての強み. ただ, 生成AIが発展し, 人間とのインターフェースは段々不要になってきている. 
- 大規模案件：他言語連携の検討（例：Rusty Julia）. Juliaで全部エコシステムを作ろうという試みがあるが, 個人的には必要ないと思う. 
- そのうち, 生成AIが操るツールの1つになるのではないかと考えている. 

== この講義の方針

- Juliaの基本を学ぶ
- 正しくプロジェクトを管理する
- 最適化

最近のAIコーディングエージェントの発展は素晴らしい. 
AIエージェントを操るのに十分な基礎知識を身につけることが目標. 自分で今後成長していけるように. 

== Outline

#outline()

= 型

== 型とはなにか？（Juliaの「動的型づけ」）

- *変数に型*ではなく, *値に型*がつく
- 関数は「入力の型」に応じて最適化されうる
- 型は性能と表現力の両方に効く

== 型とはなにか？（C++との比較・イメージ）

- C++：`int x`（変数が型を持つ）
- Julia：`x = 1`（値 `1::Int` が型を持つ）
- Juliaでも *局所変数*は `x::Float64` のように型を制約できる

#code("julia", "x = 1          # Int\nx = 1.0        # Float64 に置き換わる（変数の型固定ではない）\n\ny::Float64 = 1.0 # Float64 に型を制約できる (Pythonでは不可)\ny = 1.0 + 2.0im # InexactError（Float64へ変換できない）\n")

柔軟な記述と静的型付けのメリットの両立

== 抽象型と具体型

- *具体型（concrete type）*: 実体（値）を持てる型（例：`Int64`, `Float64`, `Vector{Float64}`）
- *抽象型（abstract type）*: 分類ラベル（値そのものは作れない）（例：`Number`, `Real`, `AbstractFloat`）
- Juliaの「継承」＝ *部分型関係*（`<:`）
  - `Any` は全ての型のスーパータイプ（一番上）

#code("julia", "isabstracttype(Number)   # true\nisconcretetype(Float64)  # true\ntypeof(1.0)              # Float64\n")

== 代表的な型階層（例）

#code("text", "Any\n└─ Number\n   └─ Real\n      └─ AbstractFloat\n         └─ Float64\n")

ポイント：自作型で「分類」を作るときは `abstract type` を使う（`struct` は通常その下に置く）

= 構造体とデータ

== 構造体とはなにか？

- 名前のある「型」を自分で作る仕組み
- フィールド（属性）をまとめ, 意味を持たせる
- 型がはっきりすると, コードも速く・安全に

== 構造体（最小例）

#code("julia", "struct Square\n    side_length::Float64  # 辺の長さ\nend\n\nstruct Circle\n    radius::Float64       # 半径\nend\n\nSquare(2.0).side_length  # 2.0\nCircle(1.0).radius       # 1.0\n")

ポイント：*データの塊に名前と型を与える*（設計が明確に, 最適化もしやすく）. 

== Parametric type（パラメトリック型）

- `Vector{Float64}` の `{Float64}` のように, 型にパラメータを持たせられる
- 目的：実装の重複を防ぎつつ, 要素型などの情報を型に埋め込む → 速いコードになりやすい
- `SquareGeneric{Float64}` と `SquareGeneric{Int64}` は *別の具体型（別の型）*

#code("julia", "struct SquareGeneric{T<:Real}\n    side_length::T\nend\n\nSquareGeneric(2.0)    # SquareGeneric{Float64}\nSquareGeneric(2)      # SquareGeneric{Int64}\n")

= mutable / reference / GC

== Immutable, Mutable

- Juliaでは型（type）自体に「mutable / immutable」の違いがある
- `struct` はデフォルトで *immutable（不変）な型*を定義（`p.x = ...` は不可）
- `mutable struct` は *mutable（可変）な型*を定義（フィールド更新が可能）
- `Array` は mutable（`a[i] = ...` ができる）

#code("julia", "ismutabletype(Int64)       # false\nismutabletype(Float64)     # false\nismutabletype(Vector{Int}) # true\n")

== Immutable / Mutable（最小例）

#code("julia", "struct Point\n    x::Float64\n    y::Float64\nend\n\nmutable struct MPoint\n    x::Float64\n    y::Float64\nend\n\np = Point(1.0, 2.0)   # p.x = 3.0 はエラー\nmp = MPoint(1.0, 2.0) # mp.x = 3.0 はOK\n")

== Reference（参照）と aliasing（共有）

#code("julia", "# mutableの例（配列：共有される）\na = [1, 2, 3]\nb = a          # 参照のコピー（同じ配列を指す）\nb[1] = 99\na              # [99, 2, 3] になる\n\nc = a\nc = [0]        # 変数cの付け替え（aは変わらない）\n\n# immutableの例（値：共有されない）\nx = 1\ny = x\ny = 2\nx              # 1\n")

== Stack / Heap / GC（直感）

- *stack（スタック）*: 関数呼び出し中の「一時置き場」（関数が終わるとまとめて片付くイメージ）
- *heap（ヒープ）*: 長く生きるデータの置き場（手動で片付けないと溜まるイメージ）
- Juliaではどこに置かれるか（stack/heap）は原則コンパイラが決める（ユーザが直接は制御しない）
- 小さな immutable（isbits）は値として扱われやすい
- mutable（Arrayなど）は参照として扱われやすい → GCの対象になりやすい
- *GC（garbage collection）*: 参照されなくなったオブジェクトのメモリを自動回収（手動 `free` 不要）ただオーバヘッドがある.

= 関数・多重ディスパッチ

== 関数とはなにか？（メソッドの集合）

- Juliaの「関数」は *メソッドの集合*
- 引数の型に応じて多重ディスパッチで呼び分け
- 「型 × 振る舞い」の設計が自然

== 多重ディスパッチ（人為的な最小例）

#code("julia", "f(x) = x                # 汎用（fallback）\nf(x::Real) = x + 1      # 抽象型で定義してOK\nf(x::Int) = x + 1       # より具体型（同じ意味のまま上書きもできる）\n\nf(1)      # 2\nf(1.0)    # 2.0（Real）\nf(\"a\")    # \"a\"（fallback）\n")

== 多重ディスパッチ（最小例）

#code("julia", "area(s::Square) = s.side_length^2\narea(c::Circle) = π * c.radius^2\n\narea(Square(2.0))  # 4.0\narea(Circle(1.0))  # 3.1415...\n")

= JIT / 計測

== Just-In-Time Compilation (JIT)

- 最初の呼び出しでコンパイル（遅い）
- コンパイル単位：*メソッド × 実引数の型*（specialization）
  - 型注釈の有無に関係なく, 実際に渡された「具体型」で決まる
  - 引数型に `x::Real` のような抽象型を指定すること自体は可能（ただし実行時は具体型でspecialize）
- 同じ「メソッド×型」なら, 2回目以降はキャッシュ済み（速い）
- TTFX: Time To First Execution（最初の呼出し時の待ち時間）

（補足）Julia 1.9以降：事前コンパイルでネイティブコードも保存（pkgimage）→次回以降が速い \
（注意）通常の実行中にJITされた分は基本セッション限り（永続化したいなら sysimage）

== JITと計測（BenchmarkToolsの意味）

- “一回だけ実行” はコンパイル時間が混ざりがち
- `@btime` は繰り返して安定した時間を測る（＋`$`補間）

（→ `projects/01_linalg_bench/`, `projects/02_broadcast_bench/` で体験）

= 配列

== よく使う構造体の例: Array

#code("julia", "a = [1, 2, 3]\na[1] = 4\na # Array{Int64,1} / Vector{Int64}\n\nA = [1 2; 3 4]   # 2x2行列\nA[1, 2]          # 2\nA[2, 1] = 30\nA # Array{Int64,2} / Matrix{Int64}\n")

配列の添字は1-basedであることに注意.  \
配列のElementの型は, 最初に決まったら変更できない. 

== 配列のElementの型

高速な計算のために, 配列のElementの型は Int64, Float64, Bool, Char などの基本的な型にするのが望ましい. 

Array{Any}になる例

#code("julia", "v = [1.0, 1]      # Vector{Float64}（数値は昇格して揃う）\neltype(v)         # Float64\n\nw = [1.0, \"a\"]    # Vector{Any}（揃えられないとAny）\neltype(w)         # Any\n")

= ハンズオン

== ここからハンズオン（Projectと計測）

以降は `projects/` を動かしながら進めます. 

== 使うProject（通し番号）

- `projects/01_linalg_bench/`: 行列積ベンチ（BenchmarkTools, FLOPs）
- `projects/02_broadcast_bench/`: `sin.(x)`ベンチ（BenchmarkTools, broadcast）
- `projects/03_core_basics/`: 基礎文法・配列
- `projects/04_functions_dispatch/`: 関数・多重ディスパッチ

== 0. まず動かす（Project環境）

例：`projects/01_linalg_bench/`

#code("julia", "using Pkg\nPkg.activate(\"projects/01_linalg_bench\")\nPkg.instantiate()\nPkg.test()\n")

Notebook標準：各Projectの `notebook.ipynb` を開く. 

== 1. 線形代数ベンチ：行列積（BenchmarkTools + FLOPs）

使うProject：`projects/01_linalg_bench/`

- `BenchmarkTools.@btime` の作法（`$`補間）
- `A*B` の実測
- FLOPs/GFLOPs（目安 `2n^3`）の概念

== 2. broadcastの速度感：`sin.(x)`

使うProject：`projects/02_broadcast_bench/`

- `sin.(x)` を測る（要素/秒）
- dot/broadcastの直観

== 3. 基本：配列と制御構文（最低限）

使うProject：`projects/03_core_basics/`

- 配列, range, for/if
- viewとコピーの違い（軽く）

== 4. 関数と多重ディスパッチ

使うProject：`projects/04_functions_dispatch/`

- 関数定義
- メソッド追加（`f(::Int)`など）

== 5. 予告：GC / allocation

allocation/GCの詳説は講義3で扱う（「なぜallocationを減らすと効くか」もそこで回収）. 

