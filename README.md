## 計算物理 春の学校 2026 — Julia入門

Quarto で書いた講義ノートを HTML 化して公開するリポジトリである。

### 目次

- 公開用 HTML は GitHub Pages（GitHub Actions）でデプロイする
- ローカルでは `make serve` / `make build` で確認できる
- 正本の原稿は `book/*.qmd` である

### 取得方法

- **git clone（SSH を強く推奨）**:

```bash
git clone git@github.com:shinaoka/julia_spring_school_2026.git
cd julia_spring_school_2026
```

- この講義では、GitHub リポジトリの取得と push/pull は HTTPS ではなく SSH を標準とする。
- **ZIP**: GitHubの「Code」→「Download ZIP」

### Notebook（標準: `.ipynb`）

- VS Codeで `.ipynb` を使うには **Jupyter拡張 + IJulia** が必要である。
- **IJuliaはグローバル環境（`@v1.x`）に導入**してカーネル登録する（教材Projectには入れない）。

```julia
using Pkg
Pkg.activate()        # @v1.x
Pkg.add("IJulia")
Pkg.build("IJulia")
```

- `juliaup`でJuliaを更新したら、もう一度 `Pkg.build("IJulia")` を実行すること。
  - 参考: `https://julialang.github.io/IJulia.jl/stable/manual/installation/`
