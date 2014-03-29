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
isTouch = false
once = (fn) ->
  run = true
  result = undefined
  (e) ->
    e.preventDefault()
    isTouch = true if e.touches
    return if (!e.touches) && isTouch
    if run
      run = false
      fn.call this
    return false

if isNodeJs
  fs = require "fs"

style = -> #{{{2
  if isNodeJs
    w = 960
    h = 480
  else
    w = window.innerWidth
    h = window.innerHeight

  unit = Math.sqrt(w*h)/100

  outerMargin = 2 * unit | 0
  w -= outerMargin * 2
  h -= outerMargin * 2

  buttonSize = Math.max(4 * unit, 44)
  buttonPadPos = 0

  #{{{3 layout of squares
  lineWidth = (unit * .2 + 1) | 0
  sqSize = (if w > h then Math.min(w/4, h/3) else Math.min(w/3, h/4)) | 0
  sqMargin = unit | 0
  sqPadding = unit | 0
  sqInner = sqSize - (sqMargin + sqPadding + lineWidth) * 2 - 6
  sqCols = if w > h then 4 else 3
  if !isNodeJs
    songButton.style.paddingTop = songButton.style.paddingBottom = "0px" for songButton in document.getElementsByClassName "songButton"
    uu.nextTick ->
      i = 0
      for songButton in document.getElementsByClassName "songButton"
        songButton.style.position = "absolute"
        songButton.style.top = "#{outerMargin + sqMargin + sqSize * (i/sqCols|0)}px"
        songButton.style.left = "#{outerMargin + sqMargin + sqSize * (i%sqCols|0)}px"
        padding = (sqSize - songButton.offsetHeight) - 2 * sqMargin
        songButton.style.paddingTop = (padding * .45 | 0) + "px"
        songButton.style.paddingBottom = (padding * .55 | 0) + "px"
        ++i


  #{{{3 utility
  arraySum = (arr) -> arr.reduce (a,b) -> a + b
  splitEven = (arr, n) ->
    total = arraySum arr
    subtotal = 0
    result = []
    subresult = []
    for elem in arr
      if (subtotal + elem) > (total * n)
        result.push subresult if subresult.length
        subtotal = elem
        subresult = [elem]
      else
        subresult.push elem
        subtotal += elem
    result.push subresult if subresult.length
    return result
    

  #{{{3 layout of verses
  if !isNodeJs
    lyrics = document.getElementsByClassName("lyrics")[0]
    if lyrics
      lyrics.style.WebkitTransform = lyrics.style.transform = "none" if lyrics
    uu.nextTick -> #{{{3
      if lyrics
        width = 0
        heights = []
        ratio = w / h
  
        colspace = 90
  
        for verse in document.getElementsByClassName "verse"
          width = Math.max(width, verse.offsetWidth)
          heights.push verse.offsetHeight + 30
  
        #{{{4 find best ratio
        bestDiff = 100
        bestLayout = undefined
        colHeight = (verseLengths) -> arraySum verseLengths
        scale = 0
        for i in [0.05..1.05] by 0.05
          layout = splitEven heights, i
          layoutHeight = Math.max.apply null, layout.map colHeight
          layoutWidth = width * layout.length
          layoutRatio = layoutWidth / layoutHeight
          layoutDiff = Math.abs(layoutRatio - ratio)
          if layoutDiff < bestDiff
            bestLayout = layout
            bestDiff = layoutDiff
  
        #{{{4 lay out the verses
        row = 0
        col = 0
        top = 0
        totalHeight = 0
        for verse in document.getElementsByClassName "verse"
          if !bestLayout[col][row]
            ++col; row = 0
            top = 0
          verse.style.position = "absolute"
          verse.style.width = "#{width}px"
          verse.style.top = "#{top}px"
          verse.style.left = "#{col * (width + colspace)}px"
          top += bestLayout[col][row]
          totalHeight = Math.max(totalHeight, top)
          ++row
        totalWidth = (col+1) * width + col * colspace
        #{{{4
        lyrics.style.position = "absolute"
        scale = Math.min(w *.95 / totalWidth, (h - buttonSize) *.95 / (totalHeight))
        lyrics.style.WebkitTransform = lyrics.style.transform = "scale(#{scale})"
        lyrics.style.top = "#{((h - buttonSize)-totalHeight*scale)/2}px"
        lyrics.style.left = "#{(w-totalWidth*scale)/2}px"
      document.body.style.color = "black"
      for elem in document.getElementsByClassName "songButton"
        elem.style.color = "black"
  
  #{{{3 final style
  body:
    font: "#{2*unit|0}px ubuntu,sans-serif"
    lineHeight: "150%"
    color: if isNodeJs then "black" else "white"
  ".notes":
      marginTop: "1em"
      marginBottom: "1em"
  ".button":
    background: "white"
    display: "inline-block"
    color: "black"
    textDecoration: "none"
    width: buttonSize
    height: buttonSize - buttonPadPos*buttonSize
    fontSize: .75 * buttonSize
    marginLeft: .1 * buttonSize
    marginRight: .1 * buttonSize
    marginTop: 0
    marginBottom: 0
    paddingTop: buttonPadPos * buttonSize
    textAlign: "center"
    lineHeight: 0.9 * buttonSize
    border: "#{lineWidth}px solid black"
    borderRadius: buttonSize
  ".verse":
    fontSize: 20
    display: "inline-block"
    lineHeight: "150%"
  ".menu":
    position: "absolute"
    top: (h - buttonSize * 1.1) | 0
    textAlign: "center"
    width: "100%"
    left: 0
  ".songButton":
    display: "inline-block"
    lineHeight: "150%"
    width: sqInner
    margin: 0
    color: if isNodeJs then "black" else "white"
    paddingLeft: sqPadding
    paddingRight: sqPadding
    paddingTop: 0
    paddingBottom: 0
    textAlign: "center"
    textDecoration: "none"
    fontSize: sqSize *.11 | 0
    border: "#{lineWidth}px solid black"
    borderRadius: sqSize * .15 | 0
    verticalAlign: "middle"
  "*":
    WebkitTouchCallout: "none"
    WebkitTextSizeAdjust: "none"
    WebkitTapHighlightColor: "rgba(0,0,0,0)"
    WebkitUserSelect: "none"

if isWindow then uu.onComplete document.ondeviceready = window.onload = -> #{{{2
    navigator.splashscreen?.hide?()
    document.getElementById("style").innerHTML = uu.obj2style style()
if isWindow then window.onresize = ->
  if verseNo == -1
    openHref fname
  else
    gotoVerse verseNo

lyricsJsonml = (song) -> #{{{2
  verseNo = 0
  ["div.lyrics"].concat song.lyrics.map (verse) ->
    ["div.verse", {"data-number": verseNo++}].concat verse.split("\n").map (line) ->
      ["div.line", ["rawhtml", line]]

html = (title, body) -> #{{{2
  "<!DOCTYPE html>" + uu.jsonml2html ["html"
       #manifest: "cache.manifest"
    ["head"
      ["title", title]
      ["meta", {"http-equiv": "Content-Type", content: "text/html;charset=UTF-8"}]
      ["meta", {"http-equiv": "X-UA-Compatible", content: "IE=edge,chrome=1"}]
      ["meta"
        name: "viewport"
        content: "width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"]
      ["script", {src: "bower_components/uutil/uutil.js"}, ""]
      ["script", {src: "frie-sange.js"}, ""]
      ["style", ["rawhtml", "@font-face{font-family:Ubuntu;font-weight:400;src:url(ubuntu-latin1.ttf) format(truetype);}"]]
      ["style#style", ["rawhtml", uu.obj2style style()]]
      ["meta", {name: "format-detection", content: "telephone=no"}]]
    ["body", body]]

navigation = (song) -> #{{{2
  songIdx = songs.indexOf song
  ["div.menu"
      style:
        fontSize: 100
    ["span.button#prev", {href: songs[(songs.length + songIdx - 1) % songs.length].filename}, "<"]
    ["span.button#up", {href: "index.html"}, "···"]
    ["span.button#next", {href: songs[(songIdx + 1) % songs.length].filename}, ">"]]

listenVerse = undefined

fname = location.href.replace(/#.*/, "").split("/").slice(-1)[0] if isWindow
verseNo = -1

if isWindow
  gotoVerse = (n, e) -> #{{{2
    e?.preventDefault()
    for song in songs
      break if song.filename == fname
    return if !song or song.lyrics.length == 1

    uu.log "gotoVerse", n

    if (n == -1) || (n >= song.lyrics.length)
      verseNo = -1
      document.body.innerHTML = uu.jsonml2html ["div", lyricsJsonml(song), navigation(song)]
      listenVerse()
    else
      verseNo = n
      document.body.innerHTML = uu.jsonml2html ["div", lyricsJsonml({lyrics:[song.lyrics[n]]}), navigation(song)]
      uu.domListen document.getElementById("up"), "mousedown touchstart", once -> gotoVerse -1
      uu.domListen document.getElementById("prev"), "mousedown touchstart", once -> gotoVerse +n - 1
      uu.domListen document.getElementById("next"), "mousedown touchstart", once -> gotoVerse +n + 1

    document.getElementById("style").innerHTML = uu.obj2style style()
    false
  


indexPage = ["div"] #{{{2
uu.nextTick ->
  for page in songs
    indexPage.push ["a.songButton",{href: page.filename}, page.title]
    indexPage.push " "
  if isNodeJs #{{{3
    fs.writeFile "index.html", html("Frie Børnesange", indexPage), "utf8"
    fs.writeFile "cache.manifest", "CACHE MANIFEST\n# version #{new Date()}\n" +
      ["index.html", "ubuntu-latin1.ttf", "bower_components/uutil/uutil.js", "frie-sange.js"].concat(songs.map (a) -> a.filename).join "\n"

openHref = (href) -> #{{{2
  href = href.split("/").slice(-1)[0]
  fname = href
  verseNo = -1
  for song in songs
    break if song.filename == href
  console.log href, song.filename
  if song.filename == href
    document.body.innerHTML = uu.jsonml2html ["div", lyricsJsonml(song), navigation(song)]
  else
    document.body.innerHTML = uu.jsonml2html indexPage
  listenVerse()
  document.getElementById("style").innerHTML = uu.obj2style style()


uu.onComplete listenVerse = -> #{{{2 event handlers
  for button in document.getElementsByClassName "songButton"
    uu.domListen button, "mousedown touchstart click", once -> openHref this.href

  for song in songs
    break if song.filename == fname
  songIdx = songs.indexOf song

  uu.domListen document.getElementById("up"), "mousedown touchstart", once ->
    openHref "index.html"
  uu.domListen document.getElementById("prev"), "mousedown touchstart", once ->
    openHref songs[(songs.length + songIdx - 1) % songs.length].filename
  uu.domListen document.getElementById("next"), "mousedown touchstart", once ->
    openHref songs[(songIdx + 1) % songs.length].filename

  for verse in document.getElementsByClassName "verse"
    uu.domListen verse, "mousedown touchstart", once ->
      gotoVerse this.dataset.number



songHTML = (song) -> #{{{2
  html song.title, ["div", lyricsJsonml(song), navigation(song)]
#{{{2

songs = [] #{{{2
song = (title, song) -> #{{{2
  song.title = title
  song.lyrics = song.lyrics.split "\n\n"
  song.filename = "#{uu.urlString song.title}.html"
  songs.push song
  if isNodeJs then uu.nextTick ->
    fs.writeFile song.filename, songHTML song, "utf8"

#{{{1 Actual songs
song "Om Frie Sange", #{{{2
  lyrics: """
    <span style="font-size: 200%">Frie Børnesange</span><br>
    Mange børnesange kan hverken 
    synges offentligt, eller deles med andre 
    på grund af ophavsretslige begrænsninger.

    Dette er en samling af sange 
    der efter min bedste overbevisning 
    ikke længere er dækket af copyright. 
    De er fundet ved for hver sang 
    at gennemsøge sangbøger og internet 
    og finde forskellige udgaver af sangen 
    og sikre der enten ikke er kendt forfatter 
    eller han/hun er død for over 70 år siden.

    Denne app er lavet så den både kan installeres
    på telefoner og tablets samt køre direkt
    i en webbrowser. Der er lavet særligt software
    der tilpasser layout og visning så sangenes layout
    automatisk tilpasses siden. Hvis man klikke på 
    de enkelte vers tilpasses de så de fylder hele siden.

    <span style="font-size: 200%">De enkelte sange</span><br>
    <em>Oppe i Norge</em> er en dansk version 
    af den norske børnesang Oppe i fjeldet. 
    Versionen er en krydsning mellem 
    den danske og den norske traditionelle sang 
    - med ekstra vers tilføjet 
    på samme form som i den norske. 
    De yderligere vers er gendigtet af undertegnede 
    og frigives hermed som public domain (CC0).

    <em>Lille Peter Edderkop</em>
    eksisterer så vidt jeg ved i flere udgaver: 
    der det frie traditionelle vers, der anvendes her 
    men der er også en længere udgave 
    hvor flere vers blev tilføjet i 1948 
    så yderligere vers man støder på 
    udover det traditionelle 
    er typisk under ophavsretslige begrænsninger.
  """

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
    Lange ude i skoven, lå et lille bjerg,
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
