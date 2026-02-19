#import "../book.typ": book-page

#show: book-page.with(title: "Julia の抽象化を読めるように")

= Julia の抽象化を読めるように

狙いは、LLM が生成する Julia を「読める／直せる」状態になることです。

== 関数化：抽象化の第一歩

前のステップで書いた π 推定コードは、こんなベタ書きスクリプトだったはず：

```julia
# ベタ書き版（動くけど再利用しにくい）
N = 10^6
count = 0
for _ in 1:N
    x, y = rand(), rand()
    if x^2 + y^2 <= 1
        count += 1
    end
end
pi_estimate = 4 * count / N
println(pi_estimate)
```

LLM に「`estimate_pi(N)` の形に関数として整理して」と頼むと、こうなる：

```julia
function estimate_pi(N)
    count = 0
    for _ in 1:N
        x, y = rand(), rand()
        if x^2 + y^2 <= 1
            count += 1
        end
    end
    return 4 * count / N
end

estimate_pi(10^6)  # 何度でも、N を変えて呼べる
```

=== 抽象化とは何か

- *パターンを一箇所にまとめる*：同じ処理を関数として切り出す
- *引数で違いを表現する*：`N` を変えるだけで実験条件を変更できる
- 結果：LLM に「N を変えて比較して」と頼むのも簡単になる

== Julia 基本文法の最小セット

LLM が生成するコードを「読める」ための最低限。詳細な文法講義ではなく、出てきたら分かる状態を目指す。

=== 数値と配列

```julia
x = 3.14              # Float64
n = 42                 # Int64
s = "hello"            # String

v = [1, 2, 3]          # Vector{Int64}（1次元配列）
m = [1 2; 3 4]         # Matrix{Int64}（2次元配列）
r = rand(5)            # 長さ5のランダムベクトル
```

=== for / if / 内包表記

```julia
# for ループ
for i in 1:5
    println(i)
end

# if 文
if x > 0
    println("正")
elseif x == 0
    println("零")
else
    println("負")
end

# 内包表記（リスト内包）
squares = [i^2 for i in 1:10]
```

=== REPL モード

Julia REPL には 3 つのモードがある。キーひとつで切り替わる：

- *通常モード*（`julia>`）：Julia コードを実行
- *パッケージモード*（`]` を押す → `pkg>`）：`add`、`activate`、`status` など
- *シェルモード*（`;` を押す → `shell>`）：OS コマンドを実行

Backspace で通常モードに戻る。

== 型と多重ディスパッチ

=== 型を確認する

```julia
typeof(1)        # Int64
typeof(1.0)      # Float64
typeof("hello")  # String
typeof([1,2,3])  # Vector{Int64}
```

=== 関数 = メソッドの集合

Julia では同じ名前の関数に、引数の型ごとに異なる「メソッド」を定義できる。これが*多重ディスパッチ*。

```julia
# 型ごとに振る舞いを変える
describe(x::Int)     = println("整数: $x")
describe(x::Float64) = println("浮動小数: $x")
describe(x::String)  = println("文字列: $x")

describe(42)       # => 整数: 42
describe(3.14)     # => 浮動小数: 3.14
describe("hello")  # => 文字列: hello
```

`methods(describe)` で、登録されたメソッドの一覧を確認できる：

```julia
methods(describe)
# 3 methods for generic function "describe" ...
```

=== LLM への依頼例

```
この関数 describe を、Vector 型の引数にも対応させて。
要素数と先頭の値を表示するようにして。
```

== broadcast

=== for ループ版と `.` 版の対応

同じ処理を 2 通りで書いてみる：

```julia
xs = rand(10^6)
ys = rand(10^6)

# for ループ版
inside = 0
for i in 1:length(xs)
    if xs[i]^2 + ys[i]^2 <= 1
        inside += 1
    end
end

# broadcast 版（.  で要素ごとに適用）
inside = sum(xs.^2 .+ ys.^2 .<= 1)
```

`.` は「配列の各要素に関数／演算を適用する」という意味。for ループを 1 行に圧縮できる。

=== broadcast のメリット

- *コードが短い*：意図が明確になる
- *高速化のポテンシャル*：コンパイラが最適化しやすい（詳細は次の題材で扱う）

=== LLM への依頼例

```
この for ループを broadcast（ドット構文）で書き換えて。
元のコードとの対応関係もコメントで説明して。
```

== 小さな一般化：抽象化の効果を感じる

関数化しておくと、問題設定の変更が簡単になる。例として π 推定を「2 次元 → N 次元」に拡張してみる。

N 次元の単位超球の体積を Monte Carlo で推定する：

```julia
function estimate_volume(N, dim)
    points = rand(dim, N)           # dim x N の乱数行列
    inside = sum(sum(points.^2, dims=1) .<= 1)
    volume_cube = 2^dim             # 超立方体 [0,1]^dim → [-1,1]^dim
    return volume_cube * inside / N
end

estimate_volume(10^6, 2)  # ≈ π（2次元 = 円）
estimate_volume(10^6, 3)  # ≈ 4π/3（3次元 = 球）
```

- `estimate_pi(N)` から `estimate_volume(N, dim)` へ：引数を 1 つ増やすだけ
- 一度抽象化しておくと、LLM との対話で「次元を変えて試して」と頼むだけで済む

== 最後に残す問い

*broadcast は「何を省略」していて、どこが読みづらくなる？*
