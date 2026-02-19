## 計算物理 春の学校 2026 — Julia入門

Typst で書いた講義ノートを shiroa で HTML 化して公開するリポジトリです（章立ては題材ベース）。

### 目次

- 公開用 HTML は GitHub Pages（GitHub Actions）でデプロイします
- ローカルでは `make serve` / `make build` で確認できます

### 取得方法

- **git clone（推奨）**:

```bash
git clone <THIS_REPO_URL>
cd julia_spring_school_2026
```

- **ZIP**: GitHubの「Code」→「Download ZIP」

### Notebook（標準: `.ipynb`）

- VS Codeで `.ipynb` を使うには **Jupyter拡張 + IJulia** が必要です。
- **IJuliaはグローバル環境（`@v1.x`）に導入**してカーネル登録します（教材Projectには入れません）。

```julia
using Pkg
Pkg.activate()        # @v1.x
Pkg.add("IJulia")
Pkg.build("IJulia")
```

- `juliaup`でJuliaを更新したら、もう一度 `Pkg.build("IJulia")` を実行してください。
  - 参考: `https://julialang.github.io/IJulia.jl/stable/manual/installation/`
