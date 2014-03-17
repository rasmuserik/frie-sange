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
onReady ->
  console.log "HERE"

songs = {}
song = (title, obj) ->
  obj.title = title
  songs[title] = obj
  console.log songs

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
     """
song "Mæ siger det lille lam", #{{{2
  lyrics: """
     """
song "Ride ride ranke", #{{{2
  lyrics: """
     """
song "Jeg gik mig over sø og land", #{{{2
  lyrics: """
     """
song "Mester Jakob", #{{{2
  lyrics: """
     """
song "Oppe i Norge der boede tre trolde", #{{{2
  lyrics: """
     """
song "Tommelfinger, tommelfinger hvor er du", #{{{2
  lyrics: """
     """
song "I skoven skulle være gilde", #{{{2
  lyrics: """
     """
song "Langt ude i skoven", #{{{2
  lyrics: """
     """
