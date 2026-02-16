#import "../book.typ": book-page

#show: book-page.with(title: "発展課題：パッケージとは？作り方は？")

= 発展課題：パッケージとは？作り方は？

このページは「プロジェクト環境」の次の一歩として、Julia の *パッケージ* を扱う導入です。

== パッケージとは？（最小の理解）

- ある機能を *再利用* できる形（モジュール）としてまとめたもの
- `Project.toml` を持ち、依存関係や互換性（compat）を宣言できる
- ほかのプロジェクトから `using` / `import` して使える

== 作り方（最短ルート）

基本は LLM に任せて OK です（雛形作成・テスト作成・GitHub 反映までを 1 セットで依頼する）。

- LLM に依頼：最小パッケージ雛形（`src/` と `test/`）を作る
- LLM に依頼：`test/runtests.jl` に最小テスト（`Test` の `@testset`）を作る
- LLM に依頼：commit & push（必要なら GitHub Actions の test まで）

（参考）手でやる場合は、REPL の Pkg モードで雛形を作れます：`pkg> generate MyPkg`

== LLM への依頼例

- 「このリポジトリに Julia パッケージ `MyPkg` の最小雛形を追加して。`src/MyPkg.jl` と `test/runtests.jl` を用意して、`pkg> test` が通るところまで」
- 「公開 API を 1 つだけ作って（例：`hello(name)`）、テストも一緒に書いて」

== ここまでできたら合格（チェックリスト）

- `pkg> activate .` した環境で `using MyPkg` が通る
- `pkg> test` が通る
- 変更を commit して push できる

== 最後に残す問い

*「プロジェクト」と「パッケージ」は、何が同じで何が違う？*
