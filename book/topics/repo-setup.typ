#import "../book.typ": book-page

#show: book-page.with(title: "まずは GitHub を使ってみよう")

= まずは GitHub を使ってみよう

この題材では、最初に「自分のレポジトリ」を作り、作業を1回転させます。

== ゴール

- GitHub 上で新規リポジトリ作成（Julia 向け `.gitignore`）
- ローカルに `git clone` して VS Code で開く
- Julia のプロジェクト環境（`Project.toml` / `Manifest.toml`）を作る
- VS Code の UI で環境を有効化（activate）
- 最後に commit & push

== 使う道具（最小）

- GitHub CLI：`gh`（例：`gh auth login`、`gh repo create`）
- Git
- VS Code + Julia 拡張 + GitHub Copilot

== 1. GitHub 上でリポジトリ作成

GitHub CLI を使って、新しいリポジトリを作成します。

```sh
# 公開リポジトリを作成（Julia 用 .gitignore 付き）
gh repo create my-julia-project --public --gitignore Julia --add-readme

# 作成できたか確認
gh repo view my-julia-project
```

- `--gitignore Julia` で Julia 向けの `.gitignore` が自動生成される
- `--add-readme` で最小限の `README.md` も作られる
- リポジトリ名は自由に決めてよい

== 2. ローカルに clone して VS Code で開く

```sh
# clone（自分のユーザ名に合わせて）
gh repo clone my-julia-project

# VS Code で開く
code my-julia-project
```

- VS Code が開いたら、*GitHub Copilot Chat* が使えることを確認する
  - サイドバーの Copilot アイコン → チャットウィンドウが開けば OK
- ここから先、LLM を「相棒」として常に使っていく

== 3. LLM に「プロジェクト環境」を作らせる

VS Code の Copilot Chat（または任意の LLM）に、以下のように頼んでみましょう。

*プロンプト例：*

```
このリポジトリに Julia のプロジェクト環境を作りたい。
Project.toml を追加して、BenchmarkTools を依存に入れて。
手順をステップごとに教えて。
```

LLM の回答に従って操作するか、以下を直接実行します。

```sh
cd my-julia-project

# Julia REPL を起動し、パッケージモードでプロジェクトを初期化
julia -e '
  using Pkg
  Pkg.activate(".")
  Pkg.add("BenchmarkTools")
'
```

これで `Project.toml` と `Manifest.toml` が生成されます。

- *`Project.toml`*：このプロジェクトが使うパッケージの一覧（人が管理する）
- *`Manifest.toml`*：依存関係を含む全パッケージの正確なバージョン（自動生成）

=== VS Code で環境を有効化する

- VS Code のステータスバー（左下）に表示される Julia 環境名をクリック
- 開いたフォルダの `Project.toml` を選択して activate する
- これで VS Code 内の Julia REPL がプロジェクト環境を使うようになる

== 4. commit & push

ここまでの変更をリポジトリに記録します。

```sh
cd my-julia-project

git add Project.toml Manifest.toml
git commit -m "Julia プロジェクト環境を追加"
git push
```

- `git add` → ステージング（コミット対象にする）
- `git commit` → ローカルに記録
- `git push` → GitHub に反映

== 1コマ目の最後に投げる問い
*`Manifest.toml` は何で必要？いつコミットする？*
