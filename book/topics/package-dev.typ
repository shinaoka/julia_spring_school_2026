#import "../book.typ": book-page

#show: book-page.with(title: "発展課題：パッケージとは？作り方は？")

= 発展課題：パッケージとは？作り方は？

このページは「プロジェクト環境」の次の一歩として、Julia の *パッケージ* を扱う導入です。

== パッケージとは？（最小の理解）

- ある機能を *再利用* できる形（モジュール）としてまとめたもの
- `Project.toml` を持ち、依存関係や互換性（compat）を宣言できる
- ほかのプロジェクトから `using` / `import` して使える

== サンプルを見てみよう

性能改善で使ったサンプルリポジトリ（`julia_spring_school_2026_sample`）に、最適化済みの `estimate_pi` をパッケージ化した例が入っています。自分の fork を開いて `topics/package_dev/MonteCarloPi/` を見てみましょう。

=== ディレクトリ構成

```
topics/package_dev/MonteCarloPi/
├── Project.toml          # パッケージのメタデータ
├── src/
│   └── MonteCarloPi.jl   # モジュール本体
└── test/
    └── runtests.jl        # テスト
```

=== `src/MonteCarloPi.jl` ── モジュール本体

```julia
module MonteCarloPi

export estimate_pi

"""
    estimate_pi(N::Int) -> Float64

モンテカルロ法で円周率を推定する。`N` 個の乱数点を使う。
"""
function estimate_pi(N::Int)
    count = 0
    for _ in 1:N
        x, y = rand(), rand()
        count += (x^2 + y^2 <= 1.0)
    end
    return 4.0 * count / N
end

end # module
```

- `module MonteCarloPi ... end` で名前空間を区切る
- `export estimate_pi` で公開 API を宣言（`using MonteCarloPi` だけで使える）
- docstring（`""" ... """`）を付けておくと `?estimate_pi` でヘルプが出る

=== `test/runtests.jl` ── テスト

```julia
using MonteCarloPi
using Test

@testset "MonteCarloPi" begin
    result = estimate_pi(10_000_000)
    @test result ≈ π atol=0.01
end
```

- `@testset` でテストをグループ化
- `≈`（`\approx` + Tab）と `atol` で「おおよそ等しい」ことを検証

=== `Project.toml` ── パッケージのメタデータ

```toml
name = "MonteCarloPi"
uuid = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
version = "0.1.0"

[deps]
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
julia = "1.10"
```

- `name`：パッケージ名（モジュール名と一致させる）
- `uuid`：パッケージの一意識別子（`pkg> generate` で自動生成される）
- `version`：SemVer 形式のバージョン番号
- `[compat]`：サポートする Julia バージョンの範囲

== テストを動かす

サンプルリポジトリの `MonteCarloPi` ディレクトリでテストを実行できます。

```sh
cd julia_spring_school_2026_sample/topics/package_dev/MonteCarloPi
julia --project=. -e 'using Pkg; Pkg.instantiate(); Pkg.test()'
```

`Test Summary: | Pass  Total` のように表示されれば成功。

== 作り方（最短ルート）

自分でパッケージを作るときは、基本は LLM に任せて OK です（雛形作成・テスト作成・GitHub 反映までを 1 セットで依頼する）。

- LLM に依頼：最小パッケージ雛形（`src/` と `test/`）を作る
- LLM に依頼：`test/runtests.jl` に最小テスト（`Test` の `@testset`）を作る
- LLM に依頼：commit & push（必要なら GitHub Actions の test まで）

（参考）手でやる場合は、REPL の Pkg モードで雛形を作れます：`pkg> generate MonteCarloPi`

== LLM への依頼例

- 「`estimate_pi` を `MonteCarloPi` パッケージにして。`src/MonteCarloPi.jl` に module を、`test/runtests.jl` にテストを書いて。`pkg> test` が通るところまで」
- 「docstring を付けて、`?estimate_pi` でヘルプが出るようにして」
- 「GitHub Actions で `Pkg.test()` を自動実行する CI を追加して」

== ここまでできたら合格（チェックリスト）

- `pkg> activate .` した環境で `using MonteCarloPi` が通る
- `pkg> test` が通る
- 変更を commit して push できる

== 発展：CI でテストを自動実行する

=== CI / GitHub Actions とは？

*CI（Continuous Integration）* とは、コードを push するたびにテストやビルドを自動実行する仕組み。GitHub では *GitHub Actions* というサービスで提供されている。

- リポジトリに `.github/workflows/` 以下に YAML ファイルを置くと、push や PR のたびに自動でジョブが走る
- テストが通れば緑のチェック、落ちれば赤のバツが GitHub 上に表示される
- 「手元では動くけど他の環境で動かない」を防げる

=== LLM に CI を作らせる

*プロンプト例：*

```
このリポジトリの topics/package_dev/MonteCarloPi に
GitHub Actions の CI を追加して。
push のたびに Julia 1.10 で Pkg.test() を実行するワークフローを
.github/workflows/ci.yml に書いて。
```

LLM が生成する YAML はだいたいこんな形になる：

```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: julia-actions/setup-julia@v2
        with:
          version: "1.10"
      - uses: julia-actions/cache@v2
      - run: |
          cd topics/package_dev/MonteCarloPi
          julia --project=. -e 'using Pkg; Pkg.instantiate(); Pkg.test()'
```

詳細を理解する必要はなく、「LLM に頼めば作れる」ことを知っておけば十分。

== 最後に残す問い

*「プロジェクト」と「パッケージ」は、何が同じで何が違う？*
