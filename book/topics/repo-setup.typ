#import "../book.typ": book-page

#show: book-page.with(title: "まずは GitHub を使ってみよう")

= まずは GitHub を使ってみよう

この題材では、最初に「自分のレポジトリ」を作り、作業を 1 回転させます。

== ゴール

- GitHub 上で新規リポジトリ作成（Julia 向け `.gitignore`）
- ローカルに `git clone` して VS Code で開く
- Julia のプロジェクト環境（`Project.toml` / `Manifest.toml`）を作る
- VS Code の UI で環境を有効化（activate）
- 最後に commit & push

== 使う道具（最小）

- GitHub CLI：`gh`（例：`gh auth login`、`gh repo create`）


== 1コマ目の最後に投げる問い
*`Manifest.toml` は何で必要？いつコミットする？*
