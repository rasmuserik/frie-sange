// Generated by CoffeeScript 1.6.3
(function() {
  var fname, fs, gotoVerse, html, indexPage, isTouch, listenVerse, lyricsJsonml, navigation, onReady, once, openHref, song, songHTML, songs, style, use, uu, verseNo;

  if (typeof isNodeJs === "undefined" || typeof runTest === "undefined") {
    (function() {
      var root;
      root = typeof window === "undefined" ? global : window;
      if (typeof isNodeJs === "undefined") {
        root.isNodeJs = typeof process !== "undefined";
      }
      if (typeof isWindow === "undefined") {
        root.isWindow = typeof window !== "undefined";
      }
      if (typeof isPhoneGap === "undefined") {
        root.isPhoneGap = typeof (typeof document !== "undefined" && document !== null ? document.ondeviceready : void 0) !== "undefined";
      }
      if (typeof runTest === "undefined") {
        return root.runTest = (isNodeJs ? process.argv[2] === "test" : location.hash.slice(1) === "test");
      }
    })();
  }

  use = isWindow ? (function(module) {
    return window[module];
  }) : require;

  onReady = function(fn) {
    if (isWindow) {
      if (document.readystate !== "complete") {
        return fn();
      } else {
        return setTimeout((function() {
          return onReady(fn);
        }), 17);
      }
    }
  };

  uu = use("uutil");

  isTouch = false;

  once = function(fn) {
    var result, run;
    run = true;
    result = void 0;
    return function(e) {
      e.preventDefault();
      if (e.touches) {
        isTouch = true;
      }
      if ((!e.touches) && isTouch) {
        return;
      }
      if (run) {
        run = false;
        fn.call(this);
      }
      return false;
    };
  };

  if (isNodeJs) {
    fs = require("fs");
  }

  style = function() {
    var arraySum, buttonPadPos, buttonSize, h, lineWidth, lyrics, outerMargin, songButton, splitEven, sqCols, sqInner, sqMargin, sqPadding, sqSize, unit, w, _i, _len, _ref;
    if (isNodeJs) {
      w = 960;
      h = 480;
    } else {
      w = window.innerWidth;
      h = window.innerHeight;
    }
    unit = Math.sqrt(w * h) / 100;
    outerMargin = 2 * unit | 0;
    w -= outerMargin * 2;
    h -= outerMargin * 2;
    buttonSize = Math.max(4 * unit, 44);
    buttonPadPos = 0;
    lineWidth = (unit * .2 + 1) | 0;
    sqSize = (w > h ? Math.min(w / 4, h / 3) : Math.min(w / 3, h / 4)) | 0;
    sqMargin = unit | 0;
    sqPadding = unit | 0;
    sqInner = sqSize - (sqMargin + sqPadding + lineWidth) * 2 - 6;
    sqCols = w > h ? 4 : 3;
    if (!isNodeJs) {
      _ref = document.getElementsByClassName("songButton");
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        songButton = _ref[_i];
        songButton.style.paddingTop = songButton.style.paddingBottom = "0px";
      }
      uu.nextTick(function() {
        var i, padding, _j, _len1, _ref1, _results;
        i = 0;
        _ref1 = document.getElementsByClassName("songButton");
        _results = [];
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          songButton = _ref1[_j];
          songButton.style.position = "absolute";
          songButton.style.top = "" + (outerMargin + sqMargin + sqSize * (i / sqCols | 0)) + "px";
          songButton.style.left = "" + (outerMargin + sqMargin + sqSize * (i % sqCols | 0)) + "px";
          padding = (sqSize - songButton.offsetHeight) - 2 * sqMargin;
          songButton.style.paddingTop = (padding * .45 | 0) + "px";
          songButton.style.paddingBottom = (padding * .55 | 0) + "px";
          _results.push(++i);
        }
        return _results;
      });
    }
    arraySum = function(arr) {
      return arr.reduce(function(a, b) {
        return a + b;
      });
    };
    splitEven = function(arr, n) {
      var elem, result, subresult, subtotal, total, _j, _len1;
      total = arraySum(arr);
      subtotal = 0;
      result = [];
      subresult = [];
      for (_j = 0, _len1 = arr.length; _j < _len1; _j++) {
        elem = arr[_j];
        if ((subtotal + elem) > (total * n)) {
          if (subresult.length) {
            result.push(subresult);
          }
          subtotal = elem;
          subresult = [elem];
        } else {
          subresult.push(elem);
          subtotal += elem;
        }
      }
      if (subresult.length) {
        result.push(subresult);
      }
      return result;
    };
    if (!isNodeJs) {
      lyrics = document.getElementsByClassName("lyrics")[0];
      if (lyrics) {
        if (lyrics) {
          lyrics.style.WebkitTransform = lyrics.style.transform = "none";
        }
      }
      uu.nextTick(function() {
        var bestDiff, bestLayout, col, colHeight, colspace, elem, heights, i, layout, layoutDiff, layoutHeight, layoutRatio, layoutWidth, ratio, row, scale, top, totalHeight, totalWidth, verse, width, _j, _k, _l, _len1, _len2, _len3, _m, _ref1, _ref2, _ref3, _results;
        if (lyrics) {
          width = 0;
          heights = [];
          ratio = w / h;
          colspace = 90;
          _ref1 = document.getElementsByClassName("verse");
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            verse = _ref1[_j];
            width = Math.max(width, verse.offsetWidth);
            heights.push(verse.offsetHeight + 30);
          }
          bestDiff = 100;
          bestLayout = void 0;
          colHeight = function(verseLengths) {
            return arraySum(verseLengths);
          };
          scale = 0;
          for (i = _k = 0.05; 0.05 > 0 ? _k <= 1.05 : _k >= 1.05; i = _k += 0.05) {
            layout = splitEven(heights, i);
            layoutHeight = Math.max.apply(null, layout.map(colHeight));
            layoutWidth = width * layout.length;
            layoutRatio = layoutWidth / layoutHeight;
            layoutDiff = Math.abs(layoutRatio - ratio);
            if (layoutDiff < bestDiff) {
              bestLayout = layout;
              bestDiff = layoutDiff;
            }
          }
          row = 0;
          col = 0;
          top = 0;
          totalHeight = 0;
          _ref2 = document.getElementsByClassName("verse");
          for (_l = 0, _len2 = _ref2.length; _l < _len2; _l++) {
            verse = _ref2[_l];
            if (!bestLayout[col][row]) {
              ++col;
              row = 0;
              top = 0;
            }
            verse.style.position = "absolute";
            verse.style.width = "" + width + "px";
            verse.style.top = "" + top + "px";
            verse.style.left = "" + (col * (width + colspace)) + "px";
            top += bestLayout[col][row];
            totalHeight = Math.max(totalHeight, top);
            ++row;
          }
          totalWidth = (col + 1) * width + col * colspace;
          lyrics.style.position = "absolute";
          scale = Math.min(w * .95 / totalWidth, (h - buttonSize) * .95 / totalHeight);
          lyrics.style.WebkitTransform = lyrics.style.transform = "scale(" + scale + ")";
          lyrics.style.top = "" + (((h - buttonSize) - totalHeight * scale) / 2) + "px";
          lyrics.style.left = "" + ((w - totalWidth * scale) / 2) + "px";
        }
        document.body.style.color = "black";
        _ref3 = document.getElementsByClassName("songButton");
        _results = [];
        for (_m = 0, _len3 = _ref3.length; _m < _len3; _m++) {
          elem = _ref3[_m];
          _results.push(elem.style.color = "black");
        }
        return _results;
      });
    }
    return {
      body: {
        font: "" + (2 * unit | 0) + "px ubuntu,sans-serif",
        lineHeight: "150%",
        color: isNodeJs ? "black" : "white"
      },
      ".notes": {
        marginTop: "1em",
        marginBottom: "1em"
      },
      ".button": {
        background: "white",
        display: "inline-block",
        color: "black",
        textDecoration: "none",
        width: buttonSize,
        height: buttonSize - buttonPadPos * buttonSize,
        fontSize: .75 * buttonSize,
        marginLeft: .1 * buttonSize,
        marginRight: .1 * buttonSize,
        marginTop: 0,
        marginBottom: 0,
        paddingTop: buttonPadPos * buttonSize,
        textAlign: "center",
        lineHeight: 0.9 * buttonSize,
        border: "" + lineWidth + "px solid black",
        borderRadius: buttonSize
      },
      ".verse": {
        fontSize: 20,
        display: "inline-block",
        lineHeight: "150%"
      },
      ".menu": {
        position: "absolute",
        top: (h - buttonSize * 1.1) | 0,
        textAlign: "center",
        width: "100%",
        left: 0
      },
      ".songButton": {
        display: "inline-block",
        lineHeight: "150%",
        width: sqInner,
        margin: 0,
        color: isNodeJs ? "black" : "white",
        paddingLeft: sqPadding,
        paddingRight: sqPadding,
        paddingTop: 0,
        paddingBottom: 0,
        textAlign: "center",
        textDecoration: "none",
        fontSize: sqSize * .11 | 0,
        border: "" + lineWidth + "px solid black",
        borderRadius: sqSize * .15 | 0,
        verticalAlign: "middle"
      },
      "*": {
        WebkitTouchCallout: "none",
        WebkitTextSizeAdjust: "none",
        WebkitTapHighlightColor: "rgba(0,0,0,0)",
        WebkitUserSelect: "none"
      }
    };
  };

  if (isWindow) {
    document.ondeviceready = window.onload = function() {
      var _ref;
      if ((_ref = navigator.splashscreen) != null) {
        if (typeof _ref.hide === "function") {
          _ref.hide();
        }
      }
      return document.getElementById("style").innerHTML = uu.obj2style(style());
    };
  }

  if (isWindow) {
    window.onresize = function() {
      if (verseNo === -1) {
        return openHref(fname);
      } else {
        return gotoVerse(verseNo);
      }
    };
  }

  lyricsJsonml = function(song) {
    var verseNo;
    verseNo = 0;
    return ["div.lyrics"].concat(song.lyrics.map(function(verse) {
      return [
        "div.verse", {
          "data-number": verseNo++
        }
      ].concat(verse.split("\n").map(function(line) {
        return ["div.line", ["rawhtml", line]];
      }));
    }));
  };

  html = function(title, body) {
    return "<!DOCTYPE html>" + uu.jsonml2html([
      "html", [
        "head", ["title", title], [
          "meta", {
            "http-equiv": "Content-Type",
            content: "text/html;charset=UTF-8"
          }
        ], [
          "meta", {
            "http-equiv": "X-UA-Compatible",
            content: "IE=edge,chrome=1"
          }
        ], [
          "meta", {
            name: "viewport",
            content: "width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"
          }
        ], [
          "script", {
            src: "bower_components/uutil/uutil.js"
          }, ""
        ], [
          "script", {
            src: "frie-sange.js"
          }, ""
        ], ["style", ["rawhtml", "@font-face{font-family:Ubuntu;font-weight:400;src:url(ubuntu-latin1.ttf) format(truetype);}"]], ["style#style", ["rawhtml", uu.obj2style(style())]], [
          "meta", {
            name: "format-detection",
            content: "telephone=no"
          }
        ]
      ], ["body", body]
    ]);
  };

  navigation = function(song) {
    var songIdx;
    songIdx = songs.indexOf(song);
    return [
      "div.menu", {
        style: {
          fontSize: 100
        }
      }, [
        "span.button#prev", {
          href: songs[(songs.length + songIdx - 1) % songs.length].filename
        }, "<"
      ], [
        "span.button#up", {
          href: "index.html"
        }, "···"
      ], [
        "span.button#next", {
          href: songs[(songIdx + 1) % songs.length].filename
        }, ">"
      ]
    ];
  };

  listenVerse = void 0;

  if (isWindow) {
    fname = location.href.replace(/#.*/, "").split("/").slice(-1)[0];
  }

  verseNo = -1;

  if (isWindow) {
    gotoVerse = function(n, e) {
      var song, _i, _len;
      if (e != null) {
        e.preventDefault();
      }
      for (_i = 0, _len = songs.length; _i < _len; _i++) {
        song = songs[_i];
        if (song.filename === fname) {
          break;
        }
      }
      if (!song || song.lyrics.length === 1) {
        return;
      }
      uu.log("gotoVerse", n);
      if ((n === -1) || (n >= song.lyrics.length)) {
        verseNo = -1;
        document.body.innerHTML = uu.jsonml2html(["div", lyricsJsonml(song), navigation(song)]);
        listenVerse();
      } else {
        verseNo = n;
        document.body.innerHTML = uu.jsonml2html([
          "div", lyricsJsonml({
            lyrics: [song.lyrics[n]]
          }), navigation(song)
        ]);
        uu.domListen(document.getElementById("up"), "mousedown touchstart", once(function() {
          return gotoVerse(-1);
        }));
        uu.domListen(document.getElementById("prev"), "mousedown touchstart", once(function() {
          return gotoVerse(+n - 1);
        }));
        uu.domListen(document.getElementById("next"), "mousedown touchstart", once(function() {
          return gotoVerse(+n + 1);
        }));
      }
      document.getElementById("style").innerHTML = uu.obj2style(style());
      return false;
    };
  }

  indexPage = ["div"];

  uu.nextTick(function() {
    var page, _i, _len;
    for (_i = 0, _len = songs.length; _i < _len; _i++) {
      page = songs[_i];
      indexPage.push([
        "a.songButton", {
          href: page.filename
        }, page.title
      ]);
      indexPage.push(" ");
    }
    if (isNodeJs) {
      fs.writeFile("index.html", html("Frie Børnesange", indexPage), "utf8");
      return fs.writeFile("cache.manifest", ("CACHE MANIFEST\n# version " + (new Date()) + "\n") + ["index.html", "ubuntu-latin1.ttf", "bower_components/uutil/uutil.js", "frie-sange.js"].concat(songs.map(function(a) {
        return a.filename;
      })).join("\n"));
    }
  });

  openHref = function(href) {
    var song, _i, _len;
    href = href.split("/").slice(-1)[0];
    fname = href;
    verseNo = -1;
    for (_i = 0, _len = songs.length; _i < _len; _i++) {
      song = songs[_i];
      if (song.filename === href) {
        break;
      }
    }
    console.log(href, song.filename);
    if (song.filename === href) {
      document.body.innerHTML = uu.jsonml2html(["div", lyricsJsonml(song), navigation(song)]);
    } else {
      document.body.innerHTML = uu.jsonml2html(indexPage);
    }
    listenVerse();
    return document.getElementById("style").innerHTML = uu.obj2style(style());
  };

  uu.onComplete(listenVerse = function() {
    var button, song, songIdx, verse, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _results;
    _ref = document.getElementsByClassName("songButton");
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      button = _ref[_i];
      uu.domListen(button, "mousedown touchstart click", once(function() {
        return openHref(this.href);
      }));
    }
    for (_j = 0, _len1 = songs.length; _j < _len1; _j++) {
      song = songs[_j];
      if (song.filename === fname) {
        break;
      }
    }
    songIdx = songs.indexOf(song);
    uu.domListen(document.getElementById("up"), "mousedown touchstart", once(function() {
      return openHref("index.html");
    }));
    uu.domListen(document.getElementById("prev"), "mousedown touchstart", once(function() {
      return openHref(songs[(songs.length + songIdx - 1) % songs.length].filename);
    }));
    uu.domListen(document.getElementById("next"), "mousedown touchstart", once(function() {
      return openHref(songs[(songIdx + 1) % songs.length].filename);
    }));
    _ref1 = document.getElementsByClassName("verse");
    _results = [];
    for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
      verse = _ref1[_k];
      _results.push(uu.domListen(verse, "mousedown touchstart", once(function() {
        return gotoVerse(this.dataset.number);
      })));
    }
    return _results;
  });

  songHTML = function(song) {
    return html(song.title, ["div", lyricsJsonml(song), navigation(song)]);
  };

  songs = [];

  song = function(title, song) {
    song.title = title;
    song.lyrics = song.lyrics.split("\n\n");
    song.filename = "" + (uu.urlString(song.title)) + ".html";
    songs.push(song);
    if (isNodeJs) {
      return uu.nextTick(function() {
        return fs.writeFile(song.filename, songHTML(song, "utf8"));
      });
    }
  };

  song("Om Frie Sange", {
    lyrics: "<span style=\"font-size: 200%\">Frie Børnesange</span><br>\nMange børnesange kan hverken \nsynges offentligt, eller deles med andre \npå grund af ophavsretslige begrænsninger.\n\nDette er en samling af sange \nder efter min bedste overbevisning \nikke længere er dækket af copyright. \nDe er fundet ved for hver sang \nat gennemsøge sangbøger og internet \nog finde forskellige udgaver af sangen \nog sikre der enten ikke er kendt forfatter \neller han/hun er død for over 70 år siden.\n\nDenne app er lavet så den både kan installeres\npå telefoner og tablets samt køre direkt\ni en webbrowser. Der er lavet særligt software\nder tilpasser layout og visning så sangenes layout\nautomatisk tilpasses siden. Hvis man klikke på \nde enkelte vers tilpasses de så de fylder hele siden.\n\n<span style=\"font-size: 200%\">De enkelte sange</span><br>\n<em>Oppe i Norge</em> er en dansk version \naf den norske børnesang Oppe i fjeldet. \nVersionen er en krydsning mellem \nden danske og den norske traditionelle sang \n- med ekstra vers tilføjet \npå samme form som i den norske. \nDe yderligere vers er gendigtet af undertegnede \nog frigives hermed som public domain (CC0).\n\n<em>Lille Peter Edderkop</em>\neksisterer så vidt jeg ved i flere udgaver: \nder det frie traditionelle vers, der anvendes her \nmen der er også en længere udgave \nhvor flere vers blev tilføjet i 1948 \nså yderligere vers man støder på \nudover det traditionelle \ner typisk under ophavsretslige begrænsninger."
  });

  song("Der sad to katte på et bord", {
    lyrics: "Der sad to katte på et bord\nKritte-ritte-rit bum bum\nDen ene på den anden glor\nKritte-ritte-rit bum bum\nSå sa'e den ene: hør min ven\nKritte-ritte-rit kritte-rit bum bum\nSku' vi ikke kravle ned igen\nKritte-ritte-rit bum bum\n\nOg da de så var kravlet ned\nKritte-ritte-rit bum bum\nSå sa'e den anden: hør min ven\nKritte-ritte-rit bum bum\nSku vi ikke kravle op igen\nKritte-ritte-rit kritte-rit bum bum\nOg så kravlede de op igen\nKritte-ritte-rit bum bum\n\nOg da de så var kravlet op\nKritte-ritte-rit bum bum\nSå sa'e den ene: hør min ven\nKritte-ritte-rit bum bum\nSku vi ikke kravle ned igen\nKritte-ritte-rit kritte-rit bum bum\nOg så kravlede de ned igen\nKritte-ritte-rit bum bum"
  });

  song("En elefant kom marcherende", {
    lyrics: "En elefant kom marcherende\nhen ad eddekoppens fine spind\nsyn's at vejen var så interessant\nat den byder op en anden elefant\n\nTo elefanter kom marcherende\nhen ad eddekoppens fine spind\nsyn's at vejen var så interessant\nat de byder op endnu en elefant\n\nTre elefanter kom marcherende\nhen ad eddekoppens fine spind\nsyn's at vejen var så interessant\nat de byder op endnu en elefant\n\n??? elefanter kom marcherende\nhen ad eddekoppens fine spind\nsyn's at vejen var så interessant\nat de byder op endnu en elefant..."
  });

  song("Lille Peter Edderkop", {
    lyrics: "Lille Peter Edderkop,\n  kravlede op ad muren.\nSå kom regnen\n  og skyllede Peter ned,\nSå kom solen\n  og tørrede Peters krop.\nLille Peter Edderkop\n  kravlede atter op."
  });

  song("Mæ siger det lille lam", {
    lyrics: "Mæ, siger det lille lam,\nmor, jeg fryser, jeg vil hjem!\nMæ, siger det store får,\nvent, til aftenklokken slår\nså skal du nok komme hjem. Mæ!\n\nRap, siger ænderne små,\nnu skal det lystigt hjemad gå.\nSove vi skal, til sol står op,\nså skal i vandet vi pjaske vor krop.\nRap, siger ænderne små. Rap!\n\nMjav, siger den lille kat,\nnu vil jeg sove så sødt i nat.\nI morgen skal vi lege igen,\nfor jeg vil helst lege dagen hen.\nMjav siger den lille kat. Mjav!\n\nPrr, siger den gamle hest,\njeg vil trække som jeg kan bedst.\nGid jeg stod i min varme stald\nog hørte i dag ej flere knald,\nPrrr siger den gamle hest. Prrr!\n\nVov, siger den store hund,\nvåge må jeg endnu en stund,\nfare om og passe på,\nat de trygt til ro kan gå.\nVov, siger den store hund. Vov!"
  });

  song("Ride ride ranke", {
    author: "Nikloaj Ulrik Krossing (1798-1872)",
    composer: "Johan Christian Gebauer (1808-1884)",
    lyrics: "Hop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride ranke!\nGreven er så højt på strå,\nbonden må med træsko gå.\nRide, ride, ranke!\n\nHop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride, ranke!\nJunkren på sin høje hest,\nsom kan danse, ret gør blæst.\nRide, ride, ranke!\n\nHop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride, ranke!\nFrøknen sidder let som fjer,\nsom min lille rytter her.\nRide, ride, ranke!\n\nHop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride, ranke!\nHvorhen skal nu vejen gå?\nBedstefar besøg skal få.\nRide, ride, ranke!\n\nHop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride, ranke!\nOg når vi så stiger af,\nsiger vi: go' da', go' da'!\nRide, ride, ranke!\n\nHop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride, ranke!\nBedstemor af hjertesgrund\ntrykker os et kys på mund.\nRide, ride, ranke!\n\nHop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride, ranke!\nNu til onkel i galop.\nEr han hjemme? Ja, så stop!\nRide, ride, ranke!\n\nHop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride, ranke!\nTantes stuedør vil vi\nheller ikke gå forbi.\nRide, ride, ranke!\n\nHop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride, ranke!\nMen nu er det aftenstid,\nlille hest, i stalden hid!\nRide, ride, ranke!\n\nHop, hop, hop, hop,\nhop, hop, hop, hop!\nRide, ride, ranke!\nTil i morgen stå i ro,\nhavre først: et kys ja to!\nRide, ride, ranke!"
  });

  song("Jeg gik mig over sø og land", {
    lyrics: "Jeg gik mig over sø og land,\nder mødte jeg en gammel mand.\nHan sagde så og spurgte så:\nOg hvor har du så hjemme?\nJeg har hjemme i trampeland,\ntrampeland, trampeland,\nalle de som trampe kan,\nde har hjemme i trampeland.\n\nJeg gik mig over sø og land,\nder mødte jeg en gammel mand.\nHan sagde så og spurgte så:\nOg hvor har du så hjemme?\nJeg har hjemme i vinkeland,\nvinkeland, vinkeland,\nalle de som vinke kan,\nde har hjemme i vinkeland.\n\nJeg gik mig over sø og land,\nder mødte jeg en gammel mand.\nHan sagde så og spurgte så:\nOg hvor har du så hjemme?\nJeg har hjemme i hoppeland,\nhoppeland, hoppeland,\nalle de som hoppe kan,\nde har hjemme i hoppeland.\n\nJeg gik mig over sø og land,\nder mødte jeg en gammel mand.\nHan sagde så og spurgte så:\nOg hvor har du så hjemme?\nJeg har hjemme i klappeland,\nklappeland, klappeland,\nalle de som klappe kan,\nde har hjemme i klappeland.\n\nJeg gik mig over sø og land,\nder mødte jeg en gammel mand.\nHan sagde så og spurgte så:\nOg hvor har du så hjemme?\nJeg har hjemme i hinkeland,\nhinkeland, hinkeland,\nalle de som hinke kan,\nde har hjemme i hinkeland.\n\nJeg gik mig over sø og land,\nder mødte jeg en gammel mand.\nHan sagde så og spurgte så:\nOg hvor har du så hjemme?\nJeg har hjemme i trommeland,\ntrommeland, trommeland,\nalle de som tromme kan,\nde har hjemme i trommeland."
  });

  song("Mester Jakob", {
    lyrics: "Mester Jakob, \nMester Jakob.\nSover du, \nsover du?\nHører du ej klokken, \nhører du ej klokken?\nBim bam bum,\nbim bam bum."
  });

  song("Oppe i Norge der boede tre trolde", {
    lyrics: "Oppe i Norge, der boede tre trolde,\ntroldefar og troldemor og lille olle-bolle \nBØH sagde troldefar\nBøh sagde troldemor\nog den lille olle bolle sagde bare <small>bøh</small>\n\nUde i skoven, der boede tre bjørne,\nbjørnefar og bjørnemor, og lille ørne-børne\nROAR sagde bjørnefar\nRoar sagde bjørnemor\nog den lille ørne-børne sagde bare <small>roar</small>\n\nOppe på loftet, der boede tre katte,\nkattefar og kattemor, og lille katte-batte\nMJAV sagde kattefar\nMjav sagde kattemor\nog den lille katte-batte sagde bare <small>mjav</small>\n\nUde på marken, der boede tre heste,\nhestefar og hestemor, og lille heste-beste\nPRR sagde hestefar\nPrr sagde hestemor\nog den lille heste-beste sagde bare <small>prr</small>\n\nOppe i træet, der boede tre krager,\nkragefar og kragemor, og lille krage-brage\nKRRA sagde kragefar\nKrra sagde kragemor\nog den lille krage-brage sagde bare <small>krra</small>"
  });

  song("Tommelfinger, tommelfinger hvor er du", {
    lyrics: "Tommelfinger, tommelfinger,\nhvor er du?\nHer er jeg, her er jeg\nGoddag, goddag, goddag.\n\nPegefinger, pegefinger,\nhvor er du?\nHer er jeg, her er jeg\nGoddag, goddag, goddag.\n\nLangefinger, langefinger,\nhvor er du?\nHer er jeg, her er jeg\nGoddag, goddag, goddag.\n\nRingefinger, ringefinger,\nhvor er du?\nHer er jeg, her er jeg\nGoddag, goddag, goddag.\n\nLillefinger, lillefinger,\nhvor er du?\nHer er jeg, her er jeg\nGoddag, goddag, goddag.\n\nAlle fingre, alle fingre,\nhvor er I?\nHer er vi, her er vi,\nGoddag, goddag, goddag."
  });

  song("I skoven skulle være gilde", {
    lyrics: "I skoven skulle være gilde\nalt hos den gamle ørn,\nsom jo så gerne ville\nfornøje sine børn.\nOg alle fugle sjunge\nog røre deres tunge,\nså snart som lærken gi'r signal\naf næbbets futteral,\nså snart som lærken gi'r signal\naf næbbets futteral.\n\nAt byde gæster mange\nden hane skulle gå,\nhan havde ben så lange\nmed krumme sporer på.\nHan råbte: \"Kykliky!\"\ntre gange i hver by,\nat byde alle fugle små\ntil ørnens gilde så,\nat byde alle fugle små\ntil ørnens gilde så.\n\nDen tømmermand, hr. spætte,\nhan skulle bygge hus,\nog svalen taget tætte\nmed skovens grønne mos.\nOg salen skulle pyntes,\nhvor gildet skulle stå,\nmed røde sneglehuse\nog fine bolstre blå,\nmed røde sneglehuse\nog fine bolstre blå.\n\nOg ravnen skulle også\nvære deres præst,\nhans sorte kjole viste,\nat han var kaldet næst.\nHan var en højlærd Mand,\nklog over al forstand,\nhan holdt den bedste prædiken,\nder hørtes i vort land,\nhan holdt den bedste prædiken,\nder hørtes i vort land.\n\nOg stæren skulle også\nvære deres degn,\nhan kan så dejlig synge,\nskønt han er meget klejn.\nHans sang den er en lyst,\nhan har en dejlig røst,\nhan er jo ren i mælet\nog dertil let for bryst,\nhan er jo ren i mælet\nog dertil let for bryst.\n\nDe havde og to spillemænd,\nog de var meget små,\ndet var den lille nattergal\nog så den lærke grå.\nDe spilled menuet,\nog det gik nok så net,\ntil alle udi dansen\nvar bleven ganske træt,\ntil alle udi dansen\nvar bleven ganske træt.\n\nOg uglen var til gilde,\nhun drak sig ganske fuld,\nom aftenen så silde\nhun faldt i græs omkuld.\nHun råbte med stor klage:\n\"I alle mine dage,\nja alle mine dage\nstor nød jeg lide må,\nja alle mine dage\nstor nød jeg lide må\".\n\nOg ørnen gik til hende\nog sagde: \"Hør, min ven,\nnår mener du, at du vel\nkan komme dig igen?\"\n\"O ve, o ve, o plage,\njeg kan det godt forstå,\nat mine levedage,\nde er nu ganske få,\nat mine levedage,\nde er nu ganske få\"."
  });

  song("Langt ude i skoven", {
    lyrics: "Lange ude i skoven, lå et lille bjerg,\naldrig så jeg, så dejligt et bjerg:\nBjerget ligger langt ude i skoven.\n\nPå det lille bjerg, der stod et lille træ,\naldrig så jeg så dejligt et træ:\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå det lille træ, der sad en lille gren,\naldrig så jeg så dejlig en gren:\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå den lille gren, der sad en lille kvist,\naldrig så jeg så dejlig en kvist:\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå den lille kvist, der sad et lille blad,\naldrig så jeg så dejligt et blad:\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå det lille blad, der var en lille rede,\naldrig så jeg så dejlig en rede:\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nI den lille rede var et lille æg,\naldrig så jeg så dejligt et æg:\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nAf det lille æg der kom en lille fugl,\naldrig så jeg så dejlig en fugl:\nFuglen af ægget.\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå den lille fugl der sad en lille fjer.\naldrig så jeg så dejlig en fjer:\nFjeren på fuglen.\nFuglen af ægget.\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nAf den lille fjer der blev en lille pude,\naldrig så jeg så dejlig en pude:\nPuden af fjeren.\nFjeren på fuglen.\nFuglen af ægget.\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå den lille pude der lå en lille dreng,\naldrig så jeg så dejlig en dreng:\nDrengen på puden.\nPuden af fjeren.\nFjeren på fuglen.\nFuglen af ægget.\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven."
  });

}).call(this);
