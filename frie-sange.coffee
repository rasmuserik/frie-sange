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

# execute main
onReady = (fn) ->
  if isWindow
    if document.readystate != "complete" then fn() else setTimeout (-> onReady fn), 17 

# {{{1 code
uu = require "uutil"
onReady ->
  console.log "HERE"

songs = {}
song = (title, obj) ->
  obj.title = title
  songs[title] = obj
  console.log songs

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
  ""]
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
    jeg vil trækk som jeg kan bedst.
    Gid jeg stod i min varme stald
    og hørte i dag ej flere knald,
    Prrr siger den gamle hest. Prrr!
    
    Vov, siger den store hund,
    våge må jeg endnu en stund,
    fare om og passe på,
    at de trygt til ro kan gå.
    Vov, siger den store hund. Vov!"""
song "Ride ride ranke", #{{{2
  lyrics: """
     """
song "Jeg gik mig over sø og land", #{{{2
  lyrics: """
     """
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
     """
song "I skoven skulle være gilde", #{{{2
  lyrics: """
     """
song "Langt ude i skoven", #{{{2
  lyrics: """
     """
