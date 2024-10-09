#import "template.typ": project
#import "@preview/cetz:0.2.2"

#set text(lang: "de", region: "de")
#set par(leading: 1em)
#show outline: set par(leading: 2em)
#show heading: it => [#pad(bottom: 1em, top: 1em)[#it]]

#show: project.with(
  title: "Fibonacci Heaps",
  subtitle: "Seminararbeit",
  study_program: "Informatik (INFB)",
  institution: "Hochschule Karlsruhe",
  date: datetime.today().display("[day].[month].[year]"),
  examiner: "Prof. Dr. rer. nat. Pape",
  logo: "hka.svg",
  authors: ((name: "Danh Thien Luu", matriculation_number: "79663"),),
)

#show outline.entry.where(level: 1): it => {
  strong(it)
}
#outline(indent: auto)

#pagebreak(weak: true)

= Motivation

Ein Fibonacci-Heap ist eine Datenstruktur, die Prioritätswarteschlangen implementiert und werden vielfältig eingesetzt.

Sie besteht aus mehreren Heaps (Binärbäume)

\
\

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    rect((-1, -1), (1, 1))
    circle((0, 0), fill: yellow, stroke: blue)
    line((0, 0), (2, 1))
    line((0, 0), (1.5, -1))
  })]

= Laufzeit

Daraus ergibt sich eine Laufzeit von $O(n log n)$ für das Hinzufügen eines Knotens bzw. $Theta(n log n)$

= Das ist ein Test

#lorem(100)

\

#figure(
  image("../assets/circle.svg", width: 100%),
  caption: [Beispielhafte Struktur eines Fibonacci Heaps, bestehend aus 5 Teilbäumen #lorem(50)],
  gap: 4em,
) <image>

= Erklärung

Wie man in der vorherigen Abbildung erkennen kann: @image

Dies ist besonders gut
#lorem(1000) @cormen_introduction_2009

#pagebreak(weak: true)
#set page(header: [])
#bibliography("literatur.bib", style: "ieee", title: "Literatur")

