#import "@preview/shiroa-mdbook:0.3.1": mdbook

#let project(
  body,
  book: none,
  title: "",
  description: none,
  enable-search: true,
  extra-assets: (),
) = {
  assert(book != none, message: "book meta content must be provided")
  mdbook(
    book,
    body,
    title: title,
    description: description,
    enable-search: enable-search,
    extra-assets: extra-assets,
  )
}
