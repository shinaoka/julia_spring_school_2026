#import "../book.typ": book-page

#show: book-page.with(title: "プロジェクト環境とは？")

= プロジェクト環境とは？

Julia の *プロジェクト環境* は、2 つの TOML ファイルで管理される。

- `Project.toml`：その環境で *直接* 使うパッケージと互換性（compat）を宣言する
- `Manifest.toml`：依存関係を解決した結果の *完全なスナップショット（ロック）*

== なぜ環境が必要か？

グローバル環境（`@v1.11` など）にすべてのパッケージを入れると、人によってバージョンがバラバラになる。プロジェクトごとに環境を分けておけば、*`instantiate` するだけで誰でも同じ環境を復元できる*。再現性の基盤。

== Project.toml の役割

*人が管理する* ファイル。直接使うパッケージ名と、その互換性（compat）を宣言する。

前のステップで作った `Project.toml` はこんな形になっているはず：

```toml
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"

[compat]
BenchmarkTools = "1"
julia = "1.10"
```

- `[deps]`：パッケージ名と UUID の対応。`Pkg.add` で自動追記される
- `[compat]`：許容するバージョン範囲。*書いておくと再現性が上がる*
  - `"1"` は `>= 1.0.0, < 2.0.0` の意味（SemVer）

== Manifest.toml の役割

*自動生成される* ファイル。依存の依存まで含めた、全パッケージの正確なバージョンとツリーが記録される。Python でいう `uv.lock`、Node.js でいう `package-lock.json` に相当する。

=== コミットするか？`.gitignore` にするか？

場合によって方針が変わる：

- *アプリケーション*（再現性重視）→ コミットする
  - 別マシンで `instantiate` すれば完全に同じ環境が復元できる
- *ライブラリ／パッケージ*（公開する側）→ `.gitignore` にする
  - 利用者側が自分の環境で依存関係を解決するため

*今回の講義ではコミットする方針。*

== 環境の操作

=== REPL の Pkg モード（`]` キー）

```julia-repl
pkg> activate .          # カレントディレクトリの環境を有効化
pkg> add BenchmarkTools  # パッケージを追加
pkg> status              # 現在の依存一覧を表示
pkg> instantiate         # Manifest.toml から環境を復元
```

=== Julia コード（スクリプトや CI で使う場合）

```julia
using Pkg
Pkg.activate(".")
Pkg.add("BenchmarkTools")
Pkg.status()
Pkg.instantiate()
```

どちらも結果は同じ。REPL で試すなら Pkg モード、スクリプトや CI に書くなら `using Pkg` 形式を使う。

=== よく使う場面

- *`activate .`*：この環境で作業を始めるとき（毎回やる）
- *`add PackageName`*：新しいパッケージを追加するとき
- *`instantiate`*：別のマシンで `git clone` した直後に、Manifest.toml から同じ環境を復元するとき

== 最後に残す問い

- *`Manifest.toml` は、いつまで・誰のために・どの粒度で固定する？*
