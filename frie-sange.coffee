# {{{1 Roadmap
#
# - overview 4x3 with links to 11 songs + 1 info on open content
# - full song (click on verse to open, swipe to next song, link til oversigt)
# - individual verse (swipe to next/previous verse - or back to full song)
#
# {{{2 Tasks
#
# - version 0.1.0
#   - the actual song texts
#   - open-content-info / motivation / description of sources etc.
#   - generate static html with linked data
# - version 0.2.0
#   - zoom/layout text to fit within window
#   - gesture handling
#   - zoom for individual verses
# - version 0.3.0
#   - graphics to each song, with metainfo on placement
#
# {{{1 Boilerplate
# predicates that can be optimised away by uglifyjs
if typeof isNodeJs == "undefined" or typeof runTest == "undefined" then do ->
  root = if typeof window == "undefined" then global else window
  root.isNodeJs = (typeof process != "undefined") if typeof isNodeJs == "undefined"
  root.isWindow = (typeof window != "undefined") if typeof isWindow == "undefined"
  root.isPhoneGap = typeof document?.ondeviceready != "undefined" if typeof isPhoneGap == "undefined"
  root.runTest = (if isNodeJs then process.argv[2] == "test" else location.hash.slice(1) == "test") if typeof runTest == "undefined"
use = if isWindow then ((module) -> window[module]) else require

# execute main
onReady = (fn) ->
  if isWindow
    if document.readystate != "complete" then fn() else setTimeout (-> onReady fn), 17 

# {{{1 code
uu = use "uutil"
if isNodeJs
  fs = require "fs"

lyricsJsonml = (song) ->
  ["div.lyrics"].concat song.lyrics.map (verse) ->
    ["div.verse"].concat verse.split("\n").map (line) ->
      ["div.line", ["rawhtml", line]]

style = ->
  body:
    font: "18px ubuntu,sans-serif"
    lineHeight: "130%"
  ".notes":
      marginTop: "1em"
      marginBottom: "1em"
  ".verse":
    margin: "2em"
    display: "inline-block"
  ".songButton":
    display: "inline-block"
    width: 200
    height: 200
    margin: 10
    padding: 15
    textAlign: "center"
    color: "black"
    textDecoration: "none"
    fontSize: 30
    border: "3px solid black"
    borderRadius: 25
    verticalAlign: "middle"

html = (title, body) ->
  "<!DOCTYPE html>" + uu.jsonml2html ["html"
    ["head"
      ["title", title]
      ["meta", {"http-equiv": "Content-Type", content: "text/html;charset=UTF-8"}]
      ["meta", {"http-equiv": "X-UA-Compatible", content: "IE=edge,chrome=1"}]
      ["meta"
        name: "viewport"
        content: "width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"]
      ["script", {src: "bower_components/uutil/uutil.js"}, ""]
      ["script", {src: "frie-sange.js"}, ""]
      ["style", ["rawhtml", "@font-face{font-family:Ubuntu;font-weight:400;src:url(/font/ubuntu-latin1.ttf) format(truetype);}"]]
      ["style", ["rawhtml", uu.obj2style style()]]
      ["meta", {name: "format-detection", content: "telephone=no"}]]
    ["body", body]]

songHTML = (song) -> html song.title, ["div", ["h1", song.title], lyricsJsonml song]

songs = []
song = (title, song) ->
  song.title = title
  song.lyrics = song.lyrics.split "\n\n"
  song.filename = "#{uu.urlString song.title}.html"
  songs.push song
  if isNodeJs
    fs.writeFile song.filename, songHTML song, "utf8"

if isNodeJs then process.nextTick ->
  pages = [{title: "Frie Børnesange", filename: "about.html"}].concat songs
  content = ["div"]
  for page in pages
    content.push ["a.songButton"
        href: page.filename
      # vertical centering hack
      ["div", { style: { display: "table", height: 200}}
        ["div", { style: { display: "table-cell", verticalAlign: "middle"}}
          page.title]]]

  fs.writeFile "index.html", html("Frie Børnesange", content), "utf8"

  fs.writeFile "about.html", html("Frie Børnesange", info), "utf8"


#{{{1 Information page
#
# - motivation
# - approach
#   - Songs are based on multible sources
#   - Most are traditionals
# - sources
#   - wikipedia
#   - ugle.dk
#   - din egen sangbog
#   - diverse søgeresultater ved søgning på nettet.
# - noter
#   - oppe i norge er en krydsning af den danske og oprindelige norske, med tilføjede vers, gendigtet, inspireret af http://www.barnesanger.no/olle-bolle.html
#   - lille peter eddekop det almindelige vers er frit / tradionelt, 
#     - øvrige vers blev tilføjet i 1948 og er ophavsretsligt begrænset
info = ["div"
    ["div"
        style:
          display: "inline-block"
          verticalAlign: "top"
          width: "44%"
          paddingLeft: "3%"
          paddingRight: "3%"
      ["h1", "Frie Børnesange"]
      ["div.notes", "Mange børnesange kan hverken synges offentligt, eller deles med andre på grund af ophavsretslige begrænsninger."]
      ["div.notes", "Dette er en samling af sange, der efter min bedste overbevisning ikke længere er dækket af copyright. De er fundet ved, for hver sang, at gennemsøge sangbøger og internet, og finde forskellige udgaver af sangen, og sikre der enten ikke er kendt forfatter, eller han/hun er død for over 70 år siden."]]
    ["div"
        style:
          display: "inline-block"
          verticalAlign: "top"
          width: "44%"
          paddingLeft: "3%"
          paddingRight: "3%"
      ["h1", "- de enkelte sange"]
      ["div.notes", ["em", "Oppe i Norge"], " er en dansk version af den norske børnesang Oppe i fjeldet. Versionen er en krydsning mellem den danske og den norske traditionelle sange, - med ekstra vers tilføjet på samme form som i den norske. De yderligere vers er gendigtet af undertegnede, frigives hermed som public domain (CC0)."]
      ["div.notes", ["em", "Lille Peter Eddekop"], " eksisterer så vidt jeg ved i flere udgaver: der det frie traditionelle vers, der anvendes her, men der er også en længere udgave hvor flere vers blev tilføjet i 1948, så yderligere vers man støder på, udover det traditionelle, er typisk under ophavsretslige begrænsninger."]]]
#{{{1 Actual songs
song "Der sad to katte på et bord", #{{{2
  lyrics: """
    Der sad to katte på et bord
    Kritte-ritte-rit bum bum
    Den ene på den anden glor
    Kritte-ritte-rit bum bum
    Så sa'e den ene: hør min ven
    Kritte-ritte-rit kritte-rit bum bum
    Sku' vi ikke kravle ned igen
    Kritte-ritte-rit bum bum

    Og da de så var kravlet ned
    Kritte-ritte-rit bum bum
    Så sa'e den anden: hør min ven
    Kritte-ritte-rit bum bum
    Sku vi ikke kravle op igen
    Kritte-ritte-rit kritte-rit bum bum
    Og så kravlede de op igen
    Kritte-ritte-rit bum bum

    Og da de så var kravlet op
    Kritte-ritte-rit bum bum
    Så sa'e den ene: hør min ven
    Kritte-ritte-rit bum bum
    Sku vi ikke kravle ned igen
    Kritte-ritte-rit kritte-rit bum bum
    Og så kravlede de ned igen
    Kritte-ritte-rit bum bum"""

song "En elefant kom marcherende", #{{{2
  lyrics: """
    En elefant kom marcherende
    hen ad eddekoppens fine spind
    syn's at vejen var så interessant
    at den byder op en anden elefant

    To elefanter kom marcherende
    hen ad eddekoppens fine spind
    syn's at vejen var så interessant
    at de byder op endnu en elefant

    Tre elefanter kom marcherende
    hen ad eddekoppens fine spind
    syn's at vejen var så interessant
    at de byder op endnu en elefant

    ??? elefanter kom marcherende
    hen ad eddekoppens fine spind
    syn's at vejen var så interessant
    at de byder op endnu en elefant..."""

song "Lille Peter Edderkop", #{{{2
  lyrics: """
    Lille Peter Edderkop,
      kravlede op ad muren.
    Så kom regnen
      og skyllede Peter ned,
    Så kom solen
      og tørrede Peters krop.
    Lille Peter Edderkop
      kravlede atter op."""

song "Mæ siger det lille lam", #{{{2
  lyrics: """
    Mæ, siger det lille lam,
    mor, jeg fryser, jeg vil hjem!
    Mæ, siger det store får,
    vent, til aftenklokken slår
    så skal du nok komme hjem. Mæ!

    Rap, siger ænderne små,
    nu skal det lystigt hjemad gå.
    Sove vi skal, til sol står op,
    så skal i vandet vi pjaske vor krop.
    Rap, siger ænderne små. Rap!

    Mjav, siger den lille kat,
    nu vil jeg sove så sødt i nat.
    I morgen skal vi lege igen,
    for jeg vil helst lege dagen hen.
    Mjav siger den lille kat. Mjav!

    Prr, siger den gamle hest,
    jeg vil trække som jeg kan bedst.
    Gid jeg stod i min varme stald
    og hørte i dag ej flere knald,
    Prrr siger den gamle hest. Prrr!

    Vov, siger den store hund,
    våge må jeg endnu en stund,
    fare om og passe på,
    at de trygt til ro kan gå.
    Vov, siger den store hund. Vov!"""

song "Ride ride ranke", #{{{2
  author: "Nikloaj Ulrik Krossing (1798-1872)"
  composer: "Johan Christian Gebauer (1808-1884)"
  lyrics: """
    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride ranke!
    Greven er så højt på strå,
    bonden må med træsko gå.
    Ride, ride, ranke!

    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride, ranke!
    Junkren på sin høje hest,
    som kan danse, ret gør blæst.
    Ride, ride, ranke!

    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride, ranke!
    Frøknen sidder let som fjer,
    som min lille rytter her.
    Ride, ride, ranke!

    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride, ranke!
    Hvorhen skal nu vejen gå?
    Bedstefar besøg skal få.
    Ride, ride, ranke!

    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride, ranke!
    Og når vi så stiger af,
    siger vi: go' da', go' da'!
    Ride, ride, ranke!

    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride, ranke!
    Bedstemor af hjertesgrund
    trykker os et kys på mund.
    Ride, ride, ranke!

    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride, ranke!
    Nu til onkel i galop.
    Er han hjemme? Ja, så stop!
    Ride, ride, ranke!

    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride, ranke!
    Tantes stuedør vil vi
    heller ikke gå forbi.
    Ride, ride, ranke!

    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride, ranke!
    Men nu er det aftenstid,
    lille hest, i stalden hid!
    Ride, ride, ranke!

    Hop, hop, hop, hop,
    hop, hop, hop, hop!
    Ride, ride, ranke!
    Til i morgen stå i ro,
    havre først: et kys ja to!
    Ride, ride, ranke!"""

song "Jeg gik mig over sø og land", #{{{2
  lyrics: """
    Jeg gik mig over sø og land,
    der mødte jeg en gammel mand.
    Han sagde så og spurgte så:
    Og hvor har du så hjemme?
    Jeg har hjemme i trampeland,
    trampeland, trampeland,
    alle de som trampe kan,
    de har hjemme i trampeland.

    Jeg gik mig over sø og land,
    der mødte jeg en gammel mand.
    Han sagde så og spurgte så:
    Og hvor har du så hjemme?
    Jeg har hjemme i vinkeland,
    vinkeland, vinkeland,
    alle de som vinke kan,
    de har hjemme i vinkeland.

    Jeg gik mig over sø og land,
    der mødte jeg en gammel mand.
    Han sagde så og spurgte så:
    Og hvor har du så hjemme?
    Jeg har hjemme i hoppeland,
    hoppeland, hoppeland,
    alle de som hoppe kan,
    de har hjemme i hoppeland.

    Jeg gik mig over sø og land,
    der mødte jeg en gammel mand.
    Han sagde så og spurgte så:
    Og hvor har du så hjemme?
    Jeg har hjemme i klappeland,
    klappeland, klappeland,
    alle de som klappe kan,
    de har hjemme i klappeland.

    Jeg gik mig over sø og land,
    der mødte jeg en gammel mand.
    Han sagde så og spurgte så:
    Og hvor har du så hjemme?
    Jeg har hjemme i hinkeland,
    hinkeland, hinkeland,
    alle de som hinke kan,
    de har hjemme i hinkeland.

    Jeg gik mig over sø og land,
    der mødte jeg en gammel mand.
    Han sagde så og spurgte så:
    Og hvor har du så hjemme?
    Jeg har hjemme i trommeland,
    trommeland, trommeland,
    alle de som tromme kan,
    de har hjemme i trommeland."""

song "Mester Jakob", #{{{2
  lyrics: """
    Mester Jakob, 
    Mester Jakob.
    Sover du, 
    sover du?
    Hører du ej klokken, 
    hører du ej klokken?
    Bim bam bum,
    bim bam bum."""

song "Oppe i Norge der boede tre trolde", #{{{2
  lyrics: """
    Oppe i Norge, der boede tre trolde,
    troldefar og troldemor og lille olle-bolle 
    BØH sagde troldefar
    Bøh sagde troldemor
    og den lille olle bolle sagde bare <small>bøh</small>

    Ude i skoven, der boede tre bjørne,
    bjørnefar og bjørnemor, og lille ørne-børne
    ROAR sagde bjørnefar
    Roar sagde bjørnemor
    og den lille ørne-børne sagde bare <small>roar</small>

    Oppe på loftet, der boede tre katte,
    kattefar og kattemor, og lille katte-batte
    MJAV sagde kattefar
    Mjav sagde kattemor
    og den lille katte-batte sagde bare <small>mjav</small>

    Ude på marken, der boede tre heste,
    hestefar og hestemor, og lille heste-beste
    PRR sagde hestefar
    Prr sagde hestemor
    og den lille heste-beste sagde bare <small>prr</small>

    Oppe i træet, der boede tre krager,
    kragefar og kragemor, og lille krage-brage
    KRRA sagde kragefar
    Krra sagde kragemor
    og den lille krage-brage sagde bare <small>krra</small>"""

song "Tommelfinger, tommelfinger hvor er du", #{{{2
  lyrics: """
    Tommelfinger, tommelfinger,
    hvor er du?
    Her er jeg, her er jeg
    Goddag, goddag, goddag.
    
    Pegefinger, pegefinger,
    hvor er du?
    Her er jeg, her er jeg
    Goddag, goddag, goddag.
    
    Langefinger, langefinger,
    hvor er du?
    Her er jeg, her er jeg
    Goddag, goddag, goddag.
    
    Ringefinger, ringefinger,
    hvor er du?
    Her er jeg, her er jeg
    Goddag, goddag, goddag.
    
    Lillefinger, lillefinger,
    hvor er du?
    Her er jeg, her er jeg
    Goddag, goddag, goddag.
    
    Alle fingre, alle fingre,
    hvor er I?
    Her er vi, her er vi,
    Goddag, goddag, goddag."""

song "I skoven skulle være gilde", #{{{2
  lyrics: """
    I skoven skulle være gilde
    alt hos den gamle ørn,
    som jo så gerne ville
    fornøje sine børn.
    Og alle fugle sjunge
    og røre deres tunge,
    så snart som lærken gi'r signal
    af næbbets futteral,
    så snart som lærken gi'r signal
    af næbbets futteral.
    
    At byde gæster mange
    den hane skulle gå,
    han havde ben så lange
    med krumme sporer på.
    Han råbte: "Kykliky!"
    tre gange i hver by,
    at byde alle fugle små
    til ørnens gilde så,
    at byde alle fugle små
    til ørnens gilde så.
    
    Den tømmermand, hr. spætte,
    han skulle bygge hus,
    og svalen taget tætte
    med skovens grønne mos.
    Og salen skulle pyntes,
    hvor gildet skulle stå,
    med røde sneglehuse
    og fine bolstre blå,
    med røde sneglehuse
    og fine bolstre blå.
    
    Og ravnen skulle også
    være deres præst,
    hans sorte kjole viste,
    at han var kaldet næst.
    Han var en højlærd Mand,
    klog over al forstand,
    han holdt den bedste prædiken,
    der hørtes i vort land,
    han holdt den bedste prædiken,
    der hørtes i vort land.
    
    Og stæren skulle også
    være deres degn,
    han kan så dejlig synge,
    skønt han er meget klejn.
    Hans sang den er en lyst,
    han har en dejlig røst,
    han er jo ren i mælet
    og dertil let for bryst,
    han er jo ren i mælet
    og dertil let for bryst.
    
    De havde og to spillemænd,
    og de var meget små,
    det var den lille nattergal
    og så den lærke grå.
    De spilled menuet,
    og det gik nok så net,
    til alle udi dansen
    var bleven ganske træt,
    til alle udi dansen
    var bleven ganske træt.
    
    Og uglen var til gilde,
    hun drak sig ganske fuld,
    om aftenen så silde
    hun faldt i græs omkuld.
    Hun råbte med stor klage:
    "I alle mine dage,
    ja alle mine dage
    stor nød jeg lide må,
    ja alle mine dage
    stor nød jeg lide må".
    
    Og ørnen gik til hende
    og sagde: "Hør, min ven,
    når mener du, at du vel
    kan komme dig igen?"
    "O ve, o ve, o plage,
    jeg kan det godt forstå,
    at mine levedage,
    de er nu ganske få,
    at mine levedage,
    de er nu ganske få"."""

song "Langt ude i skoven", #{{{2
  lyrics: """
    Lange ude i skoven, der lå et lille bjerg,
    aldrig så jeg, så dejligt et bjerg:
    Bjerget ligger langt ude i skoven.

    På det lille bjerg, der stod et lille træ,
    aldrig så jeg så dejligt et træ:
    Træet på bjerget.
    Bjerget ligger langt ude i skoven.

    På det lille træ, der sad en lille gren,
    aldrig så jeg så dejlig en gren:
    Grenen på træet.
    Træet på bjerget.
    Bjerget ligger langt ude i skoven.

    På den lille gren, der sad en lille kvist,
    aldrig så jeg så dejlig en kvist:
    Kvisten på grenen.
    Grenen på træet.
    Træet på bjerget.
    Bjerget ligger langt ude i skoven.

    På den lille kvist, der sad et lille blad,
    aldrig så jeg så dejligt et blad:
    Bladet på kvisten.
    Kvisten på grenen.
    Grenen på træet.
    Træet på bjerget.
    Bjerget ligger langt ude i skoven.

    På det lille blad, der var en lille rede,
    aldrig så jeg så dejlig en rede:
    Reden på bladet.
    Bladet på kvisten.
    Kvisten på grenen.
    Grenen på træet.
    Træet på bjerget.
    Bjerget ligger langt ude i skoven.

    I den lille rede var et lille æg,
    aldrig så jeg så dejligt et æg:
    Ægget i reden.
    Reden på bladet.
    Bladet på kvisten.
    Kvisten på grenen.
    Grenen på træet.
    Træet på bjerget.
    Bjerget ligger langt ude i skoven.

    Af det lille æg der kom en lille fugl,
    aldrig så jeg så dejlig en fugl:
    Fuglen af ægget.
    Ægget i reden.
    Reden på bladet.
    Bladet på kvisten.
    Kvisten på grenen.
    Grenen på træet.
    Træet på bjerget.
    Bjerget ligger langt ude i skoven.

    På den lille fugl der sad en lille fjer.
    aldrig så jeg så dejlig en fjer:
    Fjeren på fuglen.
    Fuglen af ægget.
    Ægget i reden.
    Reden på bladet.
    Bladet på kvisten.
    Kvisten på grenen.
    Grenen på træet.
    Træet på bjerget.
    Bjerget ligger langt ude i skoven.

    Af den lille fjer der blev en lille pude,
    aldrig så jeg så dejlig en pude:
    Puden af fjeren.
    Fjeren på fuglen.
    Fuglen af ægget.
    Ægget i reden.
    Reden på bladet.
    Bladet på kvisten.
    Kvisten på grenen.
    Grenen på træet.
    Træet på bjerget.
    Bjerget ligger langt ude i skoven.

    På den lille pude der lå en lille dreng,
    aldrig så jeg så dejlig en dreng:
    Drengen på puden.
    Puden af fjeren.
    Fjeren på fuglen.
    Fuglen af ægget.
    Ægget i reden.
    Reden på bladet.
    Bladet på kvisten.
    Kvisten på grenen.
    Grenen på træet.
    Træet på bjerget.
    Bjerget ligger langt ude i skoven."""
