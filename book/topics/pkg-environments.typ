#import "../book.typ": book-page

#show: book-page.with(title: "プロジェクト環境とは？")

= プロジェクト環境とは？

== ざっくり

- `Project.toml`：その環境で *直接* 使うパッケージと互換性（compat）を宣言する
- `Manifest.toml`：依存関係を解決した結果の *完全なスナップショット（ロック）*

== 最後に残す問い

- *`Manifest.toml` は、いつまで・誰のために・どの粒度で固定する？*
