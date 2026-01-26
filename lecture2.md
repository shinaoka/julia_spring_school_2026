## 講義2（80分）Project/テスト/Revise/NPZ/Plots + VS Code Notebook

### この回のゴール

- Project環境を「使う」だけでなく「自分で作る」入口まで
- `Pkg.test()`でテストを回す習慣
- `Revise` + `includet`で試行錯誤を速くする
- Python連携I/O（NPZ）と可視化（Plots）をNotebookで体験する

### 使うProject（通し番号）

- `projects/05_project_basics/`: Project操作（activate/add/status）
- `projects/06_testing/`: テスト（`Pkg.test()`、`runtests.jl`）
- `projects/07_revise_includet/`: Revise + `includet`
- `projects/08_io_npz/`: NPZ（`.npy/.npz`）
- `projects/09_plot_plotsgr/`: Plots + GR（Notebook）
- `projects/10_debug_basics/`: デバッグの入口（`@show`, `@assert`）

### Notebook（標準）について

- 標準は `.ipynb`（VS Code Jupyter拡張 + IJulia）。
- 各Project内の `notebook.ipynb` を開く（IJuliaのデフォルト `--project=@.` により、そのProjectが有効になりやすい）。
- IJuliaはグローバル環境（`@v1.x`）に導入（`README.md`参照）。

### 1. Project環境（深掘り）

`projects/05_project_basics/` を使う。

- `Pkg.activate` / `Pkg.add` / `Pkg.status`
- `Project.toml`の役割
- Manifestは発展（完全固定したいとき）

### 2. テスト（`Pkg.test()`）

`projects/06_testing/` を使う。

- `Pkg.test()`が正
- `test/runtests.jl` と `Test.@testset`

### 3. Revise + includet

`projects/07_revise_includet/` を使う。

- `using Revise`
- `includet("src/xxx.jl")` で編集→再実行が楽になる

### 4. I/O：NPZでPython連携

`projects/08_io_npz/` を使う。

- `NPZ.jl`で`.npy/.npz`読み書き
- HDF5は発展（複素数などの表現がブレる可能性に注意）

### 5. お気軽プロット：Plots + GR

`projects/09_plot_plotsgr/` の `notebook.ipynb` で進める。

- 1枚描く
- ファイル保存（pngなど）

### 6. デバッグの入口

`projects/10_debug_basics/` を使う。

- stacktraceの読み方（自分のコードに近い所を見る）
- `@show` / `@assert`

