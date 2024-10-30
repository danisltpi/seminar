#import "template.typ": project
#import "@preview/cetz:0.2.2"
#import "@preview/lovelace:0.3.0"

#set text(lang: "de", region: "de")
#set par(leading: 1em)
// #show outline: set par(leading: 2em)
#show heading: it => [#pad(bottom: 1em, top: 1em)[#it]]
#show figure: set block(inset: (top: 0.5em, bottom: 2em))
#show smallcaps: set text(font: "Latin Modern Roman Caps")


#show: project.with(
  title: "Fibonacci Heaps",
  subtitle: "Seminararbeit im Wintersemester 24/25",
  study_program: "Informatik (INFB)",
  institution: "Hochschule Karlsruhe",
  date: datetime.today().display("[day].[month].[year]"),
  examiner: "Prof. Dr. rer. nat. Pape",
  logo: "hka.svg",
  authors: ((name: "Danh Thien Luu", matriculation_number: "79663"),),
)

// #show outline.entry.where(level: 1): it => {
//   strong(it)
// }
// #outline(indent: auto)

#pagebreak(weak: true)


// 1. Einleitung
//    - Einführung in das Thema: Warum sind Datenstrukturen wie Heaps wichtig?
//    - Motivation: Wofür werden Fibonacci-Heaps verwendet und was ist ihr Nutzen?
//    - Ziel: Was soll die Arbeit vermittlen
// 2. Grundlagen
//    - Kurze Einleitung in Heaps
//    - (Fibonacci-Folge: Die Bedeutung von Fibonacci Folge für Fibonacci-Heaps)
//    - Problemstellung: Typische Probleme die mit Heaps gelöst werden (Dijkstra o. Prim)
// 3. Fibonacci-Heaps: Definition und Struktur
//    - Definition: Was ist ein Fibonacci-Heap?
//    - Struktur:
//      - Wurzel List
//      - Rangkonzept
//      - Knotenstruktur (markiert u. unmarkiert)
//    - Besonderheiten im Vergleich zu anderen Heaps
// 4. Operationen in Fibonacci-Heaps
//    - Insert
//    - Find Minimum
//    - Extract Minimum
//    - Union
//    - Decrease Key
//    - Delete
//    - (Laufzeitanalyse oder Operationen)
// 5. Anwendungen
//    - Dijkstra, Prim
// 6. Vergleich zu Binomial Heap, Relaxed Heap, Strict Fibonacci Heap


= Einleitung

// In der heutigen Welt sind Navigationsgeräte direkt eingebaut im Handy z.b. durch Google Maps, die dass alltägliche Leben vereinfachen in dem sie den kürzesten Weg von unseren derzeitigen Ort und den Ort, zu dem wir hin wollen finden.
// z.B. zur Hochschule um die nächste Vorlesung nicht zu verpassen.

== Motivation

In der heutigen Zeit sind Navigationsdienste wie Google Maps auf unseren Smartphones unverzichtbar geworden, in dem sie den kürzesten Weg von unserem Standort zu unserem Ziel berechnen. Ein geläufiges Beispiel wäre hier die Nutzung von Google Maps um den schnellsten Weg zur Hochschule zu finden, damit die nächste Vorlesung nicht verpasst wird!

\

// Die zugrundeliegenden Algorithmen für diese, sind Algorithmen, die den kürzesten Pfad zwischen zwei Knoten in einem Graph finden. Ein sehr prominenter
// wäre z.B. Dijkstra's Algorithmus.

Die Algorithmen, die Google Maps & Co zugrunde liegen,
berechnen den kürzesten Pfad zwischen zwei Knoten in einem Graphen.

Ein prominentes Beispiel dafür ist der Dijkstra-Algorithmus, dem dies in einem gewichteten Graphen gelingt, solange die Kantengewichte positiv sind. @cormen_introduction_2009

Zu beachten ist aber, dass der Dijkstra-Algorithmus ein gieriger Algorithmus ist, d.h. der Algorithmus arbeitet den Knoten ab, der im Moment am attraktivsten erscheint. @cormen_introduction_2009

// Um diese zu realisieren sind Prioritätswarteschlangen nötig, damit der nächste best mögliche Knoten abgearbeitet werden kann.

Daher ist die Nutzung von Prioritätswarteschlangen wichtig um zu entscheiden, welcher Knoten nun als nächstes abgearbeitet werden soll. @cormen_introduction_2009

\

// Die schnellsten Implementierung von Dijkstras Algorithmus benutzt Fibonacci-Heaps als Implementierung für Prioritätswarteschlangen. @ft87

Die schnellsten Implementierungen vom Dijkstra-Algorithmus
benutzen Fibobonacci-Heaps als effiziente Datenstruktur
für die Prioritätswarteschlangen. @ft87

\

== Ziel

Wir möchten uns daher in dieser Arbeit mit Fibonacci-Heaps beschäftigen um zu verstehen, warum sie so effizient sind,
was sie im Vergleich zu anderen Datenstrukturen besonders macht und zuletzt auch, inwiefern die Fibonacci-Folge eine Rolle spielt.

Dabei wird sowohl auf den Aufbau und die Struktur, als auch die Operationen und die jeweiligen Laufzeiten eingegangen.

#pagebreak(weak: true)

= Grundlagen

== Prioritätswarteschlangen

Viele Algorithmen benötigen Prioritätswarteschlangen. Vor allem gierige Algorithmen,
da diese oft den aktuellen minimalen bzw. maximalen Wert einer Menge brauchen, mit denen sie arbeiten können.

Wir wollen uns daher mit der Datenstruktur der Prioritätswarteschlange vertraut machen.

Eine Prioritätswarteschlange ist einer normalen Warteschlange ähnlich, mit dem Zusatz, dass jedem Element eine gewisse Priorität zugewiesen wird.
Anhand dieser Priorität wird das nächste Element bestimmt, wenn das aktuelle Element entfernt wird.

Sie pflegt daher eine Menge _S_, wobei jedes Element mit einer Priorität _k_ assoziiert wird.
Die Prioritätswarteschlange sollte dann folgende Operationen unterstützen @cormen_introduction_2009:

\

#smallcaps[Insert]$(S, x)$: Fügt das Element _x_ in die Menge _S_ ein.

\


#smallcaps[Minimum]$(S)$: Gibt das Element mit der kleinsten Priorität zurück.

\


#smallcaps[Extract-Min]$(S)$: Löscht und gibt das Element mit der kleinsten Priorität zurück.

\

#smallcaps[Decrease-Key]$(S, x, k)$: Verringert die Priorität des Elements _x_ auf den Wert _k_, welches kleiner oder gleich dem aktuellem Wert von _x_ ist.

\

Wir werden im Laufe der Arbeit sehen, dass Fibonacci-Heaps sehr effiziente Implementierungen von Prioritätswarteschlangen sein können.

== Heaps

Um zu verstehen wie ein Fibonacci-Heap funktioniert müssen wir uns auch mit ihrer zugrundeliegenden Datenstruktur -- den Heaps auseinandersetzen.

Heaps sind baumbasierte abstrakte Datenstrukturen, die einige besondere Eigenschaften vorweisen.

Die wichtigste Eigenschaft von Heaps ist die *_Heap-Bedingung_*, die jeder Heap erfüllen muss. Diese hat zufolge, dass jeder Wert jedes Knotens kleiner oder gleich (bzw. größer oder gleich bei einem _Max-Heap_) dem Wert seiner Kinder ist d.h. der kleinste (bzw. größte) Wert hat die Wurzel. @cormen_introduction_2009

Diese machen Heaps zu einer geeigneten Datenstruktur für Prioritätswarteschlangen! @cormen_introduction_2009
Sie werden auch für Heapsort -- einem effizientem Sortieralgorithmus angewendet @cormen_introduction_2009 und sind Bestandteil der Fibonacci-Heaps. @cormen_introduction_2009

Heaps kommen daher in vielen Algorithmen und Datenstrukturen häufig zum Einsatz.

\


=== Definition

Heaps können als Array dargestellt werden oder in einem Baum, wobei jedes Element in dem Array ein Knoten vom Baum ist.

Ein Heap ist _komplett_, was bedeutet, dass alle Ebenen, bis auf die unterste, vollständig gefüllt sein müssen.

$A$._length_ ist die Anzahl der Elemente im Array. (Kapazität)

$A$._heap-size_ ist die Anzahl der Elemente im Array, die tatsächlich Teil der Heap-Struktur sind. (Aktuelle Größe)

Die _Höhe_ eines Knoten im Heap ist die Anzahl der Kanten auf dem längsten Pfad zu einem Blattknoten.

Die Knoten auf der untersten Ebene werden immer von Links nach Rechts eingefügt.

Es gibt zwei Typen von Heaps: _Min-Heap_ und _Max-Heap_.

Für Fibonacci-Heaps betrachten wir _Min-Heaps_.

Das Array $A$ repräsentiert den Heap und $A[1]$ ist das erste Element im Array also die Wurzel des Heaps.

\

#figure(
  image("../assets/heap-with-index.drawio.svg", width: 80%),
  caption: [
    Beispiel für ein _Min-Heap_ in der Darstellung als Binärbaum, bei dem der Knoten mit dem kleinsten Wert die Wurzel ist. Die Zahl über dem Knoten ist der Index im Array.
  ],
)

\

#figure(
  image("../assets/heap-as-array.drawio.svg", width: 80%),
  caption: [
    Der selbe Heap als Array dargestellt.
    Die Pfeile über und unter dem Array stellen Eltern-Kind Beziehungen dar.
    Die Eltern sind immer links von den Kindern.
  ],
)

=== Heap-Bedingung
Sei ein Heap $A$ gegeben und $A[i]$ der Wert des Knotens mit dem Index $i$.

Für _Min-Heaps_ lautet die Bedingung:

\

$
  A["Parent"(i)] <= A[i]
$

\

Sie besagt, dass jeder Knoten einen Wert hat, der kleiner oder gleich dem Wert seiner Kinder ist. Dies führt dazu, dass die Wurzel des Heaps den kleinsten Wert hat. @cormen_introduction_2009

=== Grundlegende Operationen von Heaps

Heaps können als Binärbäume gesehen werden, (es gibt aber auch Heaps, die mehr als zwei Kinder haben können, wie es z.B. bei Fibonacci-Heaps der Fall ist)
daher hat jeder Knoten ein linkes Kind, ein rechtes Kind und ein Elternteil. @cormen_introduction_2009

#lovelace.pseudocode-list[

  #smallcaps[Parent]$(i)$
  + return $floor(i/2)$
]

#lovelace.pseudocode-list[
  #smallcaps[Left]$(i)$
  + return $2i$
]

#lovelace.pseudocode-list[
  #smallcaps[Right]$(i)$
  + return $2i + 1$
]

\

Um die _Min-Heap-Bedingung_ beizubehalten benötigen wir folgende Operation.

#lovelace.pseudocode-list()[
  #smallcaps[Min-heapify]$(A, i)$
  + $l =$ #smallcaps[Left]$(i)$
  + $r =$ #smallcaps[Right]$(i)$
  + *if* $l <= A.$_heap-size_ and $A[l] < A[i]$
    + _smallest_ $= l$
  + *else* _smallest_ = i
  + *if* $r <= A.$_heap-size_ and $A[r] < A[$_smallest_$]$
    + _smallest_ $= r$
  + *if* _smallest_ $!= i$
    + exchange $A[i]$ with $A[$_smallest_$]$
    + #smallcaps[Min-Heapify]$(A,$ _smallest_$)$
]

Sie prüft ob der Teilbaum am Index $i$ die _Min-Heap-Bedingung_ erfüllt, also ob
der Wert der Wurzel kleiner ist, als der Wert ihrer Kinder.
Falls dies nicht der Fall ist tauscht sie die Knoten rekursiv bis die
Bedingung erfüllt ist.
$cal(O)(lg n)$ bietet die obere Schranke für die Laufzeit dieser Operation. @cormen_introduction_2009


\

Um aus einem Eingabe-Array ein Heap zu produzieren benötigen wir folgende Operation.

#lovelace.pseudocode-list[
  #smallcaps[Build-Min-Heap]$(i)$
  + $A.italic("heap-size") = A.italic("length")$
  + *for* $i = floor((A.italic("length")) / 2)$ *downto* $1$
    + #smallcaps[Min-Heapify]$(A, i)$
]



=== Operationen für Prioritätswarteschlangen

Zusätzlich müssen wir neben den Operationen,
die wir für Prioritätswarteschlangen brauchen,
auch einige weitere Operationen unterstützen,
um Heaps als Prioritätswarteschlange zu benutzen.
\

- #smallcaps[Insert]
- #smallcaps[Build-Min-Heap]
- #smallcaps[Extract-Min]
- #smallcaps[Decrease-Key]
- #smallcaps[Minimum]
\

// Die Implementierungen in Pseudocode könnten wie folgt aussehen:

// #lovelace.pseudocode-list[
//   $"INSERT"(A, italic("key"))$
//   + A.
// ]


=== Beispiele


// == Problemstellungen
// Heaps alleine können bereits als Prioritätswarteschlange agieren,
// in dem sie

// == Fibonacci-Folge


== Verkettete Listen

= Idee

Der Hintergrund eines Fibonacci-Heap ist es,
die Laufzeiten der Heaps als Prioritätswarteschlange zu optimieren.

Vor allem in Anwendungen, die sehr häufig von den Priotiätswarteschlange-Operationen gebrauch machen ist das Interesse groß diese Laufzeiten zu verbessern.

\

Dazu möchten wir zunächst einen *_Mergeable-Heap_* einführen, welches u.a. durch einen Fibonacci-Heap implementiert werden kann.
Zusätzlich zu den geläufigen Heap-Operationen unterstützen sie die #smallcaps[Union]-Operation, welches ermöglicht, zwei verschiedene Mergeable-Heaps zu verschmelzen und zu einem zu machen. @cormen_introduction_2009

\

Anhand @laufzeiten können wir erkennen, dass
die amortisierten Laufzeiten für #smallcaps[Decrease-Key] und
#smallcaps[Insert] sind bei Fibonacci-Heaps besser.
Bei #smallcaps[Union] können auch deutliche Verbesserungen
in der Laufzeit erreicht werden.
Bei den sonstigen Operationen bleiben die Laufzeiten ähnlich.

#figure(
  table(
    columns: 3,
    table.header(
      [*Operation*],
      [*Binär-Heap* \ (worst case)],
      [*Fibonacci-Heap* \ (amortisiert)],
    ),

    [#smallcaps[Make-Heap]], [$Theta(1)$], [$Theta(1)$],
    [#smallcaps[Insert]], [$Theta(lg n)$], [$Theta(1)$],
    [#smallcaps[Minimum]], [$Theta(1)$], [$Theta(1)$],
    [#smallcaps[Extract-Min]], [$Theta(lg n)$], [$cal(O)(lg n)$],
    [#smallcaps[Union]], [$Theta(n)$], [$Theta(1)$],
    [#smallcaps[Decrease-Key]], [$Theta(lg n)$], [$Theta(1)$],
    [#smallcaps[Delete]], [$Theta(lg n)$], [$cal(O)(lg n)$],
  ),
  caption: [Die Laufzeiten der Operationen eines Mergeable-Heaps im Vergleich, wenn sie durch binäre Heaps bzw. Fibobonacci-Heaps
    implementiert werden.
    Dabei ist $n$ die Anzahl an Elementen im Heap zur Zeit der Operation.
    @cormen_introduction_2009],
) <laufzeiten>

Diese Laufzeit-Verbesserungen sind zurückzuführen auf
das Prinzip, in einem Fibonacci-Heap die zeitintensive "Arbeit" zeitlich nach hinten zu verschieben (z.B. wenn die #smallcaps[Extract-Min]-Operation ausgeführt wird), so dass die amortisierten
Laufzeiten der #smallcaps[Decrease-Key], #smallcaps[Insert] und #smallcaps[Union]-Operationen im Durchschnitt besser sind.

Die zeitlich anspruchsvollste Arbeit nach einem
#smallcaps[Extract-Min] ist es nämlich, den nächsten Knoten
mit der kleinsten Priorität zu finden und wieder die
_Min-Heap-Bedigung_ wiederherzustellen.

Wir sehen auch, dass sowohl Fibonacci-Heaps als auch Binär-Heaps
relativ langsam sind, wenn wir #smallcaps[Delete] ausführen wollen.
Das liegt daran, dass das Suchen nach einem spezifischem Knoten
in beiden Datenstrukturen auch $cal(O) (lg n)$ braucht.


= Aufbau und Struktur

Nachdem wir die Grundlagen verstanden haben kommen wir nun zu den eigentlichen Fibonacci-Heaps.

Ein _Fibonacci-Heap_ ist eine Sammlung, aus Bäumen, die jeweils die _Min-Heap-Bedingung_ erfüllen, also der Wert eines Knotens ist immer größer oder gleich des Werts seines Elternteils. Den Wert eines Knotens können wir folgend _Priorität_ nennen.

Jeder Knoten $x$ enthält einen Verweis auf ihr Elternknoten $x.p$ und auf eines ihrer Kinder $x.italic("child")$.

Die Kinder sind miteinander verkettet in einer _zirkulären doppelt verketteten Liste_. Diese Liste nennen wir _child list_ von _x_.

Jedes Kind $y$ der _child list_ enthält Verweise auf auf ihr linken und rechten Geschwisterknoten mit _y.left_ und _y.right_.
Die Geschwister können in der _child list_ dann in jeglicher Reihenfolge auftreten.

Falls _y_ ein Einzelkind ist, dann ist _y.left_ = _y.right_ = _y_.

Durch die _zirkuläre doppelt verkettete Liste_ können in konstanter Laufzeit
überall innerhalb der Liste ein Knoten hinzugefügt werden. Zusätzlich können wir einfach zwei verschiedene Listen vereinen, was auch in konstanter Zeit passiert.

= Operationen

== #smallcaps[Union]

== #smallcaps[Insert]

== #smallcaps[Extract-Min]

// == #smallcaps[Consolidate]

== #smallcaps[Decrease-Key]

== #smallcaps[Delete]

= Laufzeitanalyse

= Vergleich zu anderen Datenstrukturen

= Anwendungen



#pagebreak(weak: true)
#set page(header: [])
#bibliography("literatur.bib", style: "ieee", title: "Literatur")

