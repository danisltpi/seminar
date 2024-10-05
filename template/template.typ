#let buildMainHeader(mainHeadingContent) = {
  [
    #align(center, smallcaps(mainHeadingContent)) 
    #line(length: 100%)
  ]
}

#let buildSecondaryHeader(mainHeadingContent, secondaryHeadingContent) = {
  [
    #smallcaps(mainHeadingContent)  #h(1fr)  #emph(secondaryHeadingContent) 
    #line(length: 100%)
  ]
}

// To know if the secondary heading appears after the main heading
#let isAfter(secondaryHeading, mainHeading) = {
  let secHeadPos = secondaryHeading.location().position()
  let mainHeadPos = mainHeading.location().position()
  if (secHeadPos.at("page") > mainHeadPos.at("page")) {
    return true
  }
  if (secHeadPos.at("page") == mainHeadPos.at("page")) {
    return secHeadPos.at("y") > mainHeadPos.at("y")
  }
  return false
}

#let getHeader() = {
  locate(loc => {
    // Find if there is a level 1 heading on the current page
    let nextMainHeading = query(selector(heading).after(loc), loc).find(headIt => {
     headIt.location().page() == loc.page() and headIt.level == 1
    })
    if (nextMainHeading != none) {
      return buildMainHeader(nextMainHeading.body)
    }
    // Find the last previous level 1 heading -- at this point surely there's one :-)
    let lastMainHeading = query(selector(heading).before(loc), loc).filter(headIt => {
      headIt.level == 1
    }).last()
    // Find if the last level > 1 heading in previous pages
    let previousSecondaryHeadingArray = query(selector(heading).before(loc), loc).filter(headIt => {
      headIt.level > 1
    })
    let lastSecondaryHeading = if (previousSecondaryHeadingArray.len() != 0) {previousSecondaryHeadingArray.last()} else {none}
    // Find if the last secondary heading exists and if it's after the last main heading
    if (lastSecondaryHeading != none and isAfter(lastSecondaryHeading, lastMainHeading)) {
      return buildSecondaryHeader(lastMainHeading.body, lastSecondaryHeading.body)
    }
    return buildMainHeader(lastMainHeading.body)
  })
}

#let project(
  type: "",
  title: "",
  subtitle: "",
  module: none,
  study_program: "",
  institution: "",
  date: none,
  examiner: none,
  abstract: [],
  authors: (),
  logo: "",
  body
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set text(font: "New Computer Modern", lang: "de", region: "de", size: 11pt)
  show math.equation: set text(weight: 400)
  set heading(numbering: "1.1")
  set par(justify: true)

  v(2em)
  // Logo
  if logo != none {
    align(left, image(logo, width: 26%))
    line(length: 100%)
  } else {
    v(0.75fr)
  }

  // Title page.
  v(7em)
  align(center)[
    #text(1.1em, weight: 100, type)
  ]
  v(0.5em)
  align(center)[
    #text(1.6em, weight: 700, title)
  ]
  v(1em)
  align(center)[
    #text(1.3em, weight: 500, subtitle)
  ]
  v(2em)
  align(center)[
    im Studiengang \
    #study_program
  ]

  v(2em)
  align(center)[
    vorgelegt von \
  ]

  // Author information.
  pad(
    top: 0.7em,
    grid(
      columns: (1fr),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #if "matriculation_number" in author [
          Matrikelnummer:
          #author.matriculation_number \
        ]
        #if "email" in author [
          #author.email \
        ]
        #if "affiliation" in author [
          #author.affiliation \
        ]
        #if "postal" in author [
          #author.postal \
        ]
        #if "phone" in author [
          #author.phone
        ]
      ]),
    ),
  )

  v(2em)
  align(center)[
    an der #institution
  ]

  if date != none {
    align(center)[
      am #date
    ]
  }

  v(5em)
  line(length: 100%)
  if examiner != none {
    par[
      *Dozent*: #examiner
    ]
  }

  if module != none {
    par[
      *Veranstaltung*: #module
    ]
  }
  
  pagebreak()

  // Abstract page.
  if abstract != [] [
    #set page(numbering: "I", number-align: center)
    #v(1fr)
    #align(center)[
      #heading(
        outlined: false,
        numbering: none,
        text(0.85em, smallcaps[Zusammenfassung]),
      )
    ]
    #abstract
    #v(1.618fr)
    #counter(page).update(1)
    #pagebreak()

    // Table of contents.
    #outline(depth: 3, indent: true)
    #pagebreak()
  ]

  // Main body.
  set page(numbering: "1", number-align: center)
  // set page(header: getHeader())
  counter(page).update(1)
  body
}
