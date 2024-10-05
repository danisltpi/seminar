#import "template.typ": project
#set text(lang: "de", region: "de")
#set par(leading: 1em)
#show outline: set par(leading: 1.5em)
#show heading: it => [#pad(bottom: 0.5em)[#it]]

#show: project.with(
 type: "Seminar",
 title: "Fibonacci Heaps",
 subtitle: "",
 study_program: "Informatik",
 institution: "Hochschule Karlsruhe",
 date: datetime.today().display("[day].[month].[year]"),
 examiner: "Prof. Dr. rer. nat. Pape",
 logo: "hka.svg",
 authors: (
   (name: "Danh Thien Luu", matriculation_number: "79663"),
 ),
)

#show outline.entry.where(
  level: 1
): it => {
  strong(it)
}
#outline(indent: auto)

#pagebreak(weak: true)

= Beispiel
Dein Text hier

@GitHubCodellama2023 was geht

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.

== Beispiel 2

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.

#pagebreak(weak: true)
#set page(header: [])
#bibliography("literatur.bib", style: "institute-of-electrical-and-electronics-engineers")

