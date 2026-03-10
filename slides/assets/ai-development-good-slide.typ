#import "@preview/cetz:0.4.1": *

#set page(width: 1000pt, height: 240pt, margin: 6pt)
#set par(justify: false)

#let slate = rgb("#0f172a")
#let muted = rgb("#64748b")
#let flow = rgb("#475569")
#let design = rgb("#2563eb")
#let design-fill = rgb("#dbeafe")
#let design-bg = rgb("#f8fbff")
#let success = rgb("#5f9f78")
#let success-fill = rgb("#e8f3ec")
#let results = rgb("#15803d")
#let results-fill = rgb("#d7eadc")

#let gap = 0.22
#let inner-gap = 0.06
#let inner-link-offset = 0.18
#let flow-width = 1.55pt
#let loop-width = 1.75pt

#let bs-left = 1.6
#let bs-right = 13.2
#let bs-bottom = 3.1
#let bs-top = 7.45

#let human-cx = 4.28
#let human-cy = 5.55
#let human-w = 5.2
#let human-h = 1.55

#let ai-cx = 10.28
#let ai-cy = 5.55
#let ai-w = 5.2
#let ai-h = 1.55

#let plan-cx = 16.65
#let plan-cy = 5.55
#let plan-w = 5.1
#let plan-h = 1.55

#let exec-cx = 23.0
#let exec-cy = 5.55
#let exec-w = 5.9
#let exec-h = 1.85

#let review-cx = 29.9
#let review-cy = 5.55
#let review-w = 6.2
#let review-h = 1.55

#let feedback-x = (bs-left + bs-right) / 2
#let feedback-y = 1.85

#let left(cx, w) = cx - w / 2
#let right(cx, w) = cx + w / 2
#let top(cy, h) = cy + h / 2
#let bottom(cy, h) = cy - h / 2

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

    rect((bs-left, bs-bottom), (bs-right, bs-top), stroke: (paint: design, thickness: 1.3pt), fill: design-bg)

    content((2.9, 7.9), pill([BS session], design-fill, design))
    content((9.25, 7.9), pill([design feedback loop], design-fill, design))

    content((human-cx, human-cy), node([Human], human-w, human-h, fill: rgb("#fff7ed"), stroke: rgb("#fdba74")))
    content((ai-cx, ai-cy), node([AI], ai-w, ai-h, fill: rgb("#eff6ff"), stroke: rgb("#93c5fd")))
    content((plan-cx, plan-cy), node([Write plan], plan-w, plan-h, fill: rgb("#f8fafc"), stroke: rgb("#cbd5e1")))
    content((exec-cx, exec-cy), node([Execute], exec-w, exec-h, subtitle: [with tests and review], fill: success-fill, stroke: success))
    content((review-cx, review-cy), node([Review results], review-w, review-h, fill: success-fill, stroke: success))

    // Brainstorm loop above the BS block.
    line(
      (human-cx, top(human-cy, human-h) + gap),
      (human-cx, 7.25),
      (ai-cx, 7.25),
      (ai-cx, top(ai-cy, ai-h) + gap),
      stroke: (paint: design, thickness: 1.5pt),
      mark: (start: ">", end: ">"),
    )

    // Human <-> AI interaction inside the BS block.
    line(
      (right(human-cx, human-w) + inner-gap, human-cy - inner-link-offset),
      (left(ai-cx, ai-w) - inner-gap, ai-cy - inner-link-offset),
      stroke: (paint: design, thickness: flow-width),
      mark: (end: ">"),
    )
    line(
      (left(ai-cx, ai-w) - inner-gap, ai-cy + inner-link-offset),
      (right(human-cx, human-w) + inner-gap, human-cy + inner-link-offset),
      stroke: (paint: design, thickness: flow-width),
      mark: (end: ">"),
    )

    // Main execution chain with edge-aligned gaps.
    line(
      (right(ai-cx, ai-w) + gap, ai-cy),
      (left(plan-cx, plan-w) - gap, plan-cy),
      stroke: (paint: flow, thickness: flow-width),
      mark: (end: ">"),
    )
    line(
      (right(plan-cx, plan-w) + gap, plan-cy),
      (left(exec-cx, exec-w) - gap, exec-cy),
      stroke: (paint: flow, thickness: flow-width),
      mark: (end: ">"),
    )
    line(
      (right(exec-cx, exec-w) + gap, exec-cy),
      (left(review-cx, review-w) - gap, review-cy),
      stroke: (paint: flow, thickness: flow-width),
      mark: (end: ">"),
    )

    // Results feed back into the lower side of the BS block.
    line(
      (review-cx, bottom(review-cy, review-h) - gap),
      (review-cx, feedback-y),
      (feedback-x, feedback-y),
      (feedback-x, bs-bottom),
      stroke: (paint: results, thickness: loop-width),
      mark: (end: ">"),
    )
    content((18.65, 1.28), pill([results feedback loop back to BS session], results-fill, results))
  })
]
