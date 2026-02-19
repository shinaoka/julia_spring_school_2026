#import "../book.typ": book-page

#show: book-page.with(title: "受講前提とゴール")

= 受講前提とゴール

この講義（講義1）の全体像です。

== 前提

- Git / GitHub の基礎操作（前日講義でカバー済み）
- GitHub アカウントの取得と GitHub Student Developer Pack 取得
- GitHub CLI（`gh`）の導入と認証
  - 参考: https://docs.github.com/ja/github-cli/github-cli/about-github-cli
  - インストール後、以下で認証を済ませておく：

```sh
gh auth login
# 対話形式で GitHub.com → HTTPS → ブラウザ認証 を選択
gh auth status   # 認証できたか確認
```

- Julia のインストール（juliaup 推奨）
  - juliaup を使うと、Julia 本体のインストールとバージョン切り替えをまとめて管理できます
  - 参考: https://github.com/JuliaLang/juliaup
  - インストール例：

```sh
# macOS / Linux
curl -fsSL https://install.julialang.org | sh

# Windows（PowerShell）
winget install julia -s msstore
```

  - インストール確認：

```sh
julia --version
```

  - 公式ダウンロード案内: https://julialang.org/downloads/

- VS Code のインストールと Julia 拡張の導入
  - VS Code: https://code.visualstudio.com/
  - Julia 拡張（Julia Language Support）: https://marketplace.visualstudio.com/items?itemName=julialang.language-julia

- 講義で使うパッケージの事前インストール（会場の回線が細いため）

```sh
julia -e 'using Pkg; Pkg.add("BenchmarkTools")'
```

== この講義で目指すこと

=== LLM 時代にコーディングを学ぶ意味

LLM がコードを書いてくれる時代でも、*抽象化・構造化の考え方* を理解していないと、LLM の出力を評価できず、適切な指示も出せません。この講義では「自分で全部書く」のではなく「LLM と協働しながら、コードの設計意図を読み書きできる」ことを目指します。

=== 具体的なゴール

- LLM（VS Code Copilot Pro など）を *相棒* にして Julia コードを書かせ・読めるようになる
- Julia の抽象化（関数・型・broadcast）の「何がおいしいか」を体感する
- プロジェクト環境と GitHub を用いた、現代的な開発ワークフローの入り口を経験する

== 最初に投げる問い

*「LLM と一緒にコードを書く」って、具体的に何をできるようになること？*
