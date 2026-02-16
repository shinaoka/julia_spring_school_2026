#import "../book.typ": book-page

#show: book-page.with(title: "Julia の抽象化を読めるように")

= Julia の抽象化を読めるように

狙いは、LLM が生成する Julia を「読める／直せる」状態になることです。

== ここで扱うこと

- 関数化：`estimate_pi(N)` みたいに整理する
- 最小限の文法：配列、for/if、内包表記（読めればOK）
- 型と多重ディスパッチ：関数 = メソッドの集合、型で挙動が変わる
- broadcast：`.` の意味と for ループとの対応

== 最後に残す問い

*broadcast は「何を省略」していて、どこが読みづらくなる？*
