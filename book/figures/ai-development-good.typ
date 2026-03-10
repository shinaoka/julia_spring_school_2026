#import "@preview/cetz:0.4.1": *

#set page(width: 640pt, height: 330pt, margin: 10pt)
#set par(justify: false)

#let slate = rgb("#0f172a")
#let muted = rgb("#64748b")
#let flow = rgb("#475569")
#let design = rgb("#2563eb")
#let design-fill = rgb("#dbeafe")
#let design-bg = rgb("#f8fbff")
#let results = rgb("#16a34a")
#let results-fill = rgb("#dcfce7")

#let node(title, subtitle: none, fill: white, stroke: rgb("#cbd5e1"), width: 150pt) = box(
  width: width,
  inset: (x: 14pt, y: 12pt),
  radius: 12pt,
  fill: fill,
  stroke: 1.2pt + stroke,
)[
  #align(center + horizon)[
    #text(size: 15pt, weight: "bold", fill: slate)[#title]
    #if subtitle != none [
      #linebreak()
      #text(size: 11pt, fill: muted)[#subtitle]
    ]
  ]
]

#let pill(body, fill, color, inset: (x: 10pt, y: 5pt)) = box(
  inset: inset,
  radius: 999pt,
  fill: fill,
)[
  #text(size: 12pt, weight: "bold", fill: color)[#body]
]

#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    rect((1.0, 3.0), (12.6, 8.0), stroke: (paint: design, thickness: 1.3pt), fill: design-bg)
    content((2.4, 7.6), pill([BS session], design-fill, design))
    content((8.7, 7.6), pill([design feedback loop], design-fill, design))

    content((3.8, 6.0), node([Human], fill: rgb("#fff7ed"), stroke: rgb("#fdba74")), name: "human")
    content((6.8, 6.0), text(size: 28pt, fill: design)[↔])
    content((9.8, 6.0), node([AI], fill: rgb("#eff6ff"), stroke: rgb("#93c5fd")), name: "ai")

    line((3.8, 7.05), (3.8, 7.35), (9.8, 7.35), (9.8, 7.05), stroke: (paint: design, thickness: 1.5pt), mark: (start: "straight", end: "straight"))

    content((6.8, 4.25), node([Write plan], fill: rgb("#f8fafc"), stroke: rgb("#cbd5e1")), name: "plan")
    line((6.8, 5.2), (6.8, 4.85), stroke: (paint: flow, thickness: 1.4pt), mark: (end: "straight"))

    content((6.8, 1.9), node([Execute], subtitle: [with tests and review], fill: rgb("#ecfdf5"), stroke: rgb("#86efac"), width: 170pt), name: "execute")
    line((6.8, 3.25), (6.8, 2.65), stroke: (paint: flow, thickness: 1.4pt), mark: (end: "straight"))

    content((13.1, 1.9), node([Review], subtitle: [human + AI agent], fill: rgb("#f0fdf4"), stroke: rgb("#86efac"), width: 180pt), name: "review")
    line((8.8, 1.9), (10.8, 1.9), stroke: (paint: flow, thickness: 1.4pt), mark: (end: "straight"))

    line((13.1, 1.0), (13.1, -0.3), (0.2, -0.3), (0.2, 5.2), (1.0, 5.2), stroke: (paint: results, thickness: 1.6pt), mark: (end: "straight"))
    content((7.0, -0.85), pill([results feedback loop back to BS session], results-fill, results))
  })
]
