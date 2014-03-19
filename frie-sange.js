// Generated by CoffeeScript 1.6.3
(function() {
  var info, onReady, song, songs, uu;

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

  uu = require("uutil");

  onReady(function() {
    return console.log("HERE");
  });

  songs = {};

  song = function(title, obj) {
    obj.title = title;
    songs[title] = obj;
    return console.log(songs);
  };

  info = ["div", ""];

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
    lyrics: "Mæ, siger det lille lam,\nmor, jeg fryser, jeg vil hjem!\nMæ, siger det store får,\nvent, til aftenklokken slår\nså skal du nok komme hjem. Mæ!\n\nRap, siger ænderne små,\nnu skal det lystigt hjemad gå.\nSove vi skal, til sol står op,\nså skal i vandet vi pjaske vor krop.\nRap, siger ænderne små. Rap!\n\nMjav, siger den lille kat,\nnu vil jeg sove så sødt i nat.\nI morgen skal vi lege igen,\nfor jeg vil helst lege dagen hen.\nMjav siger den lille kat. Mjav!\n\nPrr, siger den gamle hest,\njeg vil trækk som jeg kan bedst.\nGid jeg stod i min varme stald\nog hørte i dag ej flere knald,\nPrrr siger den gamle hest. Prrr!\n\nVov, siger den store hund,\nvåge må jeg endnu en stund,\nfare om og passe på,\nat de trygt til ro kan gå.\nVov, siger den store hund. Vov!"
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
    lyrics: "Lange ude i skoven, der lå et lille bjerg,\naldrig så jeg, så dejligt et bjerg:\nBjerget ligger langt ude i skoven.\n\nPå det lille bjerg, der stod et lille træ,\naldrig så jeg så dejligt et træ:\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå det lille træ, der sad en lille gren,\naldrig så jeg så dejlig en gren:\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå den lille gren, der sad en lille kvist,\naldrig så jeg så dejlig en kvist:\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå den lille kvist, der sad et lille blad,\naldrig så jeg så dejligt et blad:\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå det lille blad, der var en lille rede,\naldrig så jeg så dejlig en rede:\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nI den lille rede var et lille æg,\naldrig så jeg så dejligt et æg:\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nAf det lille æg der kom en lille fugl,\naldrig så jeg så dejlig en fugl:\nFuglen af ægget.\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå den lille fugl der sad en lille fjer.\naldrig så jeg så dejlig en fjer:\nFjeren på fuglen.\nFuglen af ægget.\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nAf den lille fjer der blev en lille pude,\naldrig så jeg så dejlig en pude:\nPuden af fjeren.\nFjeren på fuglen.\nFuglen af ægget.\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven.\n\nPå den lille pude der lå en lille dreng,\naldrig så jeg så dejlig en dreng:\nDrengen på puden.\nPuden af fjeren.\nFjeren på fuglen.\nFuglen af ægget.\nÆgget i reden.\nReden på bladet.\nBladet på kvisten.\nKvisten på grenen.\nGrenen på træet.\nTræet på bjerget.\nBjerget ligger langt ude i skoven."
  });

}).call(this);
