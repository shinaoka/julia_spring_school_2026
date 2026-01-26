## 講義2（80分）パッケージ環境・データ入出力・最小限の可視化とデバッグ

この回のゴールは「講義資料のコードを、各自の環境で“再現可能に”動かす」ことです。

### 1. Project環境（20分）

Juliaは **プロジェクトごとに依存関係を固定** できます（再現性）。

この講義では `code/julia_intro/` がプロジェクトです。

REPLで:

```julia
using Pkg
Pkg.activate("code/julia_intro")
Pkg.instantiate()
Pkg.status()
```

テストは必ず:

```julia
Pkg.test()
```

### 2. ファイルI/O（15分）

テキスト:

```julia
write("tmp.txt", "hello\n")
s = read("tmp.txt", String)
```

簡単なデータ保存（例：配列をバイナリで）:

```julia
using Serialization
serialize("A.bin", rand(3,3))
A = deserialize("A.bin")
```

### 3. 可視化（最小限）（15分）

講義内では「手元で試したい人向け」に最小限だけ紹介します。

- 選択肢: `Plots.jl`, `Makie.jl`
- 依存が増えるので、サンプルプロジェクト本体の依存には入れず、必要な人は各自の環境で試す想定

### 4. エラーの読み方・デバッグの入り口（20分）

- スタックトレースは「上の方」より「下の方」（自分のコードに近い所）を見る
- `@show` / `@info` で値を出す
- `@assert` で前提条件を明示する

例:

```julia
@assert length(x) > 0 "x must be non-empty"
```

### 5. 演習（10分）

- **演習1**: `code/julia_intro/test/runtests.jl` を `Pkg.test()` で走らせる
- **演習2**: `examples/03_io.jl` を実行し、保存したデータを読み戻す

