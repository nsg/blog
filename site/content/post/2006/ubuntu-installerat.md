+++
date = "2006-05-22T18:07:26+00:00"
title = "Ubuntu &#8211; Installerat"
[taxonomies]
tags = ["ubuntu", "linux", "gnome", "vlc", "totem", "mplayer", "kmplayer", "xine"]
+++

Jag har alltid varit en [gentoo][1]-person, Kört det på både min stationära och laptop.

För några dagar sedan såg jag screenshots på [Ubuntu Dapper Beta][2], normalt sätt gillar jag och ha kontroll på systemet, och ett snabbt opitimerat system (gentoo).

Men sedan jag köppte min laptop så har jag haft två system och underhålla. Tanken jag fick var, det vore kanse skönt och prova om ubuntu hittade att drivrutiner och så själv och all lite spec. laptop-hårdvara funkar från start. Så nu skriver jag detta i ubuntu på laptopen, jag kommer skriva längre fram hur det känns och om jag kommer stanna kvar i det eller gå tillbaka till gentoo.

Installationen var enkel, körde avancerad partionering så jag vet inte hur enkel den skulle kunna ha blivit men jag ville inte att den lilla windowsparten jag har skulle ryka.  
Jag höll på i säkert 20 min och svarade på dialoger men det skulle man säkert kunna få ner till 5 min om man viste direkt vad man gjorde* och inte satt vid två datorer samtidigt :) 

**funderade ett bra tag på hur jag skulle partionera upp optimalt*

Installationen tog upp ca 2GB som är helt ok tycker jag, ett gentoosystem tar under 1GB nyistallerat men det växer fort när man börjar kompilera saker och då är det långt från så många program.  
Men det kom inte som en förvåning då det bara är binärer här och inte fil, källkod, binärer som det blir på gentoo, speciellt om man inte städar lite ibland :) 

Som många vet så kör ubuntu [Gnome][3], betan som jag nu använder kör version 2.14.1.

Vad ska man säga om det jag har provat på hittils, det finns många bra dialoger för att ändra inställnigar men många om dem tillhör gnome och är inte ubunu-spec.

Installationmanagen är helt ok, spec standard är snygg, synd bara att man alltid måste köra avanc. med tanke på att allt inte visas i standard. Det tog ett tag innan jag hittade den dock :) &#8230; hette tydligen &#8220;Add/Remove..&#8221; på &#8220;Applications&#8221;-menyn, rätt logisk när man nu tänker på det man jag fattade det som att det var lägg till/ta bort från menyn och inte program.

Jag vet inte om det är nått som måste ändras för jag har inte hittat programmet [mplayer][4] i paketsystemet, bara enkade varianter som [KMplayer][5] t.ex.

*(2 dagar har gått)*

Jag spenderade en timma igår med att försöka spela en film på datorn, [KMplayer][5] funkade inte, inge felmess, ingen ting alls. Jag hade nu fattat hur jag ska få fram alla paket, tydligen låg inte [mplayer][4] bland dom &#8220;garanterat funkande&#8221; paketen eller nått, jag provade och installera men den klagade på tre bibliotek som fattades SOM VAR INSTALLERADE, satt säkert ett bra tag med det och undersökte, körde även en del manuellt med apt-get men jag kom ingen vart.

Nästa sak jag provade var [xine video player][6], den installerade sig fint men var helt skum när jag förslkte spela upp filmen, varken ljud eller bild.

Slutligen provade jag [vlc][7], och det funkade, hurra! Vet inte om jag är dum nu men så användarvänligt var det inte att få nått som spelade divx/xvid :) 

Notis: Jag försökte få divx/xvid-stödj i [totem][8] player oxå utan att lyckas. Jag är förvånad att det inte fanns stödj från början, typ allt annat man behöver följer ju med tycker jag.

Jag återkommer med mer information längre fram när jag har hittat nått nytt att prisa eller klaga på :) 



<small></small>

 [1]: http://www.gentoo.org
 [2]: http://www.ubuntu.com/testing/dapperbeta
 [3]: http://www.gnome.org
 [4]: http://www.mplayerhq.hu/
 [5]: http://kmplayer.kde.org/
 [6]: http://xinehq.de/
 [7]: http://www.videolan.org/vlc/
 [8]: http://www.gnome.org/projects/totem/
