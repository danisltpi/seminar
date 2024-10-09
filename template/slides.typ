#import "@preview/touying:0.5.2": *
#import "@preview/cetz:0.2.2"

#import themes.simple: *


#show: simple-theme.with(
  aspect-ratio: "16-9",
  header: self => self.info.title,
)

#title-slide[
  = Fibonacci Heaps
  #v(2em)
  Danh Thien Luu
  10. Oktober 2024
]

== Warum?

#lorem(20)

\
\

$
  Theta(lg n)
$

= Der Grund ist lol

== Deswegen ist das so

Did you know that...

#circle[
  #set align(center + horizon)
  Automatically \
  sized to fit.
]



== Beispiel

#let data = (
  [1],
  ([2], [3], [4]),
  ([5], [6]),
)

#align(center)[
  #cetz.canvas(
    length: 1.5em,
    {
      import cetz.draw: *

      set-style(
        content: (padding: .2),
        fill: black.lighten(90%),
        stroke: black.lighten(90%),
      )

      cetz.tree.tree(
        data,
        spread: 4,
        grow: 3,
        draw-node: (node, ..) => {
          circle((), radius: 1, stroke: none)
          content((), node.content)
        },
        draw-edge: (from, to, ..) => {
          line(
            (a: from, number: .6, b: to),
            (a: to, number: 1, b: from),
            mark: (end: ">"),
          )
        },
        name: "tree",
      )

      let (a, b) = ("tree.0-0-1", "tree.0-1-0")
      line((a, .6, b), (b, .6, a), mark: (end: ">", start: ">"))
    },
  )
]

== Beispiel

#align(center + horizon)[
  #figure(
    image("../assets/circle.svg", width: 100%),
  ) <image>
]