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
    #chapter("topics/package-dev.typ")[発展課題：パッケージとは？作り方は？]

    = 参考（旧）
    #chapter("lectures/lecture1-outline.typ")[講義回アウトライン（旧）]
  ],
)

#_book

// Re-export page template (SCFP-style).
#import "templates/page.typ": project
#let book-page = project.with(book: _book)
