#import "@preview/shiroa:0.3.1": *

// Entry point for shiroa (Typst → HTML).
#show: book

#let _book = book-meta(
  title: "Julia Spring School 2026",
  description: "Lecture notes (draft)",
  // TODO: set the correct repository URL when decided.
  repository: "",
  authors: ("Hiroshi Shinaoka",),
  summary: [
    #prefix-chapter("home.typ")[Home]

    = Topics
    #chapter("topics/prerequisites.typ")[受講前提とゴール]
    #chapter("topics/repo-setup.typ")[まずは GitHub を使ってみよう]
    #chapter("topics/pkg-environments.typ")[プロジェクト環境とは？]
    #chapter("topics/abstraction.typ")[Julia の抽象化を読めるように]
    #chapter("topics/performance.typ")[性能評価と改善サイクル]
    #chapter("topics/exercise-binning.typ")[演習：binning で π の推定精度を評価する]
    #chapter("topics/exercise-ising.typ")[発展演習：2次元イジング模型のモンテカルロ法]
    #chapter("topics/package-dev.typ")[発展課題：パッケージとは？作り方は？]
  ],
)

#_book

// Re-export page template (SCFP-style).
#import "templates/page.typ": project

#let custom-css = ```css
pre > code {
  padding: 0 !important;
}
pre {
  background-color: #f5f5f5 !important;
  border-radius: 4px;
  padding: 0.5rem 0.8rem;
}
```

#let book-page = project.with(book: _book, extra-assets: (custom-css,))
