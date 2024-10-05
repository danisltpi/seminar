#import "template.typ": project
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
 authors: (
   (name: "Danh Thien Luu", matriculation_number: "79663"),
 ),
 abstract: (
  [Jo was geht lol] 
 )
)

#show outline.entry.where(
  level: 1
): it => {
  strong(it)
}
#outline(indent: auto)

#pagebreak(weak: true)

= Motivation

Ein Fibonacci-Heap ist eine Datenstruktur, die Prioritätswarteschlangen implementiert.
Sie besteht aus mehreren Heaps (Binärbäume)

= Laufzeit

Daraus ergibt sich eine Laufzeit von $O(n log n)$ für das Hinzufügen eines Knotens bzw. $Theta(n log n)$

#pagebreak(weak: true)
#set page(header: [])
#bibliography("literatur.bib", style: "ieee", title: "Literatur")

