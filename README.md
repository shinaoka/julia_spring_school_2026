## 計算物理 春の学校 2026 — Julia入門

GitHubでそのまま読める講義ノート（Markdown）と、手を動かすためのサンプルコード（トピック別のJulia Project環境）をまとめたリポジトリです。

### 目次

- [Overview: Juliaとは何か](overview.md)
- [講義1: 基本 + ベンチ（BenchmarkTools/FLOPs）](lecture1.md)
- [講義2: Project/テスト/Revise/NPZ/Plots + VS Code Notebook](lecture2.md)
- [講義3: 最適化（GC/alloc）](lecture3.md)

### 取得方法

- **git clone（推奨）**:

```bash
git clone <THIS_REPO_URL>
cd julia_spring_school_2026
```

- **ZIP**: GitHubの「Code」→「Download ZIP」

### サンプルの実行（共通テンプレ）

各トピックは `projects/NN_xxx/` が独立したProject環境です。

REPLから:

```julia
using Pkg
Pkg.activate("projects/01_linalg_bench")
Pkg.instantiate()
Pkg.test()
```

スクリプト実行（カレントが`projects/NN_xxx/`の想定）:

```bash
cd projects/01_linalg_bench
julia --project=. examples/01_run.jl
```

### VS Code + Project環境（重要）

- **原則**: VS Codeは「開いているフォルダ（ワークスペース）」を基準にProject環境を扱います。
  - `projects/01_linalg_bench/` を開けば、そのProjectが前提になります。
- **注意**: `projects/`を開いたままサブディレクトリのコードを触ると、意図したProjectになっていないことがあります。
  - ステータスバー等で **アクティブなProject** を確認し、必要なら選び直してください。

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

### 旧資料

- 以前のファイルは `legacy/` に退避しています。

