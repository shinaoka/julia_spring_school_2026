#import "@preview/cetz:0.4.1": *

#set page(width: 1000pt, height: 235pt, margin: 6pt)
#set par(justify: false)

#let slate = rgb("#0f172a")
#let muted = rgb("#64748b")
#let flow = rgb("#64748b")
#let warning = rgb("#c2410c")
#let warning-fill = rgb("#ffedd5")

#let human-fill = rgb("#fff7ed")
#let human-stroke = rgb("#fdba74")
#let weak-fill = rgb("#fef2f2")
#let weak-stroke = rgb("#fca5a5")
#let ai-fill = rgb("#eff6ff")
#let ai-stroke = rgb("#93c5fd")
#let result-fill = rgb("#f8fafc")
#let result-stroke = rgb("#cbd5e1")

#let gap = 0.24
#let flow-width = 1.6pt

#let human-cx = 4.1
#let human-cy = 4.2
#let human-w = 4.7
#let human-h = 1.6

#let weak-cx = 10.8
#let weak-cy = 4.2
#let weak-w = 5.5
#let weak-h = 2.0

#let ai-cx = 17.8
#let ai-cy = 4.2
#let ai-w = 5.4
#let ai-h = 2.0

#let result-cx = 24.6
#let result-cy = 4.2
#let result-w = 4.8
#let result-h = 1.6

#let left(cx, w) = cx - w / 2
#let right(cx, w) = cx + w / 2

#let node(title, width, height, subtitle: none, fill: white, stroke: rgb("#cbd5e1")) = box(
  width: width * 1cm,
  height: height * 1cm,
  inset: (x: 0.14cm, y: 0.1cm),
  radius: 0.38cm,
  fill: fill,
  stroke: 1.2pt + stroke,
)[
  #align(center + horizon)[
    #text(size: 17pt, weight: "bold", fill: slate)[#title]
    #if subtitle != none [
      #linebreak()
      #text(size: 11.5pt, fill: muted)[#subtitle]
    ]
  ]
]

#let pill(body, fill, color) = box(
  inset: (x: 0.32cm, y: 0.12cm),
  radius: 999pt,
  fill: fill,
)[
  #text(size: 13.5pt, weight: "bold", fill: color)[#body]
]

#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    content((11.9, 7.25), pill([one-shot flow, no feedback], warning-fill, warning))

    content((human-cx, human-cy), node([Human], human-w, human-h, fill: human-fill, stroke: human-stroke))
    content((weak-cx, weak-cy), node([Weak brainstorm], weak-w, weak-h, subtitle: [vague spell], fill: weak-fill, stroke: weak-stroke))
    content((ai-cx, ai-cy), node([AI generates], ai-w, ai-h, subtitle: [code instantly], fill: ai-fill, stroke: ai-stroke))
    content((result-cx, result-cy), node([Results], result-w, result-h, fill: result-fill, stroke: result-stroke))

    line(
      (right(human-cx, human-w) + gap, human-cy),
      (left(weak-cx, weak-w) - gap, weak-cy),
      stroke: (paint: flow, thickness: flow-width),
      mark: (end: ">"),
    )
    line(
      (right(weak-cx, weak-w) + gap, weak-cy),
      (left(ai-cx, ai-w) - gap, ai-cy),
      stroke: (paint: warning, thickness: flow-width),
      mark: (end: ">"),
    )
    line(
      (right(ai-cx, ai-w) + gap, ai-cy),
      (left(result-cx, result-w) - gap, result-cy),
      stroke: (paint: ai-stroke, thickness: flow-width),
      mark: (end: ">"),
    )

    content((11.9, 1.35), pill([no validation, no interpretation, no return loop], warning-fill, warning))
  })
]
